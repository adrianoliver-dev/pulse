// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Lejos';

  @override
  String get tagline => 'Se lee de lejos.';

  @override
  String get navHome => 'Entrenar';

  @override
  String get navMusic => 'Música';

  @override
  String get navHistory => 'Historial';

  @override
  String get navSettings => 'Ajustes';

  @override
  String get start => 'Empezar';

  @override
  String get play => 'Play';

  @override
  String get pause => 'Pausa';

  @override
  String get resume => 'Seguir';

  @override
  String get skip => 'Saltar';

  @override
  String get stop => 'Terminar';

  @override
  String get done => 'Listo';

  @override
  String get save => 'Guardar';

  @override
  String get cancel => 'Cancelar';

  @override
  String get delete => 'Eliminar';

  @override
  String get ok => 'OK';

  @override
  String get prepare => 'Preparación';

  @override
  String get work => 'Trabajo';

  @override
  String get rest => 'Descanso';

  @override
  String roundOf(int current, int total) {
    return 'Ronda $current de $total';
  }

  @override
  String totalRemaining(String time) {
    return '$time restantes';
  }

  @override
  String get newRoutine => 'Nueva rutina';

  @override
  String get editRoutine => 'Editar rutina';

  @override
  String get nameLabel => 'Nombre';

  @override
  String get modeLabel => 'Modo';

  @override
  String get modeSeries => 'Series';

  @override
  String get modeTabata => 'Tabata';

  @override
  String get modeHiit => 'HIIT';

  @override
  String get modeCustom => 'Personalizado';

  @override
  String get prepareTime => 'Preparación';

  @override
  String get workTime => 'Trabajo';

  @override
  String get restTime => 'Descanso';

  @override
  String get rounds => 'Series';

  @override
  String get exerciseLabel => 'Ejercicio';

  @override
  String get exerciseHint => 'Lagartijas, sentadillas…';

  @override
  String get playlist => 'Playlist';

  @override
  String get noPlaylist => 'Sin música';

  @override
  String get addSegment => 'Añadir segmento';

  @override
  String get presets => 'Plantillas';

  @override
  String get yourRoutines => 'Tus rutinas';

  @override
  String get lastSession => 'Cuando quieras';

  @override
  String get createPlaylist => 'Nueva playlist';

  @override
  String get addToPlaylist => 'Añadir a playlist';

  @override
  String get songs => 'Canciones';

  @override
  String get playlists => 'Playlists';

  @override
  String get permissionMusicTitle => 'Tu música se queda en el teléfono';

  @override
  String get permissionMusicBody =>
      'Lejos reproduce lo que ya está en el teléfono y esconde WhatsApp, tonos y SFX. Los beeps van encima de la canción. Nada se sube a internet.';

  @override
  String get allowAccess => 'Permitir acceso';

  @override
  String get pickFiles => 'Añadir archivos';

  @override
  String get noSongs => 'No hay canciones en este dispositivo.';

  @override
  String get nowPlaying => 'Reproduciendo';

  @override
  String get noHistory => 'Termina una sesión y aparecerá aquí.';

  @override
  String get language => 'Idioma';

  @override
  String get languageSystem => 'Sistema';

  @override
  String get languageEs => 'Español';

  @override
  String get languageEn => 'English';

  @override
  String get haptics => 'Hápticos';

  @override
  String get countdownBeeps => 'Beeps de cuenta atrás';

  @override
  String get musicDuringRest => 'Música';

  @override
  String get musicPause => 'Pausar en el descanso';

  @override
  String get musicDuck => 'Bajar un poco en el descanso';

  @override
  String get musicKeep => 'Seguir sonando';

  @override
  String get musicOff => 'Apagada';

  @override
  String get privacy => 'Privacidad';

  @override
  String get privacyBody =>
      'Rutinas, historial y playlists se quedan en este dispositivo. Sin cuenta, sin anuncios, sin rastreo. El coach de IA envía tu texto o audio y, si armas una playlist, solo títulos y artistas — nunca los archivos — a Google Gemini.';

  @override
  String get finishedTitle => 'Sesión completa';

  @override
  String finishedBody(String time) {
    return '$time de trabajo enfocado';
  }

  @override
  String get backHome => 'Volver';

  @override
  String get untitled => 'Sin título';

  @override
  String get presetPushups => 'Lagartijas 3×1:00';

  @override
  String get presetTabata => 'Tabata 20/10';

  @override
  String get presetHiit => 'HIIT 40/20';

  @override
  String get presetSprint => '10×5/10';

  @override
  String get deleteRoutine => '¿Eliminar rutina?';

  @override
  String get confirmStop => '¿Terminar esta sesión?';

  @override
  String get emptyPlaylists => 'Crea una playlist para tu próxima sesión.';

  @override
  String get searchSongs => 'Buscar canciones';

  @override
  String get artistUnknown => 'Artista desconocido';

  @override
  String get workoutMusicHint =>
      'La música no se detiene. Los beeps suenan encima.';

  @override
  String get cannotStart => 'Añade al menos un intervalo de trabajo';

  @override
  String get saved => 'Guardado';

  @override
  String versionLabel(String version) {
    return 'Versión $version';
  }

  @override
  String get openSettings => 'Abrir ajustes';

  @override
  String get playlistName => 'Nombre de la playlist';

  @override
  String get removeTrack => 'Quitar';

  @override
  String get playAll => 'Reproducir';

  @override
  String get noRoutines => 'Crea una rutina para empezar.';

  @override
  String get segmentWork => 'Trabajo';

  @override
  String get segmentRest => 'Descanso';

  @override
  String get saveAndStart => 'Guardar y empezar';

  @override
  String get historyCompleted => 'Completada';

  @override
  String get historyStopped => 'Detenida';

  @override
  String get shuffle => 'Aleatorio';

  @override
  String get repeat => 'Repetir';

  @override
  String get next => 'Siguiente';

  @override
  String get previous => 'Anterior';

  @override
  String get aboutPulse =>
      'Lejos es un temporizador de intervalos para leer al otro lado del cuarto: números gigantes, un tema que eliges, y música que no se corta cuando suena el beep.';

  @override
  String get appearance => 'Apariencia';

  @override
  String get themeLabel => 'Tema';

  @override
  String get timerLayout => 'Formato del contador';

  @override
  String get layoutGiant => 'Gigante';

  @override
  String get layoutRing => 'Anillo';

  @override
  String get layoutBoth => 'Ambos';

  @override
  String get themeClock => 'Reloj';

  @override
  String get themeAtelier => 'Atelier';

  @override
  String get themeLab => 'Lab';

  @override
  String get themeTierra => 'Tierra';

  @override
  String get musicPolicyHint =>
      'Los beeps suenan encima de la playlist. En el descanso puedes pausar, bajar un poco o dejarla igual.';

  @override
  String sessionSummary(int rounds, String work, String rest) {
    return '$rounds rondas · $work trabajo · $rest descanso';
  }

  @override
  String sessionTotal(String time) {
    return 'Total $time';
  }

  @override
  String customSummary(int count) {
    return '$count intervalos de trabajo';
  }

  @override
  String get cycleLayout => 'Cambiar formato del contador';

  @override
  String get edit => 'Editar';

  @override
  String get webDemoHint =>
      'Demo web — la biblioteca de música y el control en pantalla bloqueada van en Android. Aquí puedes probar el timer, los temas y los formatos.';

  @override
  String get emptyRoutinesBody =>
      'Arma trabajo y descanso, y dale a empezar. El aspecto se cambia cuando quieras en Ajustes.';

  @override
  String get tapToPause => 'Toca los números para pausar';

  @override
  String get emptyHistoryBody => 'Termina una sesión y aparecerá aquí.';

  @override
  String get featuredReady => 'Empieza aquí';

  @override
  String get featuredLast => 'Última vez';

  @override
  String get presetCopyHint =>
      'Las plantillas no se pisan. Al guardar se crea tu versión.';

  @override
  String get savedAsCopy => 'Guardado como tu rutina';

  @override
  String nextUp(String phase, String time) {
    return 'Luego: $phase $time';
  }

  @override
  String get dismissHint => 'Cerrar';

  @override
  String get tapToStart => 'Toca para empezar';

  @override
  String get presetEmom => 'EMOM 50/10';

  @override
  String get presetBox => 'Boxeo 3×3';

  @override
  String get presetCore => 'Core 30/15';

  @override
  String get presetWarmup => 'Calentamiento 20/10';

  @override
  String get presetLongHiit => 'HIIT 45/15';

  @override
  String get presetRun => 'Correr 90/30';

  @override
  String get presetStrength => 'Fuerza 45/90';

  @override
  String get presetPyramid => 'Pirámide';

  @override
  String get presetStretch => 'Estirar 45/15';

  @override
  String get onboardingSkip => 'Saltar';

  @override
  String get onboardingNext => 'Siguiente';

  @override
  String get onboardingStart => 'Empezar';

  @override
  String get onboarding1Title => 'El reloj, lejos.';

  @override
  String get onboarding1Body =>
      'Números grandes, anillo opcional y un tema que eliges. Toca el contador para pausar.';

  @override
  String get onboarding2Title => 'La música no se corta.';

  @override
  String get onboarding2Body =>
      'Usa lo que ya tienes en el teléfono. Los beeps suenan encima. Nada se sube a internet.';

  @override
  String get onboarding3Title => 'No rompas la racha.';

  @override
  String get onboarding3Body =>
      'Un día cuenta. Termina una sesión y el fuego sigue. Igual que en Duolingo, pero para entrenar.';

  @override
  String get onboarding4Title => 'Dilo, y se arma.';

  @override
  String get onboarding4Body =>
      'Graba un audio o escribe: quién eres, tu semana o solo el día. Lejos te arma la rutina y una playlist de tu música.';

  @override
  String get streakLabel => 'Racha';

  @override
  String streakDays(int count) {
    return '$count días';
  }

  @override
  String streakLongest(int count) {
    return 'Mejor $count';
  }

  @override
  String get streakTodayDone => 'Hoy ya cuenta';

  @override
  String get streakTodayTodo => 'Entrena hoy y no se rompe';

  @override
  String get streakStartToday => 'Empieza hoy';

  @override
  String streakWeek(int count) {
    return '$count esta semana';
  }

  @override
  String streakMinutes(int minutes) {
    return '$minutes min';
  }

  @override
  String get coachTitle => 'Coach IA';

  @override
  String get coachSubtitle =>
      'Dile tu día o tu semana. También arma playlists de tu teléfono.';

  @override
  String get coachToday => 'Solo hoy';

  @override
  String get coachWeek => 'La semana';

  @override
  String get coachPlaylist => 'Playlist';

  @override
  String get coachHint =>
      'Ej: soy Adrián, entreno de noche, quiero HIIT de 20 min hoy';

  @override
  String get coachHintPlaylist =>
      'Ej: armame un mix de rock, o puro Cuarteto de Nos';

  @override
  String get coachRecord => 'Grabar';

  @override
  String get coachStopRecord => 'Parar';

  @override
  String get coachGenerate => 'Armar';

  @override
  String get coachSaveAll => 'Guardar todo';

  @override
  String get coachSaveOne => 'Guardar';

  @override
  String get coachStartThis => 'Empezar';

  @override
  String get coachEmpty =>
      'Todavía no hay un plan. Escribe o graba y dale a armar.';

  @override
  String get coachNeedKey =>
      'El coach necesita una clave de Gemini. Pégala en Ajustes, o pide otra al que te pasó la app.';

  @override
  String get coachNeedMusic => 'Primero permite el acceso a tu música.';

  @override
  String get coachSavedRoutines => 'Rutinas guardadas';

  @override
  String get coachSavedPlaylist => 'Playlist lista';

  @override
  String get coachError =>
      'No se pudo armar. Prueba de nuevo o acorta el pedido.';

  @override
  String get coachVoiceHint =>
      'Habla: quién eres, qué quieres hoy o en la semana.';

  @override
  String get nowPlayingQueue => 'En cola';

  @override
  String get repeatOne => 'Repetir canción';

  @override
  String get repeatAll => 'Repetir lista';

  @override
  String get repeatOff => 'Sin repetir';

  @override
  String get shuffleOn => 'Aleatorio';

  @override
  String get aiMix => 'Armar con IA';

  @override
  String get filterShort => 'Solo música';

  @override
  String get showAllSongs => 'Todo el teléfono';

  @override
  String hiddenJunk(int hidden) {
    return '$hidden audios ocultos (WhatsApp, SFX, tonos)';
  }

  @override
  String get replayOnboarding => 'Ver introducción otra vez';

  @override
  String get geminiKeyLabel => 'Clave de Gemini (opcional)';

  @override
  String get geminiKeyHint => 'Solo si el coach no está activo en este build';

  @override
  String get coachReady => 'Coach listo en este dispositivo';

  @override
  String get historyRepeat => 'Repetir';

  @override
  String get dayToday => 'Hoy';

  @override
  String get dayYesterday => 'Ayer';

  @override
  String get seek => 'Posición';
}
