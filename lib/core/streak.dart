class StreakEvent {
  const StreakEvent({
    required this.endedAt,
    required this.completed,
    this.durationSeconds = 0,
  });

  final DateTime endedAt;
  final bool completed;
  final int durationSeconds;
}

class StreakStats {
  const StreakStats({
    required this.current,
    required this.longest,
    required this.todayDone,
    required this.last7,
    required this.weekSessions,
    required this.weekSeconds,
    required this.totalSessions,
  });

  final int current;
  final int longest;
  final bool todayDone;
  final List<bool> last7;
  final int weekSessions;
  final int weekSeconds;
  final int totalSessions;

  static StreakStats fromEvents(
    Iterable<StreakEvent> rows, {
    DateTime? now,
  }) {
    final today = dateOnly(now ?? DateTime.now());
    final completedDays = <DateTime>{};
    var weekSessions = 0;
    var weekSeconds = 0;
    var totalSessions = 0;
    final weekStart = today.subtract(Duration(days: today.weekday - 1));

    for (final row in rows) {
      if (!row.completed) continue;
      totalSessions++;
      final day = dateOnly(row.endedAt.toLocal());
      completedDays.add(day);
      if (!day.isBefore(weekStart) && !day.isAfter(today)) {
        weekSessions++;
        weekSeconds += row.durationSeconds;
      }
    }

    var current = 0;
    var cursor = completedDays.contains(today)
        ? today
        : today.subtract(const Duration(days: 1));
    while (completedDays.contains(cursor)) {
      current++;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    final sorted = completedDays.toList()..sort();
    var longest = 0;
    var run = 0;
    DateTime? prev;
    for (final day in sorted) {
      if (prev != null && day.difference(prev).inDays == 1) {
        run++;
      } else {
        run = 1;
      }
      if (run > longest) longest = run;
      prev = day;
    }

    final last7 = List<bool>.generate(7, (i) {
      final day = today.subtract(Duration(days: 6 - i));
      return completedDays.contains(day);
    });

    return StreakStats(
      current: current,
      longest: longest,
      todayDone: completedDays.contains(today),
      last7: last7,
      weekSessions: weekSessions,
      weekSeconds: weekSeconds,
      totalSessions: totalSessions,
    );
  }

  static DateTime dateOnly(DateTime d) => DateTime(d.year, d.month, d.day);
}
