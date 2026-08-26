class TimeFormat {
  TimeFormat._();

  static String mmss(Duration d) {
    final total = d.inSeconds.abs();
    final m = total ~/ 60;
    final s = total % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  static String workoutClock(Duration remaining, Duration segment) {
    if (segment.inSeconds < 60) {
      return remaining.inSeconds.clamp(0, 999).toString().padLeft(2, '0');
    }
    return mmss(remaining);
  }

  static String pretty(Duration d) {
    final total = d.inSeconds.abs();
    if (total < 60) return '${total}s';
    final m = total ~/ 60;
    final s = total % 60;
    if (s == 0) return '${m}m';
    return '${m}m ${s.toString().padLeft(2, '0')}s';
  }
}
