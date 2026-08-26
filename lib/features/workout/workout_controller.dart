import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

import '../../app/providers.dart';
import '../../core/engine/plan_builder.dart';
import '../../core/engine/workout_engine.dart';
import '../../core/format.dart';
import '../../core/models/phase.dart';
import '../../core/models/workout_plan.dart';
import '../../core/models/workout_snapshot.dart';
import '../music/audio_handler.dart';
import '../music/music_policy.dart';

class WorkoutViewState {
  const WorkoutViewState({
    required this.snapshot,
    this.plan,
    this.startedAt,
  });

  final WorkoutSnapshot snapshot;
  final WorkoutPlan? plan;
  final DateTime? startedAt;

  bool get isActive =>
      plan != null &&
      (snapshot.isRunning || snapshot.isPaused || snapshot.isFinished);
}

class WorkoutController extends Notifier<WorkoutViewState> {
  WorkoutEngine? _engine;
  Timer? _timer;
  PhaseKind? _lastPhase;
  int _lastSegment = -1;
  int _lastCountdown = -1;
  bool _historySaved = false;
  DateTime? _startedAt;

  @override
  WorkoutViewState build() {
    ref.onDispose(_tearDown);
    return WorkoutViewState(snapshot: WorkoutSnapshot.idle());
  }

  Future<void> start(RoutineSpec spec) async {
    await _tearDown();
    final plan = PlanBuilder.fromSpec(spec);
    _engine = WorkoutEngine(plan);
    _historySaved = false;
    _lastPhase = null;
    _lastSegment = -1;
    _lastCountdown = -1;
    _startedAt = DateTime.now();
    _engine!.start(_startedAt!);
    state = WorkoutViewState(
      snapshot: _engine!.snapshot(_startedAt!),
      plan: plan,
      startedAt: _startedAt,
    );
    await WakelockPlus.enable();
    await ref.read(settingsProvider.notifier).setLastRoutineId(spec.id);
    await _preparePlaylist(spec.playlistId);
    await _onTick(forcePhase: true);
    _timer = Timer.periodic(const Duration(milliseconds: 80), (_) => _onTick());
  }

  Future<void> togglePause() async {
    final engine = _engine;
    if (engine == null || engine.isFinished) return;
    final now = DateTime.now();
    if (engine.isPaused) {
      engine.resume(now);
    } else {
      engine.pause(now);
    }
    await _onTick(forcePhase: true);
  }

  Future<void> skip() async {
    final engine = _engine;
    if (engine == null || engine.isFinished) return;
    engine.skip(DateTime.now());
    _lastCountdown = -1;
    await _onTick(forcePhase: true);
  }

  Future<void> stop() async {
    final engine = _engine;
    if (engine == null) return;
    engine.stop(DateTime.now());
    await _onTick(forcePhase: true);
  }

  Future<void> dismiss() async {
    await _tearDown();
    state = WorkoutViewState(snapshot: WorkoutSnapshot.idle());
  }

  Future<void> _preparePlaylist(String? playlistId) async {
    final handler = ref.read(audioHandlerProvider);
    if (playlistId == null) return;
    final tracks = await ref.read(playlistRepositoryProvider).tracks(playlistId);
    if (tracks.isEmpty) return;
    final items = tracks
        .map(
          (t) => MediaItem(
            id: t.id,
            title: t.title,
            artist: t.artist.isEmpty ? 'Lejos' : t.artist,
            duration: Duration(milliseconds: t.durationMs),
            extras: {'uri': t.uri},
          ),
        )
        .toList();
    await handler.loadQueue(
      items,
      autoplay: ref.read(settingsProvider).musicBehavior != MusicBehavior.off,
    );
  }

