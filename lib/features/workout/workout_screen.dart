import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../app/layout.dart';
import '../../app/providers.dart';
import '../../app/theme.dart';
import '../../core/format.dart';
import '../../core/models/phase.dart';
import '../../core/models/workout_plan.dart';
import '../../l10n/generated/app_localizations.dart';
import '../library/routine_labels.dart';
import '../music/now_playing_bar.dart';
import 'workout_clock.dart';
import 'workout_controller.dart';

class WorkoutScreen extends ConsumerStatefulWidget {
  const WorkoutScreen({super.key, required this.spec});

  final RoutineSpec spec;

  @override
  ConsumerState<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends ConsumerState<WorkoutScreen> {
  final _focus = FocusNode();

  Color _phaseColor(PhaseKind phase, PulsePalette palette) {
    return switch (phase) {
      PhaseKind.work => palette.accent,
      PhaseKind.rest => palette.rest,
      PhaseKind.prepare => palette.prepare,
      PhaseKind.done => palette.done,
    };
  }

  String _phaseLabel(PhaseKind phase, AppLocalizations l10n) {
    return switch (phase) {
      PhaseKind.work => l10n.work,
      PhaseKind.rest => l10n.rest,
      PhaseKind.prepare => l10n.prepare,
      PhaseKind.done => l10n.done,
    };
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(workoutControllerProvider.notifier).start(widget.spec);
      _focus.requestFocus();
    });
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  KeyEventResult _onKey(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;
    final ctl = ref.read(workoutControllerProvider.notifier);
    if (event.logicalKey == LogicalKeyboardKey.space ||
        event.logicalKey == LogicalKeyboardKey.enter) {
      ctl.togglePause();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.arrowRight) {
      ctl.skip();
      return KeyEventResult.handled;
    }
    if (event.logicalKey == LogicalKeyboardKey.escape) {
      ctl.stop();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final view = ref.watch(workoutControllerProvider);
    final settings = ref.watch(settingsProvider);
    final snap = view.snapshot;
    final color = _phaseColor(snap.phase, palette);
    final totalMs = view.plan?.totalDuration.inMilliseconds ?? 0;
    final sessionProgress =
        totalMs <= 0 ? 0.0 : (snap.elapsed.inMilliseconds / totalMs).clamp(0.0, 1.0);
    final wide = PulseLayout.isWideWorkout(context);

    final clock = Semantics(
      button: true,
      label: snap.isPaused ? l10n.resume : l10n.pause,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => ref.read(workoutControllerProvider.notifier).togglePause(),
          child: WorkoutClock(
            layout: settings.timerLayout,
            snap: snap,
            phaseLabel: _phaseLabel(snap.phase, l10n),
            phaseColor: color,
            exerciseLabel: snap.label,
          ),
        ),
      ),
    );

    final meta = Column(
      children: [
        Text(
          l10n.roundOf(snap.roundIndex, snap.roundCount),
          style: TextStyle(fontSize: 16, color: palette.textMuted),
        ),
        const SizedBox(height: 6),
        Text(
          l10n.totalRemaining(TimeFormat.mmss(snap.totalRemaining)),
          style: TextStyle(color: palette.textMuted),
        ),
        const SizedBox(height: 8),
        Text(
          l10n.tapToPause,
          style: TextStyle(color: palette.textMuted.withValues(alpha: 0.8), fontSize: 12),
        ),
      ],
    );

    final controls = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => ref.read(workoutControllerProvider.notifier).skip(),
              child: Text(l10n.skip),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: FilledButton(
              onPressed: () =>
                  ref.read(workoutControllerProvider.notifier).togglePause(),
              child: Text(snap.isPaused ? l10n.resume : l10n.pause),
            ),
          ),
        ],
      ),
    );

    return Focus(
      focusNode: _focus,
      autofocus: true,
      onKeyEvent: _onKey,
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: PopScope(
          canPop: snap.isFinished || !view.isActive,
          onPopInvokedWithResult: (didPop, _) async {
            if (didPop) {
              await ref.read(workoutControllerProvider.notifier).dismiss();
              return;
            }
            final ok = await _confirmStop(context, l10n);
            if (ok == true && context.mounted) {
              await ref.read(workoutControllerProvider.notifier).stop();
            }
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 280),
            color: Color.lerp(palette.background, color, 0.07),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SafeArea(
                child: snap.isFinished
                    ? const _Done()
                    : Column(
                        children: [
                          SizedBox(
                            height: 2,
                            child: LinearProgressIndicator(
                              value: sessionProgress,
                              minHeight: 2,
                              color: color.withValues(alpha: 0.55),
                              backgroundColor: palette.hairline,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(4, 4, 4, 0),
                            child: Row(
                              children: [
                                IconButton(
                                  tooltip: l10n.stop,
                                  onPressed: () async {
                                    final ok = await _confirmStop(context, l10n);
                                    if (ok == true && context.mounted) {
                                      await ref
                                          .read(workoutControllerProvider.notifier)
                                          .stop();
                                    }
                                  },
                                  icon: const Icon(Icons.close),
                                ),
                                Expanded(
                                  child: Text(
                                    localizedRoutineName(widget.spec, l10n),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      color: palette.textMuted,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  tooltip: l10n.cycleLayout,
                                  onPressed: () {
                                    ref.read(settingsProvider.notifier).setTimerLayout(
                                          nextTimerLayout(settings.timerLayout),
                                        );
                                  },
                                  icon: Icon(timerLayoutIcon(settings.timerLayout)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: wide
                                ? Row(
                                    children: [
                                      Expanded(flex: 3, child: Center(child: clock)),
                                      Expanded(
                                        flex: 2,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            meta,
                                            const SizedBox(height: 28),
                                            controls,
                                          ],
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      const Spacer(),
                                      clock,
                                      const SizedBox(height: 20),
                                      meta,
                                      const Spacer(),
                                      controls,
                                    ],
                                  ),
                          ),
                          const SizedBox(height: 16),
                          const NowPlayingBar(compact: true),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool?> _confirmStop(BuildContext context, AppLocalizations l10n) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.confirmStop),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.stop),
          ),
        ],
      ),
    );
  }
}

class _Done extends ConsumerWidget {
  const _Done();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final palette = context.pulse;
    final elapsed = ref.watch(workoutControllerProvider).snapshot.elapsed;
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        children: [
          const Spacer(),
          Icon(Icons.check_rounded, size: 48, color: palette.done),
          const SizedBox(height: 18),
          Text(
            l10n.finishedTitle,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Text(
            l10n.finishedBody(TimeFormat.pretty(elapsed)),
            style: TextStyle(color: palette.textMuted, fontSize: 16),
          ),
          const Spacer(),
          FilledButton(
            onPressed: () async {
              await ref.read(workoutControllerProvider.notifier).dismiss();
              if (context.mounted) context.go('/');
            },
            child: Text(l10n.backHome),
          ),
        ],
      ),
    );
  }
}
