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
  return localizedNameForId(spec.id, spec.name, l10n);
}

String localizedNameForId(String id, String fallbackName, AppLocalizations l10n) {
  return switch (id) {
    presetPushupsId => l10n.presetPushups,
    presetTabataId => l10n.presetTabata,
    presetHiitId => l10n.presetHiit,
    presetSprintId => l10n.presetSprint,
    presetEmomId => l10n.presetEmom,
    presetBoxId => l10n.presetBox,
    presetCoreId => l10n.presetCore,
    presetWarmupId => l10n.presetWarmup,
    presetLongHiitId => l10n.presetLongHiit,
    presetRunId => l10n.presetRun,
    presetStrengthId => l10n.presetStrength,
    presetPyramidId => l10n.presetPyramid,
    presetStretchId => l10n.presetStretch,
    _ => fallbackName.isEmpty ? l10n.untitled : fallbackName,
  };
}

const kPresetHomeOrder = [
  presetSprintId,
  presetTabataId,
  presetHiitId,
  presetEmomId,
  presetBoxId,
  presetCoreId,
  presetWarmupId,
  presetLongHiitId,
  presetRunId,
  presetStrengthId,
  presetPyramidId,
  presetStretchId,
  presetPushupsId,
];

List<RoutineSpec> orderedPresets(Iterable<RoutineSpec> presets) {
  final copy = presets.toList();
  int rank(RoutineSpec spec) {
    final i = kPresetHomeOrder.indexOf(spec.id);
    return i < 0 ? 99 : i;
  }

  copy.sort((a, b) => rank(a).compareTo(rank(b)));
  return copy;
}

RoutineSpec featuredRoutine(List<RoutineSpec> specs, String? lastId) {
  if (lastId != null) {
    for (final spec in specs) {
      if (spec.id == lastId) return spec;
    }
  }
  for (final spec in specs) {
    if (spec.id == presetSprintId) return spec;
  }
  return specs.first;
}
