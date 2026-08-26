import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

class PlaylistRepository {
  PlaylistRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<Playlist>> watchAll() {
    return (_db.select(_db.playlists)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]))
        .watch();
  }

  Future<Playlist?> getById(String id) {
    return (_db.select(_db.playlists)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<PlaylistTrack>> tracks(String playlistId) {
    return (_db.select(_db.playlistTracks)
          ..where((t) => t.playlistId.equals(playlistId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .get();
  }

  Stream<List<PlaylistTrack>> watchTracks(String playlistId) {
    return (_db.select(_db.playlistTracks)
          ..where((t) => t.playlistId.equals(playlistId))
          ..orderBy([(t) => OrderingTerm.asc(t.sortOrder)]))
        .watch();
  }

  Future<String> create(String name) async {
    final id = _uuid.v4();
    await _db.into(_db.playlists).insert(
          PlaylistsCompanion.insert(
            id: id,
            name: name,
            createdAt: DateTime.now(),
          ),
        );
    return id;
  }

  Future<void> rename(String id, String name) {
    return (_db.update(_db.playlists)..where((t) => t.id.equals(id))).write(
      PlaylistsCompanion(name: Value(name)),
    );
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.playlistTracks)..where((t) => t.playlistId.equals(id)))
        .go();
    await (_db.delete(_db.playlists)..where((t) => t.id.equals(id))).go();
  }

  Future<void> addTrack({
    required String playlistId,
    required String uri,
    required String title,
    String artist = '',
    int durationMs = 0,
  }) async {
    final existing = await tracks(playlistId);
    await _db.into(_db.playlistTracks).insert(
          PlaylistTracksCompanion.insert(
            id: _uuid.v4(),
            playlistId: playlistId,
            uri: uri,
            title: title,
            artist: Value(artist),
            durationMs: Value(durationMs),
            sortOrder: existing.length,
          ),
        );
  }

  Future<void> removeTrack(String trackId) {
    return (_db.delete(_db.playlistTracks)..where((t) => t.id.equals(trackId)))
        .go();
  }

  Future<void> reorder(String playlistId, List<String> trackIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < trackIds.length; i++) {
        await (_db.update(_db.playlistTracks)
              ..where((t) => t.id.equals(trackIds[i])))
            .write(PlaylistTracksCompanion(sortOrder: Value(i)));
      }
    });
  }
}
