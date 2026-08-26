import '../models/phase.dart';
import '../models/workout_plan.dart';

class PlanBuilder {
  PlanBuilder._();

  static WorkoutPlan fromSpec(RoutineSpec spec) {
    final segments = <WorkoutSegment>[];
    final label = spec.exerciseLabel ?? '';

    void addPrepare({required int roundCount, required int workCount}) {
      if (spec.prepareSeconds <= 0) return;
      segments.add(
        WorkoutSegment(
          kind: PhaseKind.prepare,
          duration: Duration(seconds: spec.prepareSeconds),
          label: label,
          roundIndex: 1,
          roundCount: roundCount,
          workIndex: 0,
          workCount: workCount,
        ),
      );
    }

    if (spec.mode == WorkoutMode.custom) {
      final custom = spec.custom.where((c) => c.seconds > 0).toList();
      final workCount = custom.where((c) => c.kind == PhaseKind.work).length;
      addPrepare(roundCount: workCount == 0 ? 1 : workCount, workCount: workCount);
      var workIndex = 0;
      for (final c in custom) {
        if (c.kind == PhaseKind.work) workIndex++;
        final idx = workIndex == 0 ? 1 : workIndex;
        segments.add(
          WorkoutSegment(
            kind: c.kind,
            duration: Duration(seconds: c.seconds),
            label: c.label.isEmpty ? label : c.label,
            roundIndex: idx,
            roundCount: workCount == 0 ? 1 : workCount,
            workIndex: workIndex,
            workCount: workCount,
          ),
        );
      }
    } else {
      final rounds = spec.rounds.clamp(1, 99);
      final workSeconds = spec.workSeconds.clamp(1, 99 * 60);
      addPrepare(roundCount: rounds, workCount: rounds);
      for (var i = 1; i <= rounds; i++) {
        segments.add(
          WorkoutSegment(
            kind: PhaseKind.work,
            duration: Duration(seconds: workSeconds),
            label: label,
            roundIndex: i,
            roundCount: rounds,
            workIndex: i,
            workCount: rounds,
          ),
        );
        final isLast = i == rounds;
        if (!isLast && spec.restSeconds > 0) {
          segments.add(
            WorkoutSegment(
              kind: PhaseKind.rest,
              duration: Duration(seconds: spec.restSeconds),
              label: label,
              roundIndex: i,
              roundCount: rounds,
              workIndex: i,
              workCount: rounds,
            ),
          );
        }
      }
    }

    if (segments.isEmpty) {
      segments.add(
        WorkoutSegment(
          kind: PhaseKind.work,
          duration: const Duration(seconds: 60),
          label: label,
          roundIndex: 1,
          roundCount: 1,
          workIndex: 1,
          workCount: 1,
        ),
      );
    }

    return WorkoutPlan(
      id: spec.id,
      name: spec.name,
      segments: List.unmodifiable(segments),
      playlistId: spec.playlistId,
    );
  }
}
