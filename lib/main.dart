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
  if (kIsWeb) {
    usePathUrlStrategy();
  } else {
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

  try {
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
  } catch (error, stack) {
    debugPrint('Pulse failed to start: $error\n$stack');
    runApp(PulseBootFailed(message: '$error'));
  }
}

class PulseBootFailed extends StatelessWidget {
  const PulseBootFailed({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: const Color(0xFF050505),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'PULSE',
                  style: TextStyle(
                    color: Color(0xFFE8B86D),
                    letterSpacing: 4,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'No se pudo abrir la demo.',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 12),
                Text(
                  message,
                  style: const TextStyle(color: Color(0xFFB0B0B0), height: 1.4),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
