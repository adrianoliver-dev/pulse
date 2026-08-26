import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/engine/plan_builder.dart';
import '../../core/format.dart';
import '../../core/models/phase.dart';
import '../../core/models/workout_plan.dart';
import '../../data/repositories/routine_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../../widgets/duration_stepper.dart';
import 'routine_labels.dart';

class EditorScreen extends ConsumerStatefulWidget {
  const EditorScreen({super.key, this.initial});

  final RoutineSpec? initial;

  @override
  ConsumerState<EditorScreen> createState() => _EditorScreenState();
}

class _EditorScreenState extends ConsumerState<EditorScreen> {
  late RoutineSpec _spec;
  late final TextEditingController _name;
  late final TextEditingController _exercise;

  @override
  void initState() {
    super.initState();
    _spec = widget.initial ??
        RoutineSpec(
          id: RoutineRepository.newId(),
          name: '',
          mode: WorkoutMode.series,
          prepareSeconds: 10,
          workSeconds: 60,
          restSeconds: 30,
          rounds: 3,
        );
    _name = TextEditingController(text: widget.initial?.name ?? '');
    _exercise = TextEditingController(text: widget.initial?.exerciseLabel ?? '');
  }

  @override
  void dispose() {
    _name.dispose();
    _exercise.dispose();
    super.dispose();
  }

