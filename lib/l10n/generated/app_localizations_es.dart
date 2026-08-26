// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Pulse';

  @override
  String get tagline => 'Enfócate en el ejercicio.';

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
      'Pulse reproduce archivos que ya descargaste. La música sigue en trabajo y descanso. Los beeps suenan encima. Nada se sube a internet.';

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
      'Pulse guarda rutinas, historial y playlists solo en este dispositivo. Sin cuenta, sin anuncios, sin rastreo.';

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
      'Pulse es un temporizador de intervalos para leer de lejos: números grandes, un tema que eliges, y música que no se corta cuando suena el beep.';

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
}
