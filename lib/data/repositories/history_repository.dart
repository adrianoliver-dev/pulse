import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../db/app_database.dart';

class HistoryRepository {
  HistoryRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<WorkoutHistoryData>> watchAll() {
    return (_db.select(_db.workoutHistory)
          ..orderBy([(t) => OrderingTerm.desc(t.endedAt)]))
        .watch();
  }

  Future<void> add({
    required String routineId,
    required String routineName,
    required DateTime startedAt,
    required DateTime endedAt,
    required int durationSeconds,
    required bool completed,
  }) {
    return _db.into(_db.workoutHistory).insert(
          WorkoutHistoryCompanion.insert(
            id: _uuid.v4(),
            routineId: routineId,
            routineName: routineName,
            startedAt: startedAt,
            endedAt: endedAt,
            durationSeconds: durationSeconds,
            completed: completed,
          ),
        );
  }
}
