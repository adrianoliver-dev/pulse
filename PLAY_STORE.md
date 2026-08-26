# Play Store checklist — Pulse: Interval Timer

Package: `com.adrianoliver.pulse`  
Default language: Spanish and English  
Category: Health & Fitness  
Content rating: Everyone  
Price: Free, no ads, no IAP in v1.0

## Before you upload

1. Create a Play Console developer account (one-time $25).
2. Create an upload keystore **outside the repo**:

```
keytool -genkey -v -keystore %USERPROFILE%\pulse-upload.jks -keyalg RSA -keysize 2048 -validity 10000 -alias pulse
```

3. Add `android/key.properties` (gitignored):

```
storePassword=...
keyPassword=...
keyAlias=pulse
storeFile=C:\\Users\\...\\pulse-upload.jks
```

Then wire `signingConfigs` in `android/app/build.gradle.kts` before production. Debug signing is only for internal testing.

4. Host [PRIVACY_POLICY.md](PRIVACY_POLICY.md) at a public HTTPS URL (GitHub Pages, Notion, or your site). Play requires a URL, not a PDF.

5. Enable Play App Signing in the console.

## Store listing assets (already in the repo)

| Asset | Path |
| --- | --- |
| App icon 512 | `assets/icon/play_icon_512.png` |
| High-res icon source | `assets/icon/icon.png` |
| Feature graphic 1024×500 | `assets/icon/feature_graphic.png` |

Still needed from a device or emulator:

- Phone screenshots (8–16, dark UI): home, editor, workout work, workout rest, music library
- 7-inch / 10-inch tablet optional
- Short demo video of timer + music in the background (required for the foreground-service declaration)

Suggested title: **Pulse: Interval Timer**  
Short description (EN): Minimal interval timer. Local playlists start with every work set.  
Short description (ES): Temporizador de intervalos. La playlist arranca con cada serie de trabajo.

## Console declarations

- **Data safety:** no data collected / all data stays on device.
- **Foreground service:** `mediaPlayback` — music and timer cues during workouts; user impact if interrupted: music and countdown stop.
- **Permissions:** `READ_MEDIA_AUDIO` / storage (max SDK 32), `POST_NOTIFICATIONS`, `FOREGROUND_SERVICE_MEDIA_PLAYBACK`.
- **Target API:** 36 (new apps, 2026).
- **16 KB page size:** Flutter 3.47 + current NDK; verify with `bundletool` if Play flags it.

## Testing track for Jhon

1. `flutter build appbundle --release` (or `--debug` APK for a quick sideload).
2. Play Console → internal testing track → add Jhon’s Gmail.
3. Gold-path: Lagartijas 3×1:00, pick a playlist, Start → music on work, pause on rest, resume on next set.

## iOS / other stores (later)

Same Flutter project. `Info.plist` already has `audio` background mode and media-library usage text. App Store needs a separate developer account, privacy URL, and screenshots.
