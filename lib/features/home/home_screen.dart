import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/models/workout_plan.dart';
import '../../core/streak.dart';
import '../../data/repositories/routine_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../library/routine_labels.dart';
import '../streak/streak_card.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final routinesAsync = ref.watch(routinesProvider);
    final lastId = ref.watch(settingsProvider).lastRoutineId;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
          IconButton(
            tooltip: l10n.coachTitle,
            onPressed: () => context.push('/coach'),
            icon: const Icon(Icons.auto_awesome),
          ),
          IconButton(
            tooltip: l10n.newRoutine,
            onPressed: () => context.push('/editor'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: routinesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('$e')),
        data: (routines) {
          if (routines.isEmpty) {
            return EmptyState(
              icon: Icons.timer_outlined,
              title: l10n.noRoutines,
              body: l10n.emptyRoutinesBody,
              action: FilledButton(
                onPressed: () => context.push('/editor'),
                child: Text(l10n.newRoutine),
              ),
            );
          }
          final specs = routines.map(RoutineRepository.toSpec).toList();
          final featured = featuredRoutine(specs, lastId);
          final presets = orderedPresets(specs.where((s) => s.isPreset));
          final custom = specs.where((s) => !s.isPreset).toList();
          final featuredIsLast = lastId != null && featured.id == lastId;
          final historyRows = ref.watch(historyProvider).valueOrNull ?? [];
          final streak = StreakStats.fromEvents(
            historyRows.map(
              (r) => StreakEvent(
                endedAt: r.endedAt,
                completed: r.completed,
                durationSeconds: r.durationSeconds,
              ),
            ),
          );
          final sectionStyle = TextStyle(
            fontSize: 13,
            letterSpacing: 1.2,
            fontWeight: FontWeight.w600,
            color: palette.textMuted,
          );

          return PulsePage(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Text(
                  l10n.tagline,
                  style: TextStyle(color: palette.textMuted, fontSize: 16),
                ),
                const SizedBox(height: 20),
                StreakCard(
                  stats: streak,
                  onTap: () => context.go('/history'),
                ),
                const SizedBox(height: 12),
                _CoachCard(),
                const SizedBox(height: 24),
                _FeaturedCard(spec: featured, isLastSession: featuredIsLast),
                const SizedBox(height: 28),
                Text(l10n.presets, style: sectionStyle),
                const SizedBox(height: 12),
                _PresetGrid(presets: presets),
                if (custom.isNotEmpty) ...[
                  const SizedBox(height: 28),
                  Text(l10n.yourRoutines, style: sectionStyle),
                  const SizedBox(height: 12),
                  ...custom.map((spec) => _RoutineTile(spec: spec)),
                ] else ...[
                  const SizedBox(height: 28),
                  Text(l10n.yourRoutines, style: sectionStyle),
                  const SizedBox(height: 12),
                  OutlinedButton.icon(
                    onPressed: () => context.push('/editor'),
                    icon: const Icon(Icons.add),
                    label: Text(l10n.newRoutine),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CoachCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    return Material(
      color: palette.surface,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => context.push('/coach'),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Row(
            children: [
              Icon(Icons.auto_awesome, color: palette.accent),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.coachTitle,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.coachSubtitle,
                      style: TextStyle(color: palette.textMuted, fontSize: 13),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: palette.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.spec, required this.isLastSession});

  final RoutineSpec spec;
  final bool isLastSession;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: palette.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isLastSession ? l10n.featuredLast : l10n.featuredReady,
            style: TextStyle(
              fontSize: 13,
              letterSpacing: 1.2,
              fontWeight: FontWeight.w600,
              color: palette.textMuted,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            localizedRoutineName(spec, l10n),
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          Text(
            routineTimingLine(spec),
            style: TextStyle(color: palette.textMuted),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.workoutMusicHint,
            style: TextStyle(color: palette.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: FilledButton(
                  onPressed: () => context.push('/workout/${spec.id}'),
                  child: Text(l10n.start),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push('/editor', extra: spec),
                  child: Text(l10n.edit),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PresetGrid extends StatelessWidget {
  const _PresetGrid({required this.presets});

  final List<RoutineSpec> presets;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final twoCol = constraints.maxWidth >= 340;
        final chipW = twoCol ? (constraints.maxWidth - 10) / 2 : constraints.maxWidth;
        return Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final spec in presets) _PresetChip(spec: spec, width: chipW),
          ],
        );
      },
    );
  }
}

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.spec, required this.width});

  final RoutineSpec spec;
  final double width;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final name = localizedRoutineName(spec, l10n);
    return SizedBox(
      width: width,
      height: 132,
      child: Material(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => context.push('/workout/${spec.id}'),
          child: Semantics(
            button: true,
            label: '$name. ${l10n.tapToStart}',
            child: Padding(
              padding: const EdgeInsets.fromLTRB(14, 10, 6, 14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.play_arrow_rounded, color: palette.accent, size: 22),
                      const Spacer(),
                      IconButton(
                        tooltip: l10n.edit,
                        visualDensity: VisualDensity.compact,
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(minWidth: 36, minHeight: 36),
                        icon: Icon(Icons.edit_outlined, size: 18, color: palette.textMuted),
                        onPressed: () => context.push('/editor', extra: spec),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Text(
                    name,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    routineTimingLine(spec),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: palette.textMuted, fontSize: 11),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _RoutineTile extends StatelessWidget {
  const _RoutineTile({required this.spec});

  final RoutineSpec spec;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        tileColor: palette.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(localizedRoutineName(spec, l10n)),
        subtitle: Text(
          routineTimingLine(spec),
          style: TextStyle(color: palette.textMuted),
        ),
        trailing: IconButton(
          tooltip: l10n.edit,
          icon: Icon(Icons.edit_outlined, color: palette.textMuted),
          onPressed: () => context.push('/editor', extra: spec),
        ),
        leading: Icon(Icons.play_arrow_rounded, color: palette.accent),
        onTap: () => context.push('/workout/${spec.id}'),
      ),
    );
  }
}
