import 'appearance.dart';
import 'phase.dart';

class AppSettings {
  const AppSettings({
    this.musicBehavior = MusicBehavior.alwaysOn,
    this.haptics = true,
    this.countdownBeeps = true,
    this.localeCode,
    this.lastRoutineId,
    this.timerLayout = TimerLayout.both,
    this.themeId = AppThemeId.clock,
  });

  final MusicBehavior musicBehavior;
  final bool haptics;
  final bool countdownBeeps;

  /// `null` follows the device locale.
  final String? localeCode;
  final String? lastRoutineId;
  final TimerLayout timerLayout;
  final AppThemeId themeId;

  AppSettings copyWith({
    MusicBehavior? musicBehavior,
    bool? haptics,
    bool? countdownBeeps,
    String? localeCode,
    String? lastRoutineId,
    TimerLayout? timerLayout,
    AppThemeId? themeId,
    bool clearLocale = false,
    bool clearLastRoutine = false,
  }) {
    return AppSettings(
      musicBehavior: musicBehavior ?? this.musicBehavior,
      haptics: haptics ?? this.haptics,
      countdownBeeps: countdownBeeps ?? this.countdownBeeps,
      localeCode: clearLocale ? null : (localeCode ?? this.localeCode),
      lastRoutineId:
          clearLastRoutine ? null : (lastRoutineId ?? this.lastRoutineId),
      timerLayout: timerLayout ?? this.timerLayout,
      themeId: themeId ?? this.themeId,
    );
  }
}
