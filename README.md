# Lejos

Temporizador de intervalos para leer al otro lado del cuarto: números gigantes, temas que eliges, y música que no se corta cuando suena el beep.

- Marca visible: **Lejos**
- Package: `com.adrianoliver.pulse` (no cambia; así no se pierde el sideload)
- Demo web: https://pulse-adrianoliver-dev.vercel.app
- App: Android primero

## Requisitos

- Flutter 3.47+ (Dart 3.13+)
- Android SDK 36, minSdk 26
- Java 17+

En Windows, si Flutter no está en el PATH:

```
$env:PATH = "$env:USERPROFILE\flutter\bin;$env:PATH"
$env:ANDROID_HOME = "$env:LOCALAPPDATA\Android\Sdk"
```

## Desarrollo

```
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
flutter test
flutter run
flutter run -d chrome
```

## Web (Vercel)

```
flutter build web --release
```

`vercel.json` clona Flutter en el build de Vercel y publica `build/web`. Las rutas van a `index.html` (SPA).

La demo web sirve para probar timer, temas y formatos. La biblioteca de música del teléfono y el control en pantalla bloqueada viven en Android.

## APK

```
flutter build apk --release
```

El APK queda en `build/app/outputs/flutter-apk/app-release.apk`.

## Play Store

```
flutter build appbundle --release
```

Usa `key.properties` y un keystore de upload (no se suben al repo). Guía: [PLAY_STORE.md](PLAY_STORE.md).

## Privacidad

Todo es local. Ver [PRIVACY_POLICY.md](PRIVACY_POLICY.md).
