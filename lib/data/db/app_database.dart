import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'app_database.g.dart';

class Routines extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get mode => text()();
  IntColumn get prepareSeconds => integer()();
  IntColumn get workSeconds => integer()();
  IntColumn get restSeconds => integer()();
  IntColumn get rounds => integer()();
  IntColumn get roundRestSeconds => integer().withDefault(const Constant(0))();
  TextColumn get exerciseLabel => text().nullable()();
  TextColumn get playlistId => text().nullable()();
  TextColumn get customSegmentsJson => text().nullable()();
  BoolColumn get isPreset => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class Playlists extends Table {
  TextColumn get id => text()();
  TextColumn get name => text()();
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PlaylistTracks extends Table {
  TextColumn get id => text()();
  TextColumn get playlistId => text()();
  TextColumn get uri => text()();
  TextColumn get title => text()();
  TextColumn get artist => text().withDefault(const Constant(''))();
  IntColumn get durationMs => integer().withDefault(const Constant(0))();
  IntColumn get sortOrder => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class WorkoutHistory extends Table {
  TextColumn get id => text()();
  TextColumn get routineId => text()();
  TextColumn get routineName => text()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get endedAt => dateTime()();
  IntColumn get durationSeconds => integer()();
  BoolColumn get completed => boolean()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

@DriftDatabase(tables: [Routines, Playlists, PlaylistTracks, WorkoutHistory])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? executor]) : super(executor ?? _open());

  static QueryExecutor _open() {
    return driftDatabase(
      name: 'pulse',
      // Required on Flutter web. Native platforms ignore these URIs.
      // Absolute paths so path-URL routes like /settings still load WASM.
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('/sqlite3.wasm'),
        driftWorker: Uri.parse('/drift_worker.js'),
      ),
    );
  }

  @override
  int get schemaVersion => 1;
}
