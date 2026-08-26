import '../models/phase.dart';
import '../models/workout_plan.dart';
import '../models/workout_snapshot.dart';

/// Drift-free interval engine: remaining time is derived from wall-clock
/// elapsed time, not from a ticking counter.
class WorkoutEngine {
  WorkoutEngine(this.plan);

  final WorkoutPlan plan;

  DateTime? _anchor;
  Duration _elapsedBeforeAnchor = Duration.zero;
  bool _paused = false;
  bool _finished = false;
  bool _started = false;
  bool _aborted = false;

  bool get isStarted => _started;
  bool get isPaused => _paused;
  bool get isFinished => _finished;
  bool get wasAborted => _aborted;

  Duration get totalDuration => plan.totalDuration;

  void start(DateTime now) {
    _started = true;
    _paused = false;
    _finished = false;
    _aborted = false;
    _elapsedBeforeAnchor = Duration.zero;
    _anchor = now;
  }

  void pause(DateTime now) {
    if (!_started || _paused || _finished) return;
    _elapsedBeforeAnchor = _elapsed(now);
    _paused = true;
    _anchor = now;
  }

  void resume(DateTime now) {
    if (!_started || !_paused || _finished) return;
    _paused = false;
    _anchor = now;
  }

  void skip(DateTime now) {
    if (!_started || _finished) return;
    final current = snapshot(now);
    final nextIndex = current.segmentIndex + 1;
    if (nextIndex >= plan.segments.length) {
      _elapsedBeforeAnchor = totalDuration;
      _paused = false;
      _finished = true;
      _anchor = now;
      return;
    }
    _elapsedBeforeAnchor = _elapsedAtSegmentStart(nextIndex);
    _anchor = now;
  }

  void stop(DateTime now) {
    if (!_started || _finished) return;
    _elapsedBeforeAnchor = _elapsed(now);
    _finished = true;
    _aborted = true;
    _paused = false;
    _anchor = now;
  }

  WorkoutSnapshot snapshot(DateTime now) {
    if (!_started) return WorkoutSnapshot.idle();

    var elapsed = _elapsed(now);
    if (elapsed >= totalDuration || _finished) {
      _finished = true;
      final last = plan.segments.isEmpty ? null : plan.segments.last;
      final doneElapsed = _aborted
          ? _elapsedBeforeAnchor
          : (elapsed > totalDuration ? totalDuration : elapsed);
      return WorkoutSnapshot(
        phase: PhaseKind.done,
        remaining: Duration.zero,
        segmentDuration: last?.duration ?? Duration.zero,
        segmentIndex: plan.segments.length,
        totalSegments: plan.segments.length,
        roundIndex: last?.roundIndex ?? 1,
        roundCount: last?.roundCount ?? 1,
        workIndex: last?.workIndex ?? 0,
        workCount: last?.workCount ?? 0,
        label: last?.label ?? '',
        isPaused: false,
        isFinished: true,
        isRunning: false,
        totalRemaining: Duration.zero,
        elapsed: doneElapsed > totalDuration ? totalDuration : doneElapsed,
      );
    }

    var cursor = Duration.zero;
    for (var i = 0; i < plan.segments.length; i++) {
      final segment = plan.segments[i];
      final end = cursor + segment.duration;
      if (elapsed < end) {
        final into = elapsed - cursor;
        final remaining = segment.duration - into;
        final totalRemaining = totalDuration - elapsed;
        return WorkoutSnapshot(
          phase: segment.kind,
          remaining: remaining,
          segmentDuration: segment.duration,
          segmentIndex: i,
          totalSegments: plan.segments.length,
          roundIndex: segment.roundIndex,
          roundCount: segment.roundCount,
          workIndex: segment.workIndex,
          workCount: segment.workCount,
          label: segment.label,
          isPaused: _paused,
          isFinished: false,
          isRunning: !_paused,
          totalRemaining: totalRemaining,
          elapsed: elapsed,
        );
      }
      cursor = end;
    }

    _finished = true;
    return snapshot(now);
  }

  Duration _elapsed(DateTime now) {
    if (_anchor == null || _paused || _finished) return _elapsedBeforeAnchor;
    final running = now.difference(_anchor!);
    final total = _elapsedBeforeAnchor + running;
    if (total.isNegative) return Duration.zero;
    return total;
  }

  Duration _elapsedAtSegmentStart(int index) {
    var sum = Duration.zero;
    for (var i = 0; i < index && i < plan.segments.length; i++) {
      sum += plan.segments[i].duration;
    }
    return sum;
  }
}
