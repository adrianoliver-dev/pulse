import '../../core/engine/plan_builder.dart';
import '../../core/format.dart';
import '../../core/models/phase.dart';
import '../../core/models/workout_plan.dart';
import '../../data/repositories/routine_repository.dart';
import '../../l10n/generated/app_localizations.dart';

String routineTimingLine(RoutineSpec spec) {
  final plan = PlanBuilder.fromSpec(spec);
  final work = plan.segments.where((s) => s.kind == PhaseKind.work);
  final workDur = work.isEmpty ? Duration.zero : work.first.duration;
  final restSeg = plan.segments.where((s) => s.kind == PhaseKind.rest);
  final restDur = restSeg.isEmpty ? Duration.zero : restSeg.first.duration;
  if (spec.mode == WorkoutMode.custom) {
    return '${plan.workCount} × ${TimeFormat.pretty(workDur)}  ·  ${TimeFormat.pretty(plan.totalDuration)}';
  }
  return '${spec.rounds} × ${TimeFormat.pretty(workDur)} / ${TimeFormat.pretty(restDur)}  ·  ${TimeFormat.pretty(plan.totalDuration)}';
}

String localizedRoutineName(RoutineSpec spec, AppLocalizations l10n) {
  return switch (spec.id) {
    presetPushupsId => l10n.presetPushups,
    presetTabataId => l10n.presetTabata,
    presetHiitId => l10n.presetHiit,
    presetSprintId => l10n.presetSprint,
    _ => spec.name.isEmpty ? l10n.untitled : spec.name,
  };
}
