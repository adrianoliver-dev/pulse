import 'phase.dart';

class WorkoutSnapshot {
  const WorkoutSnapshot({
    required this.phase,
    required this.remaining,
    required this.segmentDuration,
    required this.segmentIndex,
    required this.totalSegments,
    required this.roundIndex,
    required this.roundCount,
    required this.workIndex,
    required this.workCount,
    required this.label,
    required this.isPaused,
    required this.isFinished,
    required this.isRunning,
    required this.totalRemaining,
    required this.elapsed,
  });

  final PhaseKind phase;
  final Duration remaining;
  final Duration segmentDuration;
  final int segmentIndex;
  final int totalSegments;
  final int roundIndex;
  final int roundCount;
  final int workIndex;
  final int workCount;
  final String label;
  final bool isPaused;
  final bool isFinished;
  final bool isRunning;
  final Duration totalRemaining;
  final Duration elapsed;

  double get segmentProgress {
    if (segmentDuration.inMilliseconds <= 0) return 1;
    final done = segmentDuration - remaining;
    return (done.inMilliseconds / segmentDuration.inMilliseconds).clamp(0.0, 1.0);
  }

  factory WorkoutSnapshot.idle() {
    return const WorkoutSnapshot(
      phase: PhaseKind.prepare,
      remaining: Duration.zero,
      segmentDuration: Duration.zero,
      segmentIndex: 0,
      totalSegments: 0,
      roundIndex: 1,
      roundCount: 1,
      workIndex: 0,
      workCount: 0,
      label: '',
      isPaused: false,
      isFinished: false,
      isRunning: false,
      totalRemaining: Duration.zero,
      elapsed: Duration.zero,
    );
  }
}
