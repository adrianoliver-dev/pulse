import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/models/phase.dart';
import '../../core/models/workout_plan.dart';
import '../db/app_database.dart';

const presetPushupsId = 'preset-pushups';
const presetTabataId = 'preset-tabata';
const presetHiitId = 'preset-hiit';
const presetSprintId = 'preset-sprint';

class RoutineRepository {
  RoutineRepository(this._db);

  final AppDatabase _db;
  static const _uuid = Uuid();

  Stream<List<Routine>> watchAll() {
    return (_db.select(_db.routines)
          ..orderBy([
            (t) => OrderingTerm.desc(t.isPreset),
            (t) => OrderingTerm.desc(t.updatedAt),
          ]))
        .watch();
  }

  Future<List<Routine>> getAll() => _db.select(_db.routines).get();

  Future<Routine?> getById(String id) {
    return (_db.select(_db.routines)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> seedPresets() async {
    final existing = await getAll();
    final ids = existing.map((r) => r.id).toSet();
    final now = DateTime.now();

    Future<void> put(RoutineSpec spec) async {
      if (ids.contains(spec.id)) return;
      await save(spec);
    }

    await put(
      RoutineSpec(
        id: presetPushupsId,
        name: 'Push-ups 3×1:00',
        mode: WorkoutMode.series,
        prepareSeconds: 10,
        workSeconds: 60,
        restSeconds: 30,
        rounds: 3,
        exerciseLabel: 'Push-ups',
        isPreset: true,
        updatedAt: now,
      ),
    );
    await put(
      RoutineSpec(
        id: presetTabataId,
        name: 'Tabata 20/10',
        mode: WorkoutMode.tabata,
        prepareSeconds: 5,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
        isPreset: true,
        updatedAt: now,
      ),
    );
    await put(
      RoutineSpec(
        id: presetHiitId,
        name: 'HIIT 40/20',
        mode: WorkoutMode.hiit,
        prepareSeconds: 10,
        workSeconds: 40,
        restSeconds: 20,
        rounds: 8,
        isPreset: true,
        updatedAt: now,
      ),
    );
    await put(
      RoutineSpec(
        id: presetSprintId,
        name: '10×5/10',
        mode: WorkoutMode.series,
        prepareSeconds: 5,
        workSeconds: 5,
        restSeconds: 10,
        rounds: 10,
        isPreset: true,
        updatedAt: now,
      ),
    );
  }

  Future<void> save(RoutineSpec spec) {
    final companion = RoutinesCompanion(
      id: Value(spec.id),
      name: Value(spec.name),
      mode: Value(spec.mode.name),
      prepareSeconds: Value(spec.prepareSeconds),
      workSeconds: Value(spec.workSeconds),
      restSeconds: Value(spec.restSeconds),
      rounds: Value(spec.rounds),
      roundRestSeconds: Value(spec.roundRestSeconds),
      exerciseLabel: Value(spec.exerciseLabel),
      playlistId: Value(spec.playlistId),
      customSegmentsJson: Value(
        spec.custom.isEmpty
            ? null
            : jsonEncode(spec.custom.map((c) => c.toJson()).toList()),
      ),
      isPreset: Value(spec.isPreset),
      updatedAt: Value(spec.updatedAt ?? DateTime.now()),
    );
    return _db.into(_db.routines).insertOnConflictUpdate(companion);
  }

  Future<void> delete(String id) {
    return (_db.delete(_db.routines)..where((t) => t.id.equals(id))).go();
  }

  static String newId() => _uuid.v4();

  static RoutineSpec toSpec(Routine row) {
    final custom = <CustomSegment>[];
    final raw = row.customSegmentsJson;
    if (raw != null && raw.isNotEmpty) {
      final list = jsonDecode(raw) as List<dynamic>;
      for (final item in list) {
        if (item is Map) {
          custom.add(CustomSegment.fromJson(Map<String, dynamic>.from(item)));
        }
      }
    }
    return RoutineSpec(
      id: row.id,
      name: row.name,
      mode: WorkoutMode.values.firstWhere(
        (m) => m.name == row.mode,
        orElse: () => WorkoutMode.series,
      ),
      prepareSeconds: row.prepareSeconds,
      workSeconds: row.workSeconds,
      restSeconds: row.restSeconds,
      rounds: row.rounds,
      roundRestSeconds: row.roundRestSeconds,
      exerciseLabel: row.exerciseLabel,
      playlistId: row.playlistId,
      custom: custom,
      isPreset: row.isPreset,
      updatedAt: row.updatedAt,
    );
  }
}
