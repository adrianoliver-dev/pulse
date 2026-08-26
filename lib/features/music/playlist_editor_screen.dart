import 'package:audio_service/audio_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../l10n/generated/app_localizations.dart';

class PlaylistEditorScreen extends ConsumerWidget {
  const PlaylistEditorScreen({super.key, required this.playlistId});

  final String playlistId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final playlists = ref.watch(playlistsProvider).valueOrNull ?? [];
    final playlist = playlists.where((p) => p.id == playlistId).firstOrNull;
    final tracksAsync = ref.watch(playlistTracksProvider(playlistId));

    return Scaffold(
      appBar: AppBar(
        title: Text(playlist?.name ?? l10n.playlists),
        actions: [
          IconButton(
            tooltip: l10n.delete,
            onPressed: () async {
              await ref.read(playlistRepositoryProvider).delete(playlistId);
              if (context.mounted) Navigator.pop(context);
            },
            icon: const Icon(Icons.delete_outline),
          ),
        ],
      ),
      body: tracksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (tracks) {
          if (tracks.isEmpty) {
            return Center(child: Text(l10n.emptyPlaylists));
          }
          return ReorderableListView.builder(
            itemCount: tracks.length,
            onReorderItem: (from, to) async {
              final ids = tracks.map((t) => t.id).toList();
              final item = ids.removeAt(from);
              ids.insert(to, item);
              await ref.read(playlistRepositoryProvider).reorder(playlistId, ids);
            },
            itemBuilder: (context, i) {
              final t = tracks[i];
              return ListTile(
                key: ValueKey(t.id),
                title: Text(t.title),
                subtitle: Text(
                  t.artist.isEmpty ? l10n.artistUnknown : t.artist,
                  style: TextStyle(color: context.pulse.textMuted),
                ),
                onTap: () async {
                  final items = tracks
                      .map(
                        (track) => MediaItem(
                          id: track.id,
                          title: track.title,
                          artist: track.artist.isEmpty ? 'Lejos' : track.artist,
                          duration: Duration(milliseconds: track.durationMs),
                          extras: {'uri': track.uri},
                        ),
                      )
                      .toList();
                  await ref
                      .read(audioHandlerProvider)
                      .loadQueue(items, index: i, autoplay: true);
                },
                trailing: IconButton(
                  tooltip: l10n.removeTrack,
                  icon: const Icon(Icons.close),
                  onPressed: () =>
                      ref.read(playlistRepositoryProvider).removeTrack(t.id),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: FilledButton(
          onPressed: () async {
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
          },
          child: Text(l10n.playAll),
        ),
      ),
    );
  }
}
