// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Pulse';

  @override
  String get tagline => 'Focus on the work.';

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
  String get permissionMusicBody => 'Pulse plays files you already downloaded. Music keeps going through work and rest. Beeps sit on top — nothing is uploaded.';

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
  String get privacyBody => 'Pulse stores routines, history and playlists only on this device. No account, no ads, no tracking.';

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
  String get aboutPulse => 'Pulse is an interval timer you can read from across the room: giant digits, a theme you pick, and music that never stops for a beep.';

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
  String get musicPolicyHint => 'Beeps play over your playlist. On rest you can pause, dip the volume a little, or leave it.';

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
  String get webDemoHint => 'Web demo — full music library and lock-screen controls live in the Android app. Timer, themes and layouts work here.';

  @override
  String get emptyRoutinesBody => 'Build a round of work and rest, then start. You can change the look anytime in Settings.';

  @override
  String get tapToPause => 'Tap the numbers to pause';

  @override
  String get emptyHistoryBody => 'Finish a session and it will show up here.';

  @override
  String get featuredReady => 'Start here';

  @override
  String get featuredLast => 'Last time';

  @override
  String get presetCopyHint => 'Templates stay put. Saving creates your own version.';

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
}
