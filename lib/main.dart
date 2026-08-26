import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app/app.dart';
import 'app/providers.dart';
import 'app/theme.dart';
import 'data/db/app_database.dart';
import 'data/repositories/routine_repository.dart';
import 'features/music/audio_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();

  if (!kIsWeb) {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: PulsePalette.clock.background,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final db = AppDatabase();
  await RoutineRepository(db).seedPresets();

  final handler = kIsWeb
      ? PulseAudioHandler()
      : await AudioService.init(
          builder: PulseAudioHandler.new,
          config: const AudioServiceConfig(
            androidNotificationChannelId: 'com.adrianoliver.pulse.audio',
            androidNotificationChannelName: 'Pulse',
            androidStopForegroundOnPause: false,
            androidNotificationIcon: 'mipmap/ic_launcher',
            notificationColor: Color(0xFF050505),
          ),
        );

  runApp(
    ProviderScope(
      overrides: [
        databaseProvider.overrideWithValue(db),
        sharedPreferencesProvider.overrideWithValue(prefs),
        audioHandlerProvider.overrideWithValue(handler),
      ],
      child: const PulseApp(),
    ),
  );
}
