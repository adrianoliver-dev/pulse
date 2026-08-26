// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Lejos';

  @override
  String get tagline => 'Read it from across the room.';

  @override
  String get navHome => 'Train';

  @override
  String get navMusic => 'Music';

  @override
  String get navHistory => 'History';

  @override
  String get navSettings => 'Settings';

  @override
  String get start => 'Start';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pause';

  @override
  String get resume => 'Resume';

  @override
  String get skip => 'Skip';

  @override
  String get stop => 'End';

  @override
  String get done => 'Done';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get ok => 'OK';

  @override
  String get prepare => 'Prepare';

  @override
  String get work => 'Work';

  @override
  String get rest => 'Rest';

  @override
  String roundOf(int current, int total) {
    return 'Round $current of $total';
  }

  @override
  String totalRemaining(String time) {
    return '$time left';
  }

  @override
  String get newRoutine => 'New routine';

  @override
  String get editRoutine => 'Edit routine';

  @override
  String get nameLabel => 'Name';

  @override
  String get modeLabel => 'Mode';

  @override
  String get modeSeries => 'Series';

  @override
  String get modeTabata => 'Tabata';

  @override
  String get modeHiit => 'HIIT';

  @override
  String get modeCustom => 'Custom';

  @override
  String get prepareTime => 'Prepare';

  @override
  String get workTime => 'Work';

  @override
  String get restTime => 'Rest';

  @override
  String get rounds => 'Rounds';

  @override
  String get exerciseLabel => 'Exercise';

  @override
  String get exerciseHint => 'Push-ups, squats…';

  @override
  String get playlist => 'Playlist';

  @override
  String get noPlaylist => 'No music';

  @override
  String get addSegment => 'Add segment';

  @override
  String get presets => 'Presets';

  @override
  String get yourRoutines => 'Your routines';

  @override
  String get lastSession => 'Ready when you are';

  @override
  String get createPlaylist => 'New playlist';

  @override
  String get addToPlaylist => 'Add to playlist';

  @override
  String get songs => 'Songs';

  @override
  String get playlists => 'Playlists';

  @override
  String get permissionMusicTitle => 'Your music stays on this phone';

  @override
  String get permissionMusicBody =>
      'Lejos plays files already on this phone and hides WhatsApp, ringtones and SFX. Beeps sit on top of the track. Nothing is uploaded.';

  @override
  String get allowAccess => 'Allow access';

  @override
  String get pickFiles => 'Add files';

  @override
  String get noSongs => 'No songs found on this device.';

  @override
  String get nowPlaying => 'Now playing';

  @override
  String get noHistory => 'Finish a session and it will appear here.';

  @override
  String get language => 'Language';

  @override
  String get languageSystem => 'System';

  @override
  String get languageEs => 'Español';

  @override
  String get languageEn => 'English';

  @override
  String get haptics => 'Haptics';

  @override
  String get countdownBeeps => 'Countdown beeps';

  @override
  String get musicDuringRest => 'Music';

  @override
  String get musicPause => 'Pause on rest';

  @override
  String get musicDuck => 'Slightly lower on rest';

  @override
  String get musicKeep => 'Keep playing';

  @override
  String get musicOff => 'Off';

  @override
  String get privacy => 'Privacy';

  @override
  String get privacyBody =>
      'Routines, history and playlists stay on this device. No account, no ads, no tracking. The AI coach sends your text or audio and, for playlists, only titles and artists — never the files — to Google Gemini.';

  @override
  String get finishedTitle => 'Session complete';

  @override
  String finishedBody(String time) {
    return '$time of focused work';
  }

  @override
  String get backHome => 'Back home';

  @override
  String get untitled => 'Untitled';

  @override
  String get presetPushups => 'Push-ups 3×1:00';

  @override
  String get presetTabata => 'Tabata 20/10';

  @override
  String get presetHiit => 'HIIT 40/20';

  @override
  String get presetSprint => '10×5/10';

  @override
  String get deleteRoutine => 'Delete routine?';

  @override
  String get confirmStop => 'End this session?';

  @override
  String get emptyPlaylists => 'Create a playlist for your next session.';

  @override
  String get searchSongs => 'Search songs';

  @override
  String get artistUnknown => 'Unknown artist';

  @override
  String get workoutMusicHint => 'Music keeps playing. Beeps sit on top.';

  @override
  String get cannotStart => 'Add at least one work interval';

  @override
  String get saved => 'Saved';

  @override
  String versionLabel(String version) {
    return 'Version $version';
  }

  @override
  String get openSettings => 'Open settings';

  @override
  String get playlistName => 'Playlist name';

  @override
  String get removeTrack => 'Remove';

  @override
  String get playAll => 'Play all';

  @override
  String get noRoutines => 'Create a routine to start training.';

  @override
  String get segmentWork => 'Work';

  @override
  String get segmentRest => 'Rest';

  @override
  String get saveAndStart => 'Save & start';

  @override
  String get historyCompleted => 'Completed';

  @override
  String get historyStopped => 'Stopped';

  @override
  String get shuffle => 'Shuffle';

  @override
  String get repeat => 'Repeat';

  @override
  String get next => 'Next';

  @override
  String get previous => 'Previous';

  @override
  String get aboutPulse =>
      'Lejos is an interval timer you can read from across the room: giant digits, a theme you pick, and music that never stops for a beep.';

  @override
  String get appearance => 'Look';

  @override
  String get themeLabel => 'Theme';

  @override
  String get timerLayout => 'Timer layout';

  @override
  String get layoutGiant => 'Giant';

  @override
  String get layoutRing => 'Ring';

  @override
  String get layoutBoth => 'Both';

  @override
  String get themeClock => 'Clock';

  @override
  String get themeAtelier => 'Atelier';

  @override
  String get themeLab => 'Lab';

  @override
  String get themeTierra => 'Tierra';

  @override
  String get musicPolicyHint =>
      'Beeps play over your playlist. On rest you can pause, dip the volume a little, or leave it.';

  @override
  String sessionSummary(int rounds, String work, String rest) {
    return '$rounds rounds · $work work · $rest rest';
  }

  @override
  String sessionTotal(String time) {
    return 'Total $time';
  }

  @override
  String customSummary(int count) {
    return '$count work intervals';
  }

  @override
  String get cycleLayout => 'Change timer layout';

  @override
  String get edit => 'Edit';

  @override
  String get webDemoHint =>
      'Web demo — full music library and lock-screen controls live in the Android app. Timer, themes and layouts work here.';

  @override
  String get emptyRoutinesBody =>
      'Build a round of work and rest, then start. You can change the look anytime in Settings.';

  @override
  String get tapToPause => 'Tap the numbers to pause';

  @override
  String get emptyHistoryBody => 'Finish a session and it will show up here.';

  @override
  String get featuredReady => 'Start here';

  @override
  String get featuredLast => 'Last time';

  @override
  String get presetCopyHint =>
      'Templates stay put. Saving creates your own version.';

  @override
  String get savedAsCopy => 'Saved as your routine';

  @override
  String nextUp(String phase, String time) {
    return 'Next: $phase $time';
  }

  @override
  String get dismissHint => 'Dismiss';

  @override
  String get tapToStart => 'Tap to start';

  @override
  String get presetEmom => 'EMOM 50/10';

  @override
  String get presetBox => 'Boxing 3×3';

  @override
  String get presetCore => 'Core 30/15';

  @override
  String get presetWarmup => 'Warm-up 20/10';

  @override
  String get presetLongHiit => 'HIIT 45/15';

  @override
  String get presetRun => 'Run 90/30';

  @override
  String get presetStrength => 'Strength 45/90';

  @override
  String get presetPyramid => 'Pyramid';

  @override
  String get presetStretch => 'Stretch 45/15';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingNext => 'Next';

  @override
  String get onboardingStart => 'Start';

  @override
  String get onboarding1Title => 'Read it from across the room.';

  @override
  String get onboarding1Body =>
      'Giant digits, an optional ring, a theme you pick. Tap the clock to pause.';

  @override
  String get onboarding2Title => 'Music never stops for a beep.';

  @override
  String get onboarding2Body =>
      'Play files already on your phone. Cues sit on top. Nothing is uploaded.';

  @override
  String get onboarding3Title => 'Don\'t break the streak.';

  @override
  String get onboarding3Body =>
      'One finished session a day keeps the fire. Same idea as Duolingo, for training.';

  @override
  String get onboarding4Title => 'Say it. Lejos builds it.';

  @override
  String get onboarding4Body =>
      'Record a voice note or type: who you are, your week, or just today. Lejos builds the routine and a playlist from your music.';

  @override
  String get streakLabel => 'Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String streakLongest(int count) {
    return 'Best $count';
  }

  @override
  String get streakTodayDone => 'Today counts';

  @override
  String get streakTodayTodo => 'Train today to keep it';

  @override
  String get streakStartToday => 'Start today';

  @override
  String streakWeek(int count) {
    return '$count this week';
  }

  @override
  String streakMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get coachTitle => 'AI coach';

  @override
  String get coachSubtitle =>
      'Tell it your day or your week. It can also build playlists from this phone.';

  @override
  String get coachToday => 'Just today';

  @override
  String get coachWeek => 'The week';

  @override
  String get coachPlaylist => 'Playlist';

  @override
  String get coachHint => 'e.g. night sessions, 20 min HIIT today';

  @override
  String get coachHintPlaylist =>
      'e.g. make a rock mix, or only Cuarteto de Nos';

  @override
  String get coachRecord => 'Record';

  @override
  String get coachStopRecord => 'Stop';

  @override
  String get coachGenerate => 'Build';

  @override
  String get coachSaveAll => 'Save all';

  @override
  String get coachSaveOne => 'Save';

  @override
  String get coachStartThis => 'Start';

  @override
  String get coachEmpty => 'No plan yet. Type or record, then build.';

  @override
  String get coachNeedKey =>
      'The coach needs a Gemini key. Paste it in Settings, or ask whoever sent you the app.';

  @override
  String get coachNeedMusic => 'Allow access to your music first.';

  @override
  String get coachSavedRoutines => 'Routines saved';

  @override
  String get coachSavedPlaylist => 'Playlist ready';

  @override
  String get coachError =>
      'Could not build that. Try again or shorten the request.';

  @override
  String get coachVoiceHint =>
      'Say who you are and what you want today or this week.';

  @override
  String get nowPlayingQueue => 'Up next';

  @override
  String get repeatOne => 'Repeat track';

  @override
  String get repeatAll => 'Repeat queue';

  @override
  String get repeatOff => 'Repeat off';

  @override
  String get shuffleOn => 'Shuffle';

  @override
  String get aiMix => 'Build with AI';

  @override
  String get filterShort => 'Music only';

  @override
  String get showAllSongs => 'Everything';

  @override
  String hiddenJunk(int hidden) {
    return '$hidden clips hidden (WhatsApp, SFX, ringtones)';
  }

  @override
  String get replayOnboarding => 'Replay intro';

  @override
  String get geminiKeyLabel => 'Gemini key (optional)';

  @override
  String get geminiKeyHint => 'Only if the coach is not baked into this build';

  @override
  String get coachReady => 'Coach is ready on this device';

  @override
  String get historyRepeat => 'Repeat';

  @override
  String get dayToday => 'Today';

  @override
  String get dayYesterday => 'Yesterday';

  @override
  String get seek => 'Position';
}
