import 'package:audio_service/audio_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/models/app_settings.dart';
import '../core/models/appearance.dart';
import '../core/models/phase.dart';
import '../data/db/app_database.dart';
import '../data/repositories/history_repository.dart';
import '../data/repositories/playlist_repository.dart';
import '../data/repositories/routine_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../features/music/audio_handler.dart';
import '../features/music/cue_player.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('databaseProvider must be overridden');
});

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('sharedPreferencesProvider must be overridden');
});

final audioHandlerProvider = Provider<PulseAudioHandler>((ref) {
  throw UnimplementedError('audioHandlerProvider must be overridden');
});

final cuePlayerProvider = Provider<CuePlayer>((ref) {
  final cues = CuePlayer();
  ref.onDispose(cues.dispose);
  return cues;
});

final routineRepositoryProvider = Provider<RoutineRepository>((ref) {
  return RoutineRepository(ref.watch(databaseProvider));
});

final playlistRepositoryProvider = Provider<PlaylistRepository>((ref) {
  return PlaylistRepository(ref.watch(databaseProvider));
});

final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.watch(databaseProvider));
});

final settingsRepositoryProvider = Provider<SettingsRepository>((ref) {
  return SettingsRepository(ref.watch(sharedPreferencesProvider));
});

final routinesProvider = StreamProvider((ref) {
  return ref.watch(routineRepositoryProvider).watchAll();
});

final playlistsProvider = StreamProvider((ref) {
  return ref.watch(playlistRepositoryProvider).watchAll();
});

final historyProvider = StreamProvider((ref) {
  return ref.watch(historyRepositoryProvider).watchAll();
});

final playlistTracksProvider =
    StreamProvider.family((ref, String playlistId) {
  return ref.watch(playlistRepositoryProvider).watchTracks(playlistId);
});

class SettingsNotifier extends Notifier<AppSettings> {
  @override
  AppSettings build() => ref.watch(settingsRepositoryProvider).load();

  Future<void> _persist(AppSettings next) async {
    state = next;
    await ref.read(settingsRepositoryProvider).save(next);
  }

  Future<void> setMusicBehavior(MusicBehavior value) =>
      _persist(state.copyWith(musicBehavior: value));

  Future<void> setHaptics(bool value) => _persist(state.copyWith(haptics: value));

  Future<void> setCountdownBeeps(bool value) =>
      _persist(state.copyWith(countdownBeeps: value));

  Future<void> setLocaleCode(String? code) => _persist(
        state.copyWith(localeCode: code, clearLocale: code == null),
      );

  Future<void> setLastRoutineId(String id) =>
      _persist(state.copyWith(lastRoutineId: id));

  Future<void> setTimerLayout(TimerLayout value) =>
      _persist(state.copyWith(timerLayout: value));

  Future<void> setThemeId(AppThemeId value) =>
      _persist(state.copyWith(themeId: value));

  Future<void> setOnboardingDone(bool value) =>
      _persist(state.copyWith(onboardingDone: value));

  Future<void> setGeminiUserKey(String? value) => _persist(
        state.copyWith(
          geminiUserKey: value,
          clearGeminiKey: value == null || value.trim().isEmpty,
        ),
      );
}

final settingsProvider =
    NotifierProvider<SettingsNotifier, AppSettings>(SettingsNotifier.new);

final mediaItemProvider = StreamProvider<MediaItem?>((ref) {
  return ref.watch(audioHandlerProvider).mediaItem;
});

final playbackStateProvider = StreamProvider<PlaybackState>((ref) {
  return ref.watch(audioHandlerProvider).playbackState;
});

final positionProvider = StreamProvider<Duration>((ref) {
  return ref.watch(audioHandlerProvider).positionStream;
});

final queueProvider = StreamProvider<List<MediaItem>>((ref) {
  return ref.watch(audioHandlerProvider).queue;
});