  Future<void> _save({bool start = false}) async {
    final l10n = AppLocalizations.of(context);
    var spec = _spec.copyWith(
      name: _name.text.trim().isEmpty ? l10n.untitled : _name.text.trim(),
      exerciseLabel: _exercise.text.trim().isEmpty ? null : _exercise.text.trim(),
      updatedAt: DateTime.now(),
    );
    if (spec.mode == WorkoutMode.custom &&
        spec.custom.where((c) => c.kind == PhaseKind.work && c.seconds > 0).isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.cannotStart)));
      return;
    }
    await ref.read(routineRepositoryProvider).save(spec);
    if (!mounted) return;
    if (start) {
      context.pushReplacement('/workout/${spec.id}');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l10n.saved)));
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final playlists = ref.watch(playlistsProvider).valueOrNull ?? [];
    final isNew = widget.initial == null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? l10n.newRoutine : l10n.editRoutine),
        actions: [
          if (widget.initial != null && !widget.initial!.isPreset)
            IconButton(
              tooltip: l10n.delete,
              onPressed: () async {
                final ok = await showDialog<bool>(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text(l10n.deleteRoutine),
                    actions: [
                      TextButton(onPressed: () => Navigator.pop(ctx, false), child: Text(l10n.cancel)),
                      TextButton(onPressed: () => Navigator.pop(ctx, true), child: Text(l10n.delete)),
                    ],
                  ),
                );
                if (ok == true && context.mounted) {
                  await ref.read(routineRepositoryProvider).delete(_spec.id);
                  if (context.mounted) context.pop();
                }
              },
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: PulsePage(
        child: ListView(
          padding: EdgeInsets.zero,
        children: [
          TextField(
            controller: _name,
            decoration: InputDecoration(
              labelText: l10n.nameLabel,
              hintText: localizedRoutineName(_spec, l10n),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _exercise,
            decoration: InputDecoration(
              labelText: l10n.exerciseLabel,
              hintText: l10n.exerciseHint,
            ),
          ),
          const SizedBox(height: 20),
          Text(l10n.modeLabel, style: TextStyle(color: context.pulse.textMuted)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final mode in WorkoutMode.values)
                ChoiceChip(
                  label: Text(switch (mode) {
                    WorkoutMode.series => l10n.modeSeries,
                    WorkoutMode.tabata => l10n.modeTabata,
                    WorkoutMode.hiit => l10n.modeHiit,
                    WorkoutMode.custom => l10n.modeCustom,
                  }),
                  selected: _spec.mode == mode,
                  onSelected: (_) {
                    setState(() {
                      _spec = _spec.copyWith(
                        mode: mode,
                        workSeconds: switch (mode) {
                          WorkoutMode.tabata => 20,
                          WorkoutMode.hiit => 40,
                          _ => _spec.workSeconds,
                        },
                        restSeconds: switch (mode) {
                          WorkoutMode.tabata => 10,
                          WorkoutMode.hiit => 20,
                          _ => _spec.restSeconds,
                        },
                        rounds: switch (mode) {
                          WorkoutMode.tabata => 8,
                          WorkoutMode.hiit => 8,
                          _ => _spec.rounds,
                        },
                        custom: mode == WorkoutMode.custom && _spec.custom.isEmpty
                            ? const [
                                CustomSegment(kind: PhaseKind.work, seconds: 60),
                                CustomSegment(kind: PhaseKind.rest, seconds: 30),
                                CustomSegment(kind: PhaseKind.work, seconds: 60),
                              ]
                            : _spec.custom,
                      );
                    });
                  },
                ),
            ],
          ),
          const SizedBox(height: 24),
          _SummaryCard(spec: _spec),
          const SizedBox(height: 20),
          _Labeled(
            l10n.prepareTime,
            DurationStepper(
              seconds: _spec.prepareSeconds,
              onChanged: (v) => setState(() => _spec = _spec.copyWith(prepareSeconds: v)),
              quickValues: const [0, 5, 10],
            ),
          ),
          if (_spec.mode != WorkoutMode.custom) ...[
            _Labeled(
              l10n.rounds,
              CountStepper(
                value: _spec.rounds,
                onChanged: (v) => setState(() => _spec = _spec.copyWith(rounds: v)),
              ),
            ),
            _Labeled(
              l10n.workTime,
              DurationStepper(
                seconds: _spec.workSeconds,
                min: 5,
                onChanged: (v) => setState(() => _spec = _spec.copyWith(workSeconds: v)),
                quickValues: kQuickDurations,
              ),
            ),
            _Labeled(
              l10n.restTime,
              DurationStepper(
                seconds: _spec.restSeconds,
                onChanged: (v) => setState(() => _spec = _spec.copyWith(restSeconds: v)),
                quickValues: kQuickDurations,
              ),
            ),
          ] else ...[
            ..._spec.custom.asMap().entries.map((e) {
              final i = e.key;
              final seg = e.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: context.pulse.surface,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Wrap(
                              spacing: 8,
                              children: [
                                ChoiceChip(
                                  label: Text(l10n.segmentWork),
                                  selected: seg.kind == PhaseKind.work,
                                  onSelected: (_) {
                                    final next = [..._spec.custom];
                                    next[i] = CustomSegment(
                                      kind: PhaseKind.work,
                                      seconds: seg.seconds,
                                      label: seg.label,
                                    );
                                    setState(() => _spec = _spec.copyWith(custom: next));
                                  },
                                ),
                                ChoiceChip(
                                  label: Text(l10n.segmentRest),
                                  selected: seg.kind == PhaseKind.rest,
                                  onSelected: (_) {
                                    final next = [..._spec.custom];
                                    next[i] = CustomSegment(
                                      kind: PhaseKind.rest,
                                      seconds: seg.seconds,
                                      label: seg.label,
                                    );
                                    setState(() => _spec = _spec.copyWith(custom: next));
                                  },
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              final next = [..._spec.custom]..removeAt(i);
                              setState(() => _spec = _spec.copyWith(custom: next));
                            },
                            icon: const Icon(Icons.close),
                          ),
                        ],
                      ),
                      DurationStepper(
                        seconds: seg.seconds,
                        min: 5,
                        quickValues: kQuickDurations,
                        onChanged: (v) {
                          final next = [..._spec.custom];
                          next[i] = CustomSegment(kind: seg.kind, seconds: v, label: seg.label);
                          setState(() => _spec = _spec.copyWith(custom: next));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }),
            OutlinedButton.icon(
              onPressed: () {
                setState(() {
                  _spec = _spec.copyWith(
                    custom: [
                      ..._spec.custom,
                      const CustomSegment(kind: PhaseKind.work, seconds: 30),
                    ],
                  );
                });
              },
              icon: const Icon(Icons.add),
              label: Text(l10n.addSegment),
            ),
          ],
          const SizedBox(height: 16),
          DropdownButtonFormField<String?>(
            initialValue: _spec.playlistId,
            decoration: InputDecoration(labelText: l10n.playlist),
            items: [
              DropdownMenuItem(value: null, child: Text(l10n.noPlaylist)),
              ...playlists.map(
                (p) => DropdownMenuItem(value: p.id, child: Text(p.name)),
              ),
            ],
            onChanged: (id) => setState(
              () => _spec = _spec.copyWith(playlistId: id, clearPlaylist: id == null),
            ),
          ),
          const SizedBox(height: 28),
          FilledButton(
            onPressed: () => _save(start: true),
            child: Text(l10n.saveAndStart),
          ),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () => _save(),
            child: Text(l10n.save),
          ),
        ],
      ),
      ),
    );
  }
}

class _Labeled extends StatelessWidget {
  const _Labeled(this.label, this.child);
  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: context.pulse.textMuted)),
          const SizedBox(height: 8),
          child,
        ],
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.spec});

  final RoutineSpec spec;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final plan = PlanBuilder.fromSpec(spec);
    final headline = spec.mode == WorkoutMode.custom
        ? l10n.customSummary(plan.workCount)
        : l10n.sessionSummary(
            spec.rounds,
            TimeFormat.pretty(Duration(seconds: spec.workSeconds)),
            TimeFormat.pretty(Duration(seconds: spec.restSeconds)),
          );
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headline,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600, height: 1.3),
          ),
          const SizedBox(height: 6),
          Text(
            l10n.sessionTotal(TimeFormat.pretty(plan.totalDuration)),
            style: TextStyle(color: palette.accent, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
