import 'package:shared_preferences/shared_preferences.dart';

import '../../core/models/app_settings.dart';
import '../../core/models/appearance.dart';
import '../../core/models/phase.dart';

class SettingsRepository {
  SettingsRepository(this._prefs);

  final SharedPreferences _prefs;

  static const _kBehavior = 'musicBehavior';
  static const _kHaptics = 'haptics';
  static const _kBeeps = 'countdownBeeps';
  static const _kLocale = 'localeCode';
  static const _kLastRoutine = 'lastRoutineId';
  static const _kLayout = 'timerLayout';
  static const _kTheme = 'appThemeId';

  AppSettings load() {
    final behaviorName = _prefs.getString(_kBehavior);
    final layoutName = _prefs.getString(_kLayout);
    final themeName = _prefs.getString(_kTheme);
    return AppSettings(
      musicBehavior: MusicBehavior.values.firstWhere(
        (b) => b.name == behaviorName,
        orElse: () => MusicBehavior.alwaysOn,
      ),
      haptics: _prefs.getBool(_kHaptics) ?? true,
      countdownBeeps: _prefs.getBool(_kBeeps) ?? true,
      localeCode: _prefs.getString(_kLocale),
      lastRoutineId: _prefs.getString(_kLastRoutine),
      timerLayout: TimerLayout.values.firstWhere(
        (l) => l.name == layoutName,
        orElse: () => TimerLayout.both,
      ),
      themeId: AppThemeId.values.firstWhere(
        (t) => t.name == themeName,
        orElse: () => AppThemeId.clock,
      ),
    );
  }

  Future<void> save(AppSettings settings) async {
    await _prefs.setString(_kBehavior, settings.musicBehavior.name);
    await _prefs.setBool(_kHaptics, settings.haptics);
    await _prefs.setBool(_kBeeps, settings.countdownBeeps);
    await _prefs.setString(_kLayout, settings.timerLayout.name);
    await _prefs.setString(_kTheme, settings.themeId.name);
    if (settings.localeCode == null) {
      await _prefs.remove(_kLocale);
    } else {
      await _prefs.setString(_kLocale, settings.localeCode!);
    }
    if (settings.lastRoutineId == null) {
      await _prefs.remove(_kLastRoutine);
    } else {
      await _prefs.setString(_kLastRoutine, settings.lastRoutineId!);
    }
  }
}
