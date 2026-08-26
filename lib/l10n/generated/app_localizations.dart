import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Lejos'**
  String get appTitle;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Read it from across the room.'**
  String get tagline;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Train'**
  String get navHome;

  /// No description provided for @navMusic.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get navMusic;

  /// No description provided for @navHistory.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get navHistory;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get play;

  /// No description provided for @pause.
  ///
  /// In en, this message translates to:
  /// **'Pause'**
  String get pause;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get stop;

  /// No description provided for @done.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @prepare.
  ///
  /// In en, this message translates to:
  /// **'Prepare'**
  String get prepare;

  /// No description provided for @work.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get work;

  /// No description provided for @rest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get rest;

  /// No description provided for @roundOf.
  ///
  /// In en, this message translates to:
  /// **'Round {current} of {total}'**
  String roundOf(int current, int total);

  /// No description provided for @totalRemaining.
  ///
  /// In en, this message translates to:
  /// **'{time} left'**
  String totalRemaining(String time);

  /// No description provided for @newRoutine.
  ///
  /// In en, this message translates to:
  /// **'New routine'**
  String get newRoutine;

  /// No description provided for @editRoutine.
  ///
  /// In en, this message translates to:
  /// **'Edit routine'**
  String get editRoutine;

  /// No description provided for @nameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nameLabel;

  /// No description provided for @modeLabel.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get modeLabel;

  /// No description provided for @modeSeries.
  ///
  /// In en, this message translates to:
  /// **'Series'**
  String get modeSeries;

  /// No description provided for @modeTabata.
  ///
  /// In en, this message translates to:
  /// **'Tabata'**
  String get modeTabata;

  /// No description provided for @modeHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT'**
  String get modeHiit;

  /// No description provided for @modeCustom.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get modeCustom;

  /// No description provided for @prepareTime.
  ///
  /// In en, this message translates to:
  /// **'Prepare'**
  String get prepareTime;

  /// No description provided for @workTime.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get workTime;

  /// No description provided for @restTime.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get restTime;

  /// No description provided for @rounds.
  ///
  /// In en, this message translates to:
  /// **'Rounds'**
  String get rounds;

  /// No description provided for @exerciseLabel.
  ///
  /// In en, this message translates to:
  /// **'Exercise'**
  String get exerciseLabel;

  /// No description provided for @exerciseHint.
  ///
  /// In en, this message translates to:
  /// **'Push-ups, squats…'**
  String get exerciseHint;

  /// No description provided for @playlist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get playlist;

  /// No description provided for @noPlaylist.
  ///
  /// In en, this message translates to:
  /// **'No music'**
  String get noPlaylist;

  /// No description provided for @addSegment.
  ///
  /// In en, this message translates to:
  /// **'Add segment'**
  String get addSegment;

  /// No description provided for @presets.
  ///
  /// In en, this message translates to:
  /// **'Presets'**
  String get presets;

  /// No description provided for @yourRoutines.
  ///
  /// In en, this message translates to:
  /// **'Your routines'**
  String get yourRoutines;

  /// No description provided for @lastSession.
  ///
  /// In en, this message translates to:
  /// **'Ready when you are'**
  String get lastSession;

  /// No description provided for @createPlaylist.
  ///
  /// In en, this message translates to:
  /// **'New playlist'**
  String get createPlaylist;

  /// No description provided for @addToPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Add to playlist'**
  String get addToPlaylist;

  /// No description provided for @songs.
  ///
  /// In en, this message translates to:
  /// **'Songs'**
  String get songs;

  /// No description provided for @playlists.
  ///
  /// In en, this message translates to:
  /// **'Playlists'**
  String get playlists;

  /// No description provided for @permissionMusicTitle.
  ///
  /// In en, this message translates to:
  /// **'Your music stays on this phone'**
  String get permissionMusicTitle;

  /// No description provided for @permissionMusicBody.
  ///
  /// In en, this message translates to:
  /// **'Lejos plays files already on this phone and hides WhatsApp, ringtones and SFX. Beeps sit on top of the track. Nothing is uploaded.'**
  String get permissionMusicBody;

  /// No description provided for @allowAccess.
  ///
  /// In en, this message translates to:
  /// **'Allow access'**
  String get allowAccess;

  /// No description provided for @pickFiles.
  ///
  /// In en, this message translates to:
  /// **'Add files'**
  String get pickFiles;

  /// No description provided for @noSongs.
  ///
  /// In en, this message translates to:
  /// **'No songs found on this device.'**
  String get noSongs;

  /// No description provided for @nowPlaying.
  ///
  /// In en, this message translates to:
  /// **'Now playing'**
  String get nowPlaying;

  /// No description provided for @noHistory.
  ///
  /// In en, this message translates to:
  /// **'Finish a session and it will appear here.'**
  String get noHistory;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get languageSystem;

  /// No description provided for @languageEs.
  ///
  /// In en, this message translates to:
  /// **'Español'**
  String get languageEs;

  /// No description provided for @languageEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get languageEn;

  /// No description provided for @haptics.
  ///
  /// In en, this message translates to:
  /// **'Haptics'**
  String get haptics;

  /// No description provided for @countdownBeeps.
  ///
  /// In en, this message translates to:
  /// **'Countdown beeps'**
  String get countdownBeeps;

  /// No description provided for @musicDuringRest.
  ///
  /// In en, this message translates to:
  /// **'Music'**
  String get musicDuringRest;

  /// No description provided for @musicPause.
  ///
  /// In en, this message translates to:
  /// **'Pause on rest'**
  String get musicPause;

  /// No description provided for @musicDuck.
  ///
  /// In en, this message translates to:
  /// **'Slightly lower on rest'**
  String get musicDuck;

  /// No description provided for @musicKeep.
  ///
  /// In en, this message translates to:
  /// **'Keep playing'**
  String get musicKeep;

  /// No description provided for @musicOff.
  ///
  /// In en, this message translates to:
  /// **'Off'**
  String get musicOff;

  /// No description provided for @privacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get privacy;

  /// No description provided for @privacyBody.
  ///
  /// In en, this message translates to:
  /// **'Routines, history and playlists stay on this device. No account, no ads, no tracking. The AI coach sends your text or audio and, for playlists, only titles and artists — never the files — to Google Gemini.'**
  String get privacyBody;

  /// No description provided for @finishedTitle.
  ///
  /// In en, this message translates to:
  /// **'Session complete'**
  String get finishedTitle;

  /// No description provided for @finishedBody.
  ///
  /// In en, this message translates to:
  /// **'{time} of focused work'**
  String finishedBody(String time);

  /// No description provided for @backHome.
  ///
  /// In en, this message translates to:
  /// **'Back home'**
  String get backHome;

  /// No description provided for @untitled.
  ///
  /// In en, this message translates to:
  /// **'Untitled'**
  String get untitled;

  /// No description provided for @presetPushups.
  ///
  /// In en, this message translates to:
  /// **'Push-ups 3×1:00'**
  String get presetPushups;

  /// No description provided for @presetTabata.
  ///
  /// In en, this message translates to:
  /// **'Tabata 20/10'**
  String get presetTabata;

  /// No description provided for @presetHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT 40/20'**
  String get presetHiit;

  /// No description provided for @presetSprint.
  ///
  /// In en, this message translates to:
  /// **'10×5/10'**
  String get presetSprint;

  /// No description provided for @deleteRoutine.
  ///
  /// In en, this message translates to:
  /// **'Delete routine?'**
  String get deleteRoutine;

  /// No description provided for @confirmStop.
  ///
  /// In en, this message translates to:
  /// **'End this session?'**
  String get confirmStop;

  /// No description provided for @emptyPlaylists.
  ///
  /// In en, this message translates to:
  /// **'Create a playlist for your next session.'**
  String get emptyPlaylists;

  /// No description provided for @searchSongs.
  ///
  /// In en, this message translates to:
  /// **'Search songs'**
  String get searchSongs;

  /// No description provided for @artistUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown artist'**
  String get artistUnknown;

  /// No description provided for @workoutMusicHint.
  ///
  /// In en, this message translates to:
  /// **'Music keeps playing. Beeps sit on top.'**
  String get workoutMusicHint;

  /// No description provided for @cannotStart.
  ///
  /// In en, this message translates to:
  /// **'Add at least one work interval'**
  String get cannotStart;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @versionLabel.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String versionLabel(String version);

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open settings'**
  String get openSettings;

  /// No description provided for @playlistName.
  ///
  /// In en, this message translates to:
  /// **'Playlist name'**
  String get playlistName;

  /// No description provided for @removeTrack.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get removeTrack;

  /// No description provided for @playAll.
  ///
  /// In en, this message translates to:
  /// **'Play all'**
  String get playAll;

  /// No description provided for @noRoutines.
  ///
  /// In en, this message translates to:
  /// **'Create a routine to start training.'**
  String get noRoutines;

  /// No description provided for @segmentWork.
  ///
  /// In en, this message translates to:
  /// **'Work'**
  String get segmentWork;

  /// No description provided for @segmentRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get segmentRest;

  /// No description provided for @saveAndStart.
  ///
  /// In en, this message translates to:
  /// **'Save & start'**
  String get saveAndStart;

  /// No description provided for @historyCompleted.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get historyCompleted;

  /// No description provided for @historyStopped.
  ///
  /// In en, this message translates to:
  /// **'Stopped'**
  String get historyStopped;

  /// No description provided for @shuffle.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffle;

  /// No description provided for @repeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get repeat;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get previous;

  /// No description provided for @aboutPulse.
  ///
  /// In en, this message translates to:
  /// **'Lejos is an interval timer you can read from across the room: giant digits, a theme you pick, and music that never stops for a beep.'**
  String get aboutPulse;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Look'**
  String get appearance;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get themeLabel;

  /// No description provided for @timerLayout.
  ///
  /// In en, this message translates to:
  /// **'Timer layout'**
  String get timerLayout;

  /// No description provided for @layoutGiant.
  ///
  /// In en, this message translates to:
  /// **'Giant'**
  String get layoutGiant;

  /// No description provided for @layoutRing.
  ///
  /// In en, this message translates to:
  /// **'Ring'**
  String get layoutRing;

  /// No description provided for @layoutBoth.
  ///
  /// In en, this message translates to:
  /// **'Both'**
  String get layoutBoth;

  /// No description provided for @themeClock.
  ///
  /// In en, this message translates to:
  /// **'Clock'**
  String get themeClock;

  /// No description provided for @themeAtelier.
  ///
  /// In en, this message translates to:
  /// **'Atelier'**
  String get themeAtelier;

  /// No description provided for @themeLab.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get themeLab;

  /// No description provided for @themeTierra.
  ///
  /// In en, this message translates to:
  /// **'Tierra'**
  String get themeTierra;

  /// No description provided for @musicPolicyHint.
  ///
  /// In en, this message translates to:
  /// **'Beeps play over your playlist. On rest you can pause, dip the volume a little, or leave it.'**
  String get musicPolicyHint;

  /// No description provided for @sessionSummary.
  ///
  /// In en, this message translates to:
  /// **'{rounds} rounds · {work} work · {rest} rest'**
  String sessionSummary(int rounds, String work, String rest);

  /// No description provided for @sessionTotal.
  ///
  /// In en, this message translates to:
  /// **'Total {time}'**
  String sessionTotal(String time);

  /// No description provided for @customSummary.
  ///
  /// In en, this message translates to:
  /// **'{count} work intervals'**
  String customSummary(int count);

  /// No description provided for @cycleLayout.
  ///
  /// In en, this message translates to:
  /// **'Change timer layout'**
  String get cycleLayout;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @webDemoHint.
  ///
  /// In en, this message translates to:
  /// **'Web demo — full music library and lock-screen controls live in the Android app. Timer, themes and layouts work here.'**
  String get webDemoHint;

  /// No description provided for @emptyRoutinesBody.
  ///
  /// In en, this message translates to:
  /// **'Build a round of work and rest, then start. You can change the look anytime in Settings.'**
  String get emptyRoutinesBody;

  /// No description provided for @tapToPause.
  ///
  /// In en, this message translates to:
  /// **'Tap the numbers to pause'**
  String get tapToPause;

  /// No description provided for @emptyHistoryBody.
  ///
  /// In en, this message translates to:
  /// **'Finish a session and it will show up here.'**
  String get emptyHistoryBody;

  /// No description provided for @featuredReady.
  ///
  /// In en, this message translates to:
  /// **'Start here'**
  String get featuredReady;

  /// No description provided for @featuredLast.
  ///
  /// In en, this message translates to:
  /// **'Last time'**
  String get featuredLast;

  /// No description provided for @presetCopyHint.
  ///
  /// In en, this message translates to:
  /// **'Templates stay put. Saving creates your own version.'**
  String get presetCopyHint;

  /// No description provided for @savedAsCopy.
  ///
  /// In en, this message translates to:
  /// **'Saved as your routine'**
  String get savedAsCopy;

  /// No description provided for @nextUp.
  ///
  /// In en, this message translates to:
  /// **'Next: {phase} {time}'**
  String nextUp(String phase, String time);

  /// No description provided for @dismissHint.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get dismissHint;

  /// No description provided for @tapToStart.
  ///
  /// In en, this message translates to:
  /// **'Tap to start'**
  String get tapToStart;

  /// No description provided for @presetEmom.
  ///
  /// In en, this message translates to:
  /// **'EMOM 50/10'**
  String get presetEmom;

  /// No description provided for @presetBox.
  ///
  /// In en, this message translates to:
  /// **'Boxing 3×3'**
  String get presetBox;

  /// No description provided for @presetCore.
  ///
  /// In en, this message translates to:
  /// **'Core 30/15'**
  String get presetCore;

  /// No description provided for @presetWarmup.
  ///
  /// In en, this message translates to:
  /// **'Warm-up 20/10'**
  String get presetWarmup;

  /// No description provided for @presetLongHiit.
  ///
  /// In en, this message translates to:
  /// **'HIIT 45/15'**
  String get presetLongHiit;

  /// No description provided for @presetRun.
  ///
  /// In en, this message translates to:
  /// **'Run 90/30'**
  String get presetRun;

  /// No description provided for @presetStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength 45/90'**
  String get presetStrength;

  /// No description provided for @presetPyramid.
  ///
  /// In en, this message translates to:
  /// **'Pyramid'**
  String get presetPyramid;

  /// No description provided for @presetStretch.
  ///
  /// In en, this message translates to:
  /// **'Stretch 45/15'**
  String get presetStretch;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get onboardingStart;

  /// No description provided for @onboarding1Title.
  ///
  /// In en, this message translates to:
  /// **'Read it from across the room.'**
  String get onboarding1Title;

  /// No description provided for @onboarding1Body.
  ///
  /// In en, this message translates to:
  /// **'Giant digits, an optional ring, a theme you pick. Tap the clock to pause.'**
  String get onboarding1Body;

  /// No description provided for @onboarding2Title.
  ///
  /// In en, this message translates to:
  /// **'Music never stops for a beep.'**
  String get onboarding2Title;

  /// No description provided for @onboarding2Body.
  ///
  /// In en, this message translates to:
  /// **'Play files already on your phone. Cues sit on top. Nothing is uploaded.'**
  String get onboarding2Body;

  /// No description provided for @onboarding3Title.
  ///
  /// In en, this message translates to:
  /// **'Don\'t break the streak.'**
  String get onboarding3Title;

  /// No description provided for @onboarding3Body.
  ///
  /// In en, this message translates to:
  /// **'One finished session a day keeps the fire. Same idea as Duolingo, for training.'**
  String get onboarding3Body;

  /// No description provided for @onboarding4Title.
  ///
  /// In en, this message translates to:
  /// **'Say it. Lejos builds it.'**
  String get onboarding4Title;

  /// No description provided for @onboarding4Body.
  ///
  /// In en, this message translates to:
  /// **'Record a voice note or type: who you are, your week, or just today. Lejos builds the routine and a playlist from your music.'**
  String get onboarding4Body;

  /// No description provided for @streakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streakLabel;

  /// No description provided for @streakDays.
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(int count);

  /// No description provided for @streakLongest.
  ///
  /// In en, this message translates to:
  /// **'Best {count}'**
  String streakLongest(int count);

  /// No description provided for @streakTodayDone.
  ///
  /// In en, this message translates to:
  /// **'Today counts'**
  String get streakTodayDone;

  /// No description provided for @streakTodayTodo.
  ///
  /// In en, this message translates to:
  /// **'Train today to keep it'**
  String get streakTodayTodo;

  /// No description provided for @streakStartToday.
  ///
  /// In en, this message translates to:
  /// **'Start today'**
  String get streakStartToday;

  /// No description provided for @streakWeek.
  ///
  /// In en, this message translates to:
  /// **'{count} this week'**
  String streakWeek(int count);

  /// No description provided for @streakMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String streakMinutes(int minutes);

  /// No description provided for @coachTitle.
  ///
  /// In en, this message translates to:
  /// **'AI coach'**
  String get coachTitle;

  /// No description provided for @coachSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Tell it your day or your week. It can also build playlists from this phone.'**
  String get coachSubtitle;

  /// No description provided for @coachToday.
  ///
  /// In en, this message translates to:
  /// **'Just today'**
  String get coachToday;

  /// No description provided for @coachWeek.
  ///
  /// In en, this message translates to:
  /// **'The week'**
  String get coachWeek;

  /// No description provided for @coachPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Playlist'**
  String get coachPlaylist;

  /// No description provided for @coachHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. night sessions, 20 min HIIT today'**
  String get coachHint;

  /// No description provided for @coachHintPlaylist.
  ///
  /// In en, this message translates to:
  /// **'e.g. make a rock mix, or only Cuarteto de Nos'**
  String get coachHintPlaylist;

  /// No description provided for @coachRecord.
  ///
  /// In en, this message translates to:
  /// **'Record'**
  String get coachRecord;

  /// No description provided for @coachStopRecord.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get coachStopRecord;

  /// No description provided for @coachGenerate.
  ///
  /// In en, this message translates to:
  /// **'Build'**
  String get coachGenerate;

  /// No description provided for @coachSaveAll.
  ///
  /// In en, this message translates to:
  /// **'Save all'**
  String get coachSaveAll;

  /// No description provided for @coachSaveOne.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get coachSaveOne;

  /// No description provided for @coachStartThis.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get coachStartThis;

  /// No description provided for @coachEmpty.
  ///
  /// In en, this message translates to:
  /// **'No plan yet. Type or record, then build.'**
  String get coachEmpty;

  /// No description provided for @coachNeedKey.
  ///
  /// In en, this message translates to:
  /// **'The coach needs a Gemini key. Paste it in Settings, or ask whoever sent you the app.'**
  String get coachNeedKey;

  /// No description provided for @coachNeedMusic.
  ///
  /// In en, this message translates to:
  /// **'Allow access to your music first.'**
  String get coachNeedMusic;

  /// No description provided for @coachSavedRoutines.
  ///
  /// In en, this message translates to:
  /// **'Routines saved'**
  String get coachSavedRoutines;

  /// No description provided for @coachSavedPlaylist.
  ///
  /// In en, this message translates to:
  /// **'Playlist ready'**
  String get coachSavedPlaylist;

  /// No description provided for @coachError.
  ///
  /// In en, this message translates to:
  /// **'Could not build that. Try again or shorten the request.'**
  String get coachError;

  /// No description provided for @coachVoiceHint.
  ///
  /// In en, this message translates to:
  /// **'Say who you are and what you want today or this week.'**
  String get coachVoiceHint;

  /// No description provided for @nowPlayingQueue.
  ///
  /// In en, this message translates to:
  /// **'Up next'**
  String get nowPlayingQueue;

  /// No description provided for @repeatOne.
  ///
  /// In en, this message translates to:
  /// **'Repeat track'**
  String get repeatOne;

  /// No description provided for @repeatAll.
  ///
  /// In en, this message translates to:
  /// **'Repeat queue'**
  String get repeatAll;

  /// No description provided for @repeatOff.
  ///
  /// In en, this message translates to:
  /// **'Repeat off'**
  String get repeatOff;

  /// No description provided for @shuffleOn.
  ///
  /// In en, this message translates to:
  /// **'Shuffle'**
  String get shuffleOn;

  /// No description provided for @aiMix.
  ///
  /// In en, this message translates to:
  /// **'Build with AI'**
  String get aiMix;

  /// No description provided for @filterShort.
  ///
  /// In en, this message translates to:
  /// **'Music only'**
  String get filterShort;

  /// No description provided for @showAllSongs.
  ///
  /// In en, this message translates to:
  /// **'Everything'**
  String get showAllSongs;

  /// No description provided for @hiddenJunk.
  ///
  /// In en, this message translates to:
  /// **'{hidden} clips hidden (WhatsApp, SFX, ringtones)'**
  String hiddenJunk(int hidden);

  /// No description provided for @replayOnboarding.
  ///
  /// In en, this message translates to:
  /// **'Replay intro'**
  String get replayOnboarding;

  /// No description provided for @geminiKeyLabel.
  ///
  /// In en, this message translates to:
  /// **'Gemini key (optional)'**
  String get geminiKeyLabel;

  /// No description provided for @geminiKeyHint.
  ///
  /// In en, this message translates to:
  /// **'Only if the coach is not baked into this build'**
  String get geminiKeyHint;

  /// No description provided for @coachReady.
  ///
  /// In en, this message translates to:
  /// **'Coach is ready on this device'**
  String get coachReady;

  /// No description provided for @historyRepeat.
  ///
  /// In en, this message translates to:
  /// **'Repeat'**
  String get historyRepeat;

  /// No description provided for @dayToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get dayToday;

  /// No description provided for @dayYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get dayYesterday;

  /// No description provided for @seek.
  ///
  /// In en, this message translates to:
  /// **'Position'**
  String get seek;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
