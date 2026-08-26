import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../features/onboarding/onboarding_screen.dart';
import '../l10n/generated/app_localizations.dart';
import 'providers.dart';
import 'router.dart';
import 'theme.dart';

class PulseApp extends ConsumerStatefulWidget {
  const PulseApp({super.key});

  @override
  ConsumerState<PulseApp> createState() => _PulseAppState();
}

class _PulseAppState extends ConsumerState<PulseApp> {
  late final _router = createRouter();

  @override
  Widget build(BuildContext context) {
    final settings = ref.watch(settingsProvider);
    final palette = PulsePalette.ofId(settings.themeId);
    final locale =
        settings.localeCode == null ? null : Locale(settings.localeCode!);
    final overlay = AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: palette.background,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: settings.onboardingDone
          ? MaterialApp.router(
              title: 'Lejos',
              debugShowCheckedModeBanner: false,
              theme: PulseTheme.from(settings.themeId),
              routerConfig: _router,
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
            )
          : MaterialApp(
              title: 'Lejos',
              debugShowCheckedModeBanner: false,
              theme: PulseTheme.from(settings.themeId),
              locale: locale,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              home: OnboardingScreen(
                onFinished: () =>
                    ref.read(settingsProvider.notifier).setOnboardingDone(true),
              ),
            ),
    );
    return overlay;
  }
}
