import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../l10n/generated/app_localizations.dart';

class NowPlayingBar extends ConsumerWidget {
  const NowPlayingBar({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(mediaItemProvider).valueOrNull;
    final playback = ref.watch(playbackStateProvider).valueOrNull;
    final position = ref.watch(positionProvider).valueOrNull ?? Duration.zero;
    if (item == null) return const SizedBox.shrink();
    final l10n = AppLocalizations.of(context);
    final playing = playback?.playing ?? false;
    final handler = ref.read(audioHandlerProvider);

    final palette = context.pulse;
    return Material(
      color: palette.surface,
      child: InkWell(
        onTap: () => context.push('/now-playing'),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            LinearProgressIndicator(
              value: _progress(item.duration, position),
              minHeight: 2,
              backgroundColor: palette.hairline,
              color: palette.accent,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: compact ? 8 : 10,
              ),
              child: Row(
                children: [
                  Icon(Icons.music_note_outlined, color: palette.accent, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          item.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: palette.text,
                          ),
                        ),
                        Text(
                          item.artist ?? l10n.artistUnknown,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: palette.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.previous,
                    onPressed: handler.skipToPrevious,
                    icon: const Icon(Icons.skip_previous_rounded),
                  ),
                  IconButton(
                    tooltip: playing ? l10n.pause : l10n.play,
                    onPressed: playing ? handler.pause : handler.play,
                    icon: Icon(
                      playing ? Icons.pause_rounded : Icons.play_arrow_rounded,
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.next,
                    onPressed: handler.skipToNext,
                    icon: const Icon(Icons.skip_next_rounded),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  double? _progress(Duration? duration, Duration position) {
    final total = duration?.inMilliseconds ?? 0;
    if (total <= 0) return null;
    return (position.inMilliseconds / total).clamp(0.0, 1.0);
  }
}
