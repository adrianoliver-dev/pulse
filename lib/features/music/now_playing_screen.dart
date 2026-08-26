import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/format.dart';
import '../../l10n/generated/app_localizations.dart';

class NowPlayingScreen extends ConsumerWidget {
  const NowPlayingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final item = ref.watch(mediaItemProvider).valueOrNull;
    final playback = ref.watch(playbackStateProvider).valueOrNull;
    final position = ref.watch(positionProvider).valueOrNull ?? Duration.zero;
    final queue = ref.watch(queueProvider).valueOrNull ?? const <MediaItem>[];
    final handler = ref.read(audioHandlerProvider);
    final playing = playback?.playing ?? false;
    final duration = item?.duration ?? Duration.zero;
    final maxMs = duration.inMilliseconds <= 0 ? 1 : duration.inMilliseconds;
    final posMs = position.inMilliseconds.clamp(0, maxMs);
    final shuffleOn = playback?.shuffleMode == AudioServiceShuffleMode.all;
    final repeat = playback?.repeatMode ?? AudioServiceRepeatMode.none;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nowPlaying)),
      body: item == null
          ? Center(child: Text(l10n.noSongs))
          : ListView(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: palette.surface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(
                    Icons.album_rounded,
                    size: 72,
                    color: palette.accent,
                  ),
                ),
                const SizedBox(height: 28),
                Text(
                  item.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  item.artist ?? l10n.artistUnknown,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: palette.textMuted, fontSize: 16),
                ),
                const SizedBox(height: 28),
                Slider(
                  value: posMs.toDouble(),
                  max: maxMs.toDouble(),
                  activeColor: palette.accent,
                  onChanged: (v) =>
                      handler.seek(Duration(milliseconds: v.round())),
                ),
                Row(
                  children: [
                    Text(
                      TimeFormat.mmss(position),
                      style: TextStyle(color: palette.textMuted, fontSize: 12),
                    ),
                    const Spacer(),
                    Text(
                      TimeFormat.mmss(duration),
                      style: TextStyle(color: palette.textMuted, fontSize: 12),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      tooltip: l10n.shuffleOn,
                      onPressed: () => handler.setShuffleMode(
                        shuffleOn
                            ? AudioServiceShuffleMode.none
                            : AudioServiceShuffleMode.all,
                      ),
                      icon: Icon(
                        Icons.shuffle_rounded,
                        color: shuffleOn ? palette.accent : palette.textMuted,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.previous,
                      onPressed: handler.skipToPrevious,
                      icon: const Icon(Icons.skip_previous_rounded, size: 36),
                    ),
                    FilledButton(
                      onPressed: playing ? handler.pause : handler.play,
                      style: FilledButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(18),
                      ),
                      child: Icon(
                        playing
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        size: 36,
                      ),
                    ),
                    IconButton(
                      tooltip: l10n.next,
                      onPressed: handler.skipToNext,
                      icon: const Icon(Icons.skip_next_rounded, size: 36),
                    ),
                    IconButton(
                      tooltip: switch (repeat) {
                        AudioServiceRepeatMode.one => l10n.repeatOne,
                        AudioServiceRepeatMode.all ||
                        AudioServiceRepeatMode.group =>
                          l10n.repeatAll,
                        _ => l10n.repeatOff,
                      },
                      onPressed: () {
                        final next = switch (repeat) {
                          AudioServiceRepeatMode.none =>
                            AudioServiceRepeatMode.all,
                          AudioServiceRepeatMode.all ||
                          AudioServiceRepeatMode.group =>
                            AudioServiceRepeatMode.one,
                          _ => AudioServiceRepeatMode.none,
                        };
                        handler.setRepeatMode(next);
                      },
                      icon: Icon(
                        repeat == AudioServiceRepeatMode.one
                            ? Icons.repeat_one_rounded
                            : Icons.repeat_rounded,
                        color: repeat == AudioServiceRepeatMode.none
                            ? palette.textMuted
                            : palette.accent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Text(
                  l10n.nowPlayingQueue,
                  style: TextStyle(
                    color: palette.textMuted,
                    letterSpacing: 1.1,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                for (var i = 0; i < queue.length; i++)
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(
                      queue[i].id == item.id
                          ? Icons.equalizer_rounded
                          : Icons.music_note_outlined,
                      color: queue[i].id == item.id
                          ? palette.accent
                          : palette.textMuted,
                    ),
                    title: Text(
                      queue[i].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      queue[i].artist ?? l10n.artistUnknown,
                      maxLines: 1,
                      style: TextStyle(color: palette.textMuted),
                    ),
                    onTap: () => handler.skipToQueueItem(i),
                  ),
              ],
            ),
    );
  }
}
