import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/models/phase.dart';
import 'package:pulse/core/models/workout_plan.dart';
import 'package:pulse/data/repositories/routine_repository.dart';
import 'package:pulse/features/library/routine_labels.dart';

void main() {
  RoutineSpec spec(String id, {bool preset = true}) {
    return RoutineSpec(
      id: id,
      name: id,
      mode: WorkoutMode.series,
      isPreset: preset,
    );
  }

  test('first visit features 10x5/10, not buried push-ups', () {
    final specs = [
      spec(presetPushupsId),
      spec(presetTabataId),
      spec(presetHiitId),
      spec(presetSprintId),
    ];
    expect(featuredRoutine(specs, null).id, presetSprintId);
    expect(featuredRoutine(specs, presetTabataId).id, presetTabataId);
  });

  test('home preset order puts sprint and tabata first', () {
    final ordered = orderedPresets([
      spec(presetPushupsId),
      spec(presetHiitId),
      spec(presetSprintId),
      spec(presetTabataId),
    ]);
    expect(ordered.map((s) => s.id).toList(), [
      presetSprintId,
      presetTabataId,
      presetHiitId,
      presetPushupsId,
    ]);
  });

  test('saving a preset creates a separate user routine', () {
    final preset = spec(presetTabataId);
    final copy = RoutineRepository.asUserRoutine(preset, 'Mi Tabata');
    expect(copy.id, isNot(preset.id));
    expect(copy.isPreset, isFalse);
    expect(copy.name, 'Mi Tabata');
  });
}
