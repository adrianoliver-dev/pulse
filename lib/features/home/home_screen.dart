import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/models/workout_plan.dart';
import '../../data/repositories/routine_repository.dart';
import '../../l10n/generated/app_localizations.dart';
import '../library/routine_labels.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final routinesAsync = ref.watch(routinesProvider);
    final lastId = ref.watch(settingsProvider).lastRoutineId;
    final sectionStyle = TextStyle(
      fontSize: 13,
      letterSpacing: 1.2,
      fontWeight: FontWeight.w600,
      color: palette.textMuted,
    );
    final expanded = PulseLayout.isExpanded(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.appTitle),
        actions: [
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
          final featured = specs.cast<RoutineSpec?>().firstWhere(
                (s) => s!.id == lastId,
                orElse: () => specs.first,
              )!;
          final presets = specs.where((s) => s.isPreset).toList();
          final custom = specs.where((s) => !s.isPreset).toList();

          return PulsePage(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Text(
                  l10n.tagline,
                  style: TextStyle(color: palette.textMuted, fontSize: 16),
                ),
                const SizedBox(height: 24),
                _FeaturedCard(spec: featured),
                const SizedBox(height: 28),
                Text(l10n.presets, style: sectionStyle),
                const SizedBox(height: 12),
                if (expanded)
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      for (final spec in presets) _PresetChip(spec: spec, wide: true),
                    ],
                  )
                else
                  SizedBox(
                    height: 144,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: presets.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 10),
                      itemBuilder: (context, i) => _PresetChip(spec: presets[i]),
                    ),
                  ),
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

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.spec});

  final RoutineSpec spec;

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
            l10n.lastSession,
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
                  onPressed: () => context.push('/workout', extra: spec),
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

class _PresetChip extends StatelessWidget {
  const _PresetChip({required this.spec, this.wide = false});

  final RoutineSpec spec;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    return SizedBox(
      width: wide ? 188 : 168,
      height: 136,
      child: Material(
        color: palette.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => context.push('/workout', extra: spec),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 10, 6, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.bolt, color: palette.accent, size: 18),
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
                  localizedRoutineName(spec, l10n),
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
          tooltip: l10n.start,
          icon: Icon(Icons.play_arrow_rounded, color: palette.accent),
          onPressed: () => context.push('/workout', extra: spec),
        ),
        onTap: () => context.push('/editor', extra: spec),
      ),
    );
  }
}
