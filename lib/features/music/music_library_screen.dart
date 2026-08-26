import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/format.dart';
import '../../l10n/generated/app_localizations.dart';
import 'device_library.dart';

class MusicLibraryScreen extends ConsumerStatefulWidget {
  const MusicLibraryScreen({super.key});

  @override
  ConsumerState<MusicLibraryScreen> createState() => _MusicLibraryScreenState();
}

class _MusicLibraryScreenState extends ConsumerState<MusicLibraryScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _search = TextEditingController();
  String _query = '';
  bool _hideShort = true;

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
    _search.addListener(() => setState(() => _query = _search.text.trim().toLowerCase()));
  }

  @override
  void dispose() {
    _tabs.dispose();
    _search.dispose();
    super.dispose();
  }

  Future<void> _playSongs(
    List<DeviceSong> songs, {
    int index = 0,
    bool shuffle = false,
  }) async {
    final items = songs
        .map(
          (s) => MediaItem(
            id: s.id,
            title: s.title,
            artist: s.artist.isEmpty ? 'Lejos' : s.artist,
            duration: Duration(milliseconds: s.durationMs),
            extras: {'uri': s.uri},
          ),
        )
        .toList();
    final handler = ref.read(audioHandlerProvider);
    await handler.loadQueue(items, index: index, autoplay: true);
    await handler.setShuffleMode(
      shuffle ? AudioServiceShuffleMode.all : AudioServiceShuffleMode.none,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final library = ref.watch(deviceLibraryProvider);
    final playlists = ref.watch(playlistsProvider).valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navMusic),
        bottom: TabBar(
          controller: _tabs,
          indicatorColor: context.pulse.accent,
          labelColor: context.pulse.accent,
          unselectedLabelColor: context.pulse.textMuted,
          tabs: [
            Tab(text: l10n.songs),
            Tab(text: l10n.playlists),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          library.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('$e')),
            data: (data) {
              if (!data.granted) {
                return EmptyState(
                  icon: Icons.library_music_outlined,
                  title: l10n.permissionMusicTitle,
                  body: l10n.permissionMusicBody,
                  action: Column(
                    children: [
                      FilledButton(
                        onPressed: () =>
                            ref.read(deviceLibraryProvider.notifier).request(),
                        child: Text(l10n.allowAccess),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton(
                        onPressed: () async {
                          final files =
                              await ref.read(deviceLibraryProvider.notifier).pickFiles();
                          if (files.isNotEmpty) await _playSongs(files);
                        },
                        child: Text(l10n.pickFiles),
                      ),
                    ],
                  ),
                );
              }
              final filtered = data.songs.where((s) {
                final matches = _query.isEmpty ||
                    s.title.toLowerCase().contains(_query) ||
                    s.artist.toLowerCase().contains(_query);
                if (!matches) return false;
                if (_hideShort && !s.isLikelyMusic) return false;
                return true;
              }).toList();
              final songs = filtered;
              final hidden = _hideShort
                  ? data.songs.where((s) => !s.isLikelyMusic).length
                  : 0;
              if (kIsWeb && songs.isEmpty) {
                return EmptyState(
                  icon: Icons.library_music_outlined,
                  title: l10n.noSongs,
                  body: l10n.webDemoHint,
                  action: FilledButton(
                    onPressed: () async {
                      final files =
                          await ref.read(deviceLibraryProvider.notifier).pickFiles();
                      if (files.isNotEmpty) await _playSongs(files);
                    },
                    child: Text(l10n.pickFiles),
                  ),
                );
              }
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                    child: TextField(
                      controller: _search,
                      decoration: InputDecoration(
                        hintText: l10n.searchSongs,
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: songs.isEmpty ? null : () => _playSongs(songs),
                            child: Text(l10n.playAll),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton(
                            onPressed: songs.isEmpty
                                ? null
                                : () => _playSongs(songs, shuffle: true),
                            child: Text(l10n.shuffle),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                    child: Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () async {
                              final files = await ref
                                  .read(deviceLibraryProvider.notifier)
                                  .pickFiles();
                              if (files.isNotEmpty) await _playSongs(files);
                            },
                            child: Text(l10n.pickFiles),
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilterChip(
                          label: Text(
                            _hideShort ? l10n.filterShort : l10n.showAllSongs,
                          ),
                          selected: _hideShort,
                          onSelected: (v) => setState(() => _hideShort = v),
                        ),
                      ],
                    ),
                  ),
                  if (hidden > 0)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
                      child: Text(
                        l10n.hiddenJunk(hidden),
                        style: TextStyle(
                          color: context.pulse.textMuted,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: songs.isEmpty
                        ? Center(child: Text(l10n.noSongs))
                        : ListView.builder(
                            itemCount: songs.length,
                            itemBuilder: (context, i) {
                              final song = songs[i];
                              return ListTile(
                                title: Text(song.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                                subtitle: Text(
                                  [
                                    song.artist.isEmpty
                                        ? l10n.artistUnknown
                                        : song.artist,
                                    if (song.durationMs > 0)
                                      TimeFormat.mmss(
                                        Duration(milliseconds: song.durationMs),
                                      ),
                                  ].join('  ·  '),
                                  style: TextStyle(color: context.pulse.textMuted),
                                ),
                                onTap: () => _playSongs(songs, index: i),
                                onLongPress: () => _addToPlaylist(song),
                                trailing: IconButton(
                                  tooltip: l10n.addToPlaylist,
                                  icon: const Icon(Icons.playlist_add),
                                  onPressed: () => _addToPlaylist(song),
                                ),
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
          playlists.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(28),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(l10n.emptyPlaylists, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: () =>
                              context.push('/coach?mode=playlist'),
                          icon: const Icon(Icons.auto_awesome),
                          label: Text(l10n.aiMix),
                        ),
                      ],
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: playlists.length,
                  itemBuilder: (context, i) {
                    final p = playlists[i];
                    return ListTile(
                      title: Text(p.name),
                      leading: Icon(Icons.queue_music, color: context.pulse.accent),
                      trailing: IconButton(
                        tooltip: l10n.playAll,
                        icon: const Icon(Icons.play_arrow_rounded),
                        onPressed: () => _playPlaylist(p.id),
                      ),
                      onTap: () => context.push('/playlist/${p.id}'),
                    );
                  },
                ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton.extended(
            heroTag: 'pulse-ai-mix',
            onPressed: () => context.push('/coach?mode=playlist'),
            backgroundColor: context.pulse.surfaceHigh,
            foregroundColor: context.pulse.accent,
            icon: const Icon(Icons.auto_awesome),
            label: Text(l10n.aiMix),
          ),
          const SizedBox(height: 10),
          FloatingActionButton.extended(
            heroTag: 'pulse-new-playlist',
            onPressed: _createPlaylist,
            backgroundColor: context.pulse.accent,
            foregroundColor: context.pulse.background,
            icon: const Icon(Icons.add),
            label: Text(l10n.createPlaylist),
          ),
        ],
      ),
    );
  }

  Future<void> _playPlaylist(String playlistId) async {
    final tracks =
        await ref.read(playlistRepositoryProvider).tracks(playlistId);
    if (tracks.isEmpty) return;
    final items = tracks
        .map(
          (t) => MediaItem(
            id: t.id,
            title: t.title,
            artist: t.artist.isEmpty ? 'Lejos' : t.artist,
            duration: Duration(milliseconds: t.durationMs),
            extras: {'uri': t.uri},
          ),
        )
        .toList();
    await ref.read(audioHandlerProvider).loadQueue(items, autoplay: true);
  }

  Future<void> _createPlaylist() async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.createPlaylist),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: InputDecoration(labelText: l10n.playlistName),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: Text(l10n.cancel)),
          TextButton(
            onPressed: () => Navigator.pop(ctx, controller.text.trim()),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
    if (name == null || name.isEmpty) return;
    final id = await ref.read(playlistRepositoryProvider).create(name);
    if (mounted) context.push('/playlist/$id');
  }

  Future<void> _addToPlaylist(DeviceSong song) async {
    final l10n = AppLocalizations.of(context);
    final playlists = ref.read(playlistsProvider).valueOrNull ?? [];
    if (playlists.isEmpty) {
      await _createPlaylist();
      return;
    }
    final id = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: context.pulse.surface,
      builder: (ctx) => ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(l10n.addToPlaylist, style: const TextStyle(fontWeight: FontWeight.w600)),
          ),
          ...playlists.map(
            (p) => ListTile(
              title: Text(p.name),
              onTap: () => Navigator.pop(ctx, p.id),
            ),
          ),
        ],
      ),
    );
    if (id == null) return;
    await ref.read(playlistRepositoryProvider).addTrack(
          playlistId: id,
          uri: song.uri,
          title: song.title,
          artist: song.artist,
          durationMs: song.durationMs,
        );
  }
}
