import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/engine/plan_builder.dart';
import 'package:pulse/core/engine/workout_engine.dart';
import 'package:pulse/core/models/phase.dart';
import 'package:pulse/core/models/workout_plan.dart';

void main() {
  final t0 = DateTime.utc(2026, 1, 1, 12);

  RoutineSpec seriesSpec({
    int prepare = 10,
    int work = 60,
    int rest = 30,
    int rounds = 3,
  }) {
    return RoutineSpec(
      id: 's',
      name: 'Push-ups',
      mode: WorkoutMode.series,
      prepareSeconds: prepare,
      workSeconds: work,
      restSeconds: rest,
      rounds: rounds,
      exerciseLabel: 'Push-ups',
    );
  }

  test('series 3x60 with rest and prepare has 6 segments', () {
    final plan = PlanBuilder.fromSpec(seriesSpec());
    expect(plan.segments.length, 6);
    expect(plan.segments.map((s) => s.kind).toList(), [
      PhaseKind.prepare,
      PhaseKind.work,
      PhaseKind.rest,
      PhaseKind.work,
      PhaseKind.rest,
      PhaseKind.work,
    ]);
    expect(plan.totalDuration, const Duration(seconds: 10 + 60 + 30 + 60 + 30 + 60));
  });

  test('no rest means consecutive work sets', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(rest: 0, prepare: 0));
    expect(plan.segments.every((s) => s.kind == PhaseKind.work), isTrue);
    expect(plan.segments.length, 3);
  });

  test('tabata 20/10 x 8 without prepare is 15 segments', () {
    final plan = PlanBuilder.fromSpec(
      const RoutineSpec(
        id: 't',
        name: 'Tabata',
        mode: WorkoutMode.tabata,
        prepareSeconds: 0,
        workSeconds: 20,
        restSeconds: 10,
        rounds: 8,
      ),
    );
    expect(plan.segments.where((s) => s.kind == PhaseKind.work).length, 8);
    expect(plan.segments.where((s) => s.kind == PhaseKind.rest).length, 7);
    expect(plan.totalDuration, const Duration(seconds: 20 * 8 + 10 * 7));
  });

  test('wall clock maps prepare then work then rest', () {
    final plan = PlanBuilder.fromSpec(seriesSpec());
    final engine = WorkoutEngine(plan);
    engine.start(t0);

    var snap = engine.snapshot(t0);
    expect(snap.phase, PhaseKind.prepare);
    expect(snap.remaining.inSeconds, 10);

    snap = engine.snapshot(t0.add(const Duration(seconds: 10)));
    expect(snap.phase, PhaseKind.work);
    expect(snap.remaining.inSeconds, 60);
    expect(snap.workIndex, 1);

    snap = engine.snapshot(t0.add(const Duration(seconds: 70)));
    expect(snap.phase, PhaseKind.rest);
    expect(snap.remaining.inSeconds, 30);

    snap = engine.snapshot(t0.add(const Duration(seconds: 100)));
    expect(snap.phase, PhaseKind.work);
    expect(snap.workIndex, 2);
  });

  test('pause freezes remaining time', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(prepare: 0, rest: 0, rounds: 1, work: 60));
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    engine.pause(t0.add(const Duration(seconds: 20)));

    final a = engine.snapshot(t0.add(const Duration(seconds: 20)));
    final b = engine.snapshot(t0.add(const Duration(seconds: 50)));
    expect(a.remaining, b.remaining);
    expect(b.isPaused, isTrue);
    expect(a.remaining.inSeconds, 40);
  });

  test('resume continues from paused elapsed', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(prepare: 0, rest: 0, rounds: 1, work: 60));
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    engine.pause(t0.add(const Duration(seconds: 20)));
    engine.resume(t0.add(const Duration(seconds: 80)));
    final snap = engine.snapshot(t0.add(const Duration(seconds: 90)));
    expect(snap.remaining.inSeconds, 30);
    expect(snap.isPaused, isFalse);
  });

  test('skip jumps to the next segment', () {
    final plan = PlanBuilder.fromSpec(seriesSpec());
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    expect(engine.snapshot(t0).phase, PhaseKind.prepare);
    engine.skip(t0.add(const Duration(seconds: 2)));
    expect(engine.snapshot(t0.add(const Duration(seconds: 2))).phase, PhaseKind.work);
  });

  test('skip on last segment finishes the workout', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(prepare: 0, rest: 0, rounds: 1, work: 60));
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    engine.skip(t0);
    final snap = engine.snapshot(t0);
    expect(snap.isFinished, isTrue);
    expect(snap.phase, PhaseKind.done);
  });

  test('natural completion at exact total duration', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(prepare: 0, rest: 0, rounds: 1, work: 30));
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    final snap = engine.snapshot(t0.add(const Duration(seconds: 30)));
    expect(snap.isFinished, isTrue);
    expect(engine.wasAborted, isFalse);
  });

  test('stop mid-set marks aborted and keeps elapsed', () {
    final plan = PlanBuilder.fromSpec(seriesSpec(prepare: 0, rest: 0, rounds: 1, work: 60));
    final engine = WorkoutEngine(plan);
    engine.start(t0);
    engine.stop(t0.add(const Duration(seconds: 12)));
    final snap = engine.snapshot(t0.add(const Duration(seconds: 40)));
    expect(snap.isFinished, isTrue);
    expect(engine.wasAborted, isTrue);
    expect(snap.elapsed.inSeconds, 12);
  });

  test('custom 10 rounds of 5/10 is glanceable from spec', () {
    final plan = PlanBuilder.fromSpec(
      seriesSpec(prepare: 5, work: 5, rest: 10, rounds: 10),
    );
    expect(plan.workCount, 10);
    expect(plan.segments.where((s) => s.kind == PhaseKind.rest).length, 9);
    expect(
      plan.totalDuration,
      const Duration(seconds: 5 + 10 * 5 + 9 * 10),
    );
  });

  test('custom segments honor order and labels', () {
    final plan = PlanBuilder.fromSpec(
      const RoutineSpec(
        id: 'c',
        name: 'Custom',
        mode: WorkoutMode.custom,
        prepareSeconds: 5,
        custom: [
          CustomSegment(kind: PhaseKind.work, seconds: 20, label: 'A'),
          CustomSegment(kind: PhaseKind.rest, seconds: 10),
          CustomSegment(kind: PhaseKind.work, seconds: 15, label: 'B'),
        ],
      ),
    );
    expect(plan.segments.map((s) => s.kind).toList(), [
      PhaseKind.prepare,
      PhaseKind.work,
      PhaseKind.rest,
      PhaseKind.work,
    ]);
    expect(plan.segments[1].label, 'A');
    expect(plan.segments[3].label, 'B');
  });
}
