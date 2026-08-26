import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/app/theme.dart';
import 'package:pulse/core/format.dart';
import 'package:pulse/core/models/appearance.dart';
import 'package:pulse/core/models/phase.dart';
import 'package:pulse/core/models/workout_snapshot.dart';
import 'package:pulse/features/workout/workout_clock.dart';

void main() {
  test('mmss pads minutes and seconds', () {
    expect(TimeFormat.mmss(const Duration(seconds: 5)), '00:05');
    expect(TimeFormat.mmss(const Duration(seconds: 75)), '01:15');
  });

  test('workoutClock uses seconds only under a minute-long segment', () {
    expect(
      TimeFormat.workoutClock(const Duration(seconds: 8), const Duration(seconds: 20)),
      '08',
    );
    expect(
      TimeFormat.workoutClock(const Duration(seconds: 60), const Duration(seconds: 60)),
      '01:00',
    );
  });

  testWidgets('giant clock shows glanceable digits and phase', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: PulseTheme.from(AppThemeId.clock),
        home: const Scaffold(
          body: WorkoutClock(
            layout: TimerLayout.giant,
            snap: _workSnap,
            phaseLabel: 'Trabajo',
            phaseColor: Color(0xFFE8A317),
          ),
        ),
      ),
    );
    expect(find.text('08'), findsOneWidget);
    expect(find.text('TRABAJO'), findsOneWidget);
  });

  testWidgets('both layout also shows the remaining count', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: PulseTheme.from(AppThemeId.lab),
        home: const Scaffold(
          body: WorkoutClock(
            layout: TimerLayout.both,
            snap: _workSnap,
            phaseLabel: 'Work',
            phaseColor: Color(0xFF5EEAD4),
          ),
        ),
      ),
    );
    expect(find.text('08'), findsOneWidget);
  });
}

const _workSnap = WorkoutSnapshot(
  phase: PhaseKind.work,
  remaining: Duration(seconds: 8),
  segmentDuration: Duration(seconds: 20),
  segmentIndex: 1,
  totalSegments: 4,
  roundIndex: 1,
  roundCount: 10,
  workIndex: 1,
  workCount: 10,
  label: '',
  isPaused: false,
  isFinished: false,
  isRunning: true,
  totalRemaining: Duration(seconds: 140),
  elapsed: Duration(seconds: 12),
);
