import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/ai/coach_plan.dart';
import 'package:pulse/core/models/phase.dart';
import 'package:pulse/core/streak.dart';
import 'package:pulse/features/music/device_library.dart';

void main() {
  test('streak continues from yesterday if today is still empty', () {
    final now = DateTime(2026, 8, 26, 18);
    final stats = StreakStats.fromEvents([
      StreakEvent(
        endedAt: DateTime(2026, 8, 25, 10),
        completed: true,
        durationSeconds: 600,
      ),
      StreakEvent(
        endedAt: DateTime(2026, 8, 24, 10),
        completed: true,
        durationSeconds: 400,
      ),
    ], now: now);
    expect(stats.current, 2);
    expect(stats.todayDone, isFalse);
    expect(stats.longest, 2);
  });

  test('today extends the streak', () {
    final now = DateTime(2026, 8, 26, 18);
    final stats = StreakStats.fromEvents([
      StreakEvent(
        endedAt: DateTime(2026, 8, 26, 8),
        completed: true,
        durationSeconds: 300,
      ),
      StreakEvent(
        endedAt: DateTime(2026, 8, 25, 8),
        completed: true,
        durationSeconds: 300,
      ),
    ], now: now);
    expect(stats.current, 2);
    expect(stats.todayDone, isTrue);
  });

  test('a missed day breaks the current streak', () {
    final now = DateTime(2026, 8, 26);
    final stats = StreakStats.fromEvents([
      StreakEvent(
        endedAt: DateTime(2026, 8, 23, 10),
        completed: true,
      ),
    ], now: now);
    expect(stats.current, 0);
    expect(stats.longest, 1);
  });

  test('incomplete sessions do not count', () {
    final now = DateTime(2026, 8, 26);
    final stats = StreakStats.fromEvents([
      StreakEvent(
        endedAt: DateTime(2026, 8, 26, 9),
        completed: false,
      ),
    ], now: now);
    expect(stats.todayDone, isFalse);
    expect(stats.current, 0);
  });

  test('coach json becomes routines', () {
    const raw = '''
{"routines":[{"day":"Hoy","name":"HIIT noche","mode":"hiit","prepareSeconds":8,"workSeconds":40,"restSeconds":20,"rounds":8,"note":"calienta"}]}
''';
    final parsed = parseCoachRoutines(raw);
    expect(parsed, hasLength(1));
    expect(parsed.first.spec.mode, WorkoutMode.hiit);
    expect(parsed.first.spec.rounds, 8);
    expect(parsed.first.dayLabel, 'Hoy');
  });

  test('playlist indices map onto local songs', () {
    const songs = [
      DeviceSong(id: '1', title: 'A', artist: 'X', uri: 'a', durationMs: 120000),
      DeviceSong(id: '2', title: 'B', artist: 'Y', uri: 'b', durationMs: 120000),
    ];
    final pick = parsePlaylistPick(
      '{"name":"Rock","indices":[1,9,0]}',
      songs,
    );
    expect(pick.name, 'Rock');
    expect(pick.songs.map((s) => s.id).toList(), ['2', '1']);
  });
}
