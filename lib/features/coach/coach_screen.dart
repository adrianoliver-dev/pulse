import 'package:cross_file/cross_file.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

import '../../ai/coach_plan.dart';
import '../../ai/gemini_coach.dart';
import '../../ai/gemini_key.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../features/library/routine_labels.dart';
import '../../l10n/generated/app_localizations.dart';
import '../music/device_library.dart';

enum _CoachFocus { today, week, playlist }

class CoachScreen extends ConsumerStatefulWidget {
  const CoachScreen({super.key, this.playlistMode = false});

  final bool playlistMode;

  @override
  ConsumerState<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends ConsumerState<CoachScreen> {
  final _text = TextEditingController();
  AudioRecorder? _recorder;
  _CoachFocus _focus = _CoachFocus.today;
  bool _recording = false;
  bool _busy = false;
  Uint8List? _audio;
  List<CoachRoutine> _routines = const [];
  PlaylistPick? _playlist;

  @override
  void initState() {
    super.initState();
    if (widget.playlistMode) _focus = _CoachFocus.playlist;
  }

  @override
  void dispose() {
    _text.dispose();
    _recorder?.dispose();
    super.dispose();
  }

  String _key() {
    final pasted = ref.read(settingsProvider).geminiUserKey?.trim() ?? '';
    if (pasted.isNotEmpty) return pasted;
    return geminiApiKey;
  }

  String _prompt(AppLocalizations l10n) {
    final extra = _text.text.trim();
    return switch (_focus) {
      _CoachFocus.today =>
        'Arma UNA rutina para HOY. ${extra.isEmpty ? 'HIIT o intervalos de unos 15-25 min.' : extra}',
      _CoachFocus.week =>
        'Arma un plan semanal (una rutina por día). ${extra.isEmpty ? 'Mezcla HIIT, fuerza y un día más suave.' : extra}',
      _CoachFocus.playlist =>
        extra.isEmpty ? 'Arma un mix de mis mejores canciones para entrenar.' : extra,
    };
  }

  Future<void> _toggleRecord() async {
    final l10n = AppLocalizations.of(context);
    if (_recording) {
      final path = await _recorder?.stop();
      Uint8List? bytes;
      if (path != null && path.isNotEmpty) {
        bytes = await XFile(path).readAsBytes();
      }
      setState(() {
        _recording = false;
        _audio = bytes;
      });
      return;
    }
    if (kIsWeb) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.coachVoiceHint)),
      );
      return;
    }
    final allowed = await Permission.microphone.request();
    if (!allowed.isGranted) return;
    final dir = await getTemporaryDirectory();
    final path = '${dir.path}/lejos_coach.m4a';
    _recorder ??= AudioRecorder();
    await _recorder!.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: path,
    );
    setState(() {
      _recording = true;
      _audio = null;
    });
  }

  Future<void> _generate() async {
    final l10n = AppLocalizations.of(context);
    final key = _key();
    if (key.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.coachNeedKey)),
      );
      return;
    }
    setState(() => _busy = true);
    try {
      final coach = GeminiCoach(key);
      if (_focus == _CoachFocus.playlist) {
        final library = ref.read(deviceLibraryProvider).valueOrNull;
        if (library == null || !library.granted || library.songs.isEmpty) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.coachNeedMusic)),
            );
          }
          return;
        }
        final catalog = library.songs.where(isLikelyMusic).toList();
        final pick = await coach.buildPlaylist(
          request: _prompt(l10n),
          library: catalog.isEmpty ? library.songs : catalog,
        );
        if (mounted) setState(() => _playlist = pick);
      } else {
        final routines = await coach.buildRoutines(
          request: _prompt(l10n),
          audioBytes: _audio,
        );
        if (mounted) setState(() => _routines = routines);
      }
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.coachError)),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _saveRoutine(
    CoachRoutine item, {
    bool start = false,
    bool notify = true,
  }) async {
    final l10n = AppLocalizations.of(context);
    var spec = item.spec;
    if (item.dayLabel.isNotEmpty &&
        !spec.name.toLowerCase().contains(item.dayLabel.toLowerCase())) {
      spec = spec.copyWith(name: '${item.dayLabel} · ${spec.name}');
    }
    await ref.read(routineRepositoryProvider).save(spec);
    if (!mounted) return;
    if (notify) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.coachSavedRoutines)),
      );
    }
    if (start) context.push('/workout/${spec.id}');
  }

  Future<void> _saveAll() async {
    final l10n = AppLocalizations.of(context);
    for (final item in _routines) {
      await _saveRoutine(item, notify: false);
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.coachSavedRoutines)),
    );
  }

  Future<void> _savePlaylist() async {
    final l10n = AppLocalizations.of(context);
    final pick = _playlist;
    if (pick == null || pick.songs.isEmpty) return;
    final id = await ref.read(playlistRepositoryProvider).create(pick.name);
    for (final song in pick.songs) {
      await ref.read(playlistRepositoryProvider).addTrack(
            playlistId: id,
            uri: song.uri,
            title: song.title,
            artist: song.artist,
            durationMs: song.durationMs,
          );
    }
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.coachSavedPlaylist)),
    );
    context.push('/playlist/$id');
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final settings = ref.watch(settingsProvider);
    final pasted = settings.geminiUserKey?.trim() ?? '';
    final ready = pasted.isNotEmpty || geminiApiKey.isNotEmpty;

    return Scaffold(
      backgroundColor: palette.background,
      appBar: AppBar(title: Text(l10n.coachTitle)),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 32),
          children: [
            Text(
              l10n.coachSubtitle,
              style: TextStyle(color: palette.textMuted, height: 1.4),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              children: [
                ChoiceChip(
                  label: Text(l10n.coachToday),
                  selected: _focus == _CoachFocus.today,
                  onSelected: (_) => setState(() => _focus = _CoachFocus.today),
                ),
                ChoiceChip(
                  label: Text(l10n.coachWeek),
                  selected: _focus == _CoachFocus.week,
                  onSelected: (_) => setState(() => _focus = _CoachFocus.week),
                ),
                ChoiceChip(
                  label: Text(l10n.coachPlaylist),
                  selected: _focus == _CoachFocus.playlist,
                  onSelected: (_) =>
                      setState(() => _focus = _CoachFocus.playlist),
                ),
              ],
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _text,
              minLines: 3,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: _focus == _CoachFocus.playlist
                    ? l10n.coachHintPlaylist
                    : l10n.coachHint,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: _busy ? null : _toggleRecord,
                  icon: Icon(_recording ? Icons.stop : Icons.mic_none),
                  label: Text(
                    _recording ? l10n.coachStopRecord : l10n.coachRecord,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: FilledButton(
                    onPressed: _busy || !ready ? null : _generate,
                    child: _busy
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.coachGenerate),
                  ),
                ),
              ],
            ),
            if (_audio != null && !_recording) ...[
              const SizedBox(height: 8),
              Text(
                l10n.coachVoiceHint,
                style: TextStyle(color: palette.textMuted, fontSize: 13),
              ),
            ],
            if (!ready) ...[
              const SizedBox(height: 16),
              Text(l10n.coachNeedKey, style: TextStyle(color: palette.textMuted)),
            ],
            const SizedBox(height: 24),
            if (_focus == _CoachFocus.playlist) ...[
              if (_playlist == null)
                Text(l10n.coachEmpty, style: TextStyle(color: palette.textMuted))
              else ...[
                Text(
                  _playlist!.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                for (final song in _playlist!.songs)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(song.title),
                    subtitle: Text(
                      song.artist.isEmpty ? l10n.artistUnknown : song.artist,
                      style: TextStyle(color: palette.textMuted),
                    ),
                  ),
                const SizedBox(height: 8),
                FilledButton(
                  onPressed: _savePlaylist,
                  child: Text(l10n.coachSaveAll),
                ),
              ],
            ] else ...[
              if (_routines.isEmpty)
                Text(l10n.coachEmpty, style: TextStyle(color: palette.textMuted))
              else ...[
                if (_routines.length > 1)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: OutlinedButton(
                      onPressed: _saveAll,
                      child: Text(l10n.coachSaveAll),
                    ),
                  ),
                const SizedBox(height: 8),
                for (final item in _routines)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: palette.surface,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (item.dayLabel.isNotEmpty)
                          Text(
                            item.dayLabel.toUpperCase(),
                            style: TextStyle(
                              color: palette.accent,
                              letterSpacing: 1.1,
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        const SizedBox(height: 4),
                        Text(
                          item.spec.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          routineTimingLine(item.spec),
                          style: TextStyle(color: palette.textMuted),
                        ),
                        if (item.note.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            item.note,
                            style: TextStyle(color: palette.textMuted, height: 1.35),
                          ),
                        ],
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () => _saveRoutine(item),
                                child: Text(l10n.coachSaveOne),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: FilledButton(
                                onPressed: () =>
                                    _saveRoutine(item, start: true),
                                child: Text(l10n.coachStartThis),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
