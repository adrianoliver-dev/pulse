import '../../core/models/phase.dart';
import '../../core/models/workout_snapshot.dart';
import 'audio_handler.dart';

enum MusicAction { pause, playFull, playDucked }

class MusicPolicy {
  const MusicPolicy(this._handler);

  final PulseAudioHandler _handler;

  /// Slight dip so a beep is audible without killing the track.
  static const cueDuckFull = 0.62;

  /// If rest is already ducked, dip a bit more for the cue.
  static const cueDuckAlreadyLow = 0.42;

  /// Optional rest duck — still clearly music, not silence.
  static const restDuck = 0.58;

  static MusicAction actionFor({
    required MusicBehavior behavior,
    required PhaseKind phase,
    required bool isPaused,
    required bool isFinished,
  }) {
    if (behavior == MusicBehavior.off || isFinished || isPaused) {
      return MusicAction.pause;
    }
    return switch (phase) {
      PhaseKind.work => MusicAction.playFull,
      PhaseKind.done => MusicAction.pause,
      PhaseKind.prepare || PhaseKind.rest => switch (behavior) {
          MusicBehavior.pauseOnRest || MusicBehavior.off => MusicAction.pause,
          MusicBehavior.duckOnRest => MusicAction.playDucked,
          MusicBehavior.alwaysOn => MusicAction.playFull,
        },
    };
  }

  static double cueDuckLevel(MusicAction current) {
    return current == MusicAction.playDucked ? cueDuckAlreadyLow : cueDuckFull;
  }

  Future<void> apply({
    required WorkoutSnapshot snapshot,
    required MusicBehavior behavior,
    required PhaseKind? previousPhase,
    bool force = false,
  }) async {
    if (!_handler.hasQueue) return;

    if (behavior == MusicBehavior.off) {
      if (_handler.player.playing) await _handler.pause();
      await _handler.unduck();
      return;
    }

    if (snapshot.isFinished) {
      await _handler.pause();
      await _handler.unduck();
      return;
    }

    if (snapshot.isPaused) {
      await _handler.pause();
      return;
    }

    if (!force && snapshot.phase == previousPhase) {
      return;
    }

    await applyAction(
      actionFor(
        behavior: behavior,
        phase: snapshot.phase,
        isPaused: false,
        isFinished: false,
      ),
    );
  }

  Future<void> applyAction(MusicAction action) async {
    switch (action) {
      case MusicAction.pause:
        await _handler.pause();
        await _handler.unduck();
      case MusicAction.playFull:
        await _handler.unduck();
        await _handler.play();
      case MusicAction.playDucked:
        await _handler.play();
        await _handler.duck(restDuck);
    }
  }
}