  Future<void> _onTick({bool forcePhase = false}) async {
    final engine = _engine;
    if (engine == null) return;
    final now = DateTime.now();
    final snap = engine.snapshot(now);
    state = WorkoutViewState(
      snapshot: snap,
      plan: state.plan,
      startedAt: _startedAt,
    );

    final settings = ref.read(settingsProvider);
    final handler = ref.read(audioHandlerProvider);
    final cues = ref.read(cuePlayerProvider);
    final policy = MusicPolicy(handler);

    final segmentChanged = snap.segmentIndex != _lastSegment;
    if (segmentChanged && !snap.isFinished) {
      _lastSegment = snap.segmentIndex;
      _lastCountdown = -1;
      if (settings.haptics) {
        HapticFeedback.mediumImpact();
      }
      if (snap.phase != PhaseKind.done) {
        await _playCueOverMusic(
          handler: handler,
          cues: () => cues.playPhase(),
          snap: snap,
          behavior: settings.musicBehavior,
        );
      }
    }

    if (segmentChanged || forcePhase) {
      await policy.apply(
        snapshot: snap,
        behavior: settings.musicBehavior,
        previousPhase: _lastPhase,
        force: forcePhase,
      );
      _lastPhase = snap.phase;
    }

    final remainingSec = snap.remaining.inSeconds;
    if (settings.countdownBeeps &&
        snap.isRunning &&
        remainingSec <= 3 &&
        remainingSec > 0 &&
        remainingSec != _lastCountdown) {
      _lastCountdown = remainingSec;
      await _playCueOverMusic(
        handler: handler,
        cues: () => cues.playCountdown(),
        snap: snap,
        behavior: settings.musicBehavior,
      );
    }

    if (snap.isFinished) {
      _timer?.cancel();
      handler.clearTimerDisplay();
      if (!_historySaved && state.plan != null && _startedAt != null) {
        _historySaved = true;
        await cues.playComplete();
        if (settings.haptics) HapticFeedback.heavyImpact();
        await ref.read(historyRepositoryProvider).add(
              routineId: state.plan!.id,
              routineName: state.plan!.name,
              startedAt: _startedAt!,
              endedAt: now,
              durationSeconds: snap.elapsed.inSeconds,
              completed: !engine.wasAborted,
            );
        await WakelockPlus.disable();
      }
      return;
    }

    if (now.millisecond < 120 || forcePhase) {
      final lang = (settings.localeCode ??
              WidgetsBinding.instance.platformDispatcher.locale.languageCode)
          .toLowerCase();
      final es = lang.startsWith('es');
      final phaseLabel = switch (snap.phase) {
        PhaseKind.prepare => es ? 'Preparación' : 'Prepare',
        PhaseKind.work => es ? 'Trabajo' : 'Work',
        PhaseKind.rest => es ? 'Descanso' : 'Rest',
        PhaseKind.done => es ? 'Listo' : 'Done',
      };
      handler.setTimerDisplay(
        title: '$phaseLabel  ${TimeFormat.workoutClock(snap.remaining, snap.segmentDuration)}',
        subtitle: es
            ? 'Ronda ${snap.roundIndex}/${snap.roundCount}'
            : 'Round ${snap.roundIndex}/${snap.roundCount}',
      );
    }
  }

  Future<void> _playCueOverMusic({
    required PulseAudioHandler handler,
    required Future<void> Function() cues,
    required WorkoutSnapshot snap,
    required MusicBehavior behavior,
  }) async {
    final action = MusicPolicy.actionFor(
      behavior: behavior,
      phase: snap.phase,
      isPaused: snap.isPaused,
      isFinished: snap.isFinished,
    );
    if (handler.player.playing) {
      await handler.duck(MusicPolicy.cueDuckLevel(action));
    }
    await cues();
    if (snap.isPaused || snap.isFinished || behavior == MusicBehavior.off) {
      await handler.unduck();
      return;
    }
    await MusicPolicy(handler).applyAction(action);
  }

  Future<void> _tearDown() async {
    _timer?.cancel();
    _timer = null;
    _engine = null;
    _lastPhase = null;
    _lastSegment = -1;
    try {
      ref.read(audioHandlerProvider).clearTimerDisplay();
      await WakelockPlus.disable();
    } catch (_) {}
  }
}

final workoutControllerProvider =
    NotifierProvider<WorkoutController, WorkoutViewState>(WorkoutController.new);
