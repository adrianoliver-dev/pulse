import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class DeviceSong {
  const DeviceSong({
    required this.id,
    required this.title,
    required this.artist,
    required this.uri,
    required this.durationMs,
    this.album = '',
  });

  final String id;
  final String title;
  final String artist;
  final String uri;
  final int durationMs;
  final String album;

  bool get isLikelyMusic {
    final blob = '$title $artist $album $uri'.toLowerCase();
    const junk = [
      'whatsapp',
      'telegram',
      'recording',
      'grabación',
      'grabacion',
      'voice note',
      'nota de voz',
      'audionota',
      'audio notes',
      'voice messages',
      'call recording',
      'llamada',
      'ringtone',
      'ringtones',
      'notification',
      'notificaciones',
      'alarm',
      'alarms',
      'alarma',
      'sound effect',
      'soundeffects',
      'sfx',
      'ui sound',
      'tts',
      'samsung',
      'miui',
      'pixel sounds',
      'recordings',
      'bluetooth',
      'ptt-',
      'aud-',
      '/whatsapp/',
      '/alarms/',
      '/notifications/',
      '/ringtones/',
      '/recordings/',
    ];
    if (junk.any(blob.contains)) return false;
    if (durationMs > 0 && durationMs < 45000) return false;
    if (durationMs > 20 * 60 * 1000) return false;
    return true;
  }
}

class DeviceLibrary {
  const DeviceLibrary({
    required this.granted,
    required this.songs,
  });

  final bool granted;
  final List<DeviceSong> songs;
}

class DeviceLibraryNotifier extends AsyncNotifier<DeviceLibrary> {
  OnAudioQuery? _query;
  List<DeviceSong> _picked = const [];

  @override
  Future<DeviceLibrary> build() => load();

  Future<bool> _hasPermission() async {
    if (kIsWeb) return true;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return Permission.mediaLibrary.isGranted;
    }
    if (await Permission.audio.isGranted) return true;
    if (await Permission.storage.isGranted) return true;
    return false;
  }

  Future<bool> request() async {
    if (kIsWeb) {
      state = AsyncData(await load());
      return true;
    }
    PermissionStatus status;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      status = await Permission.mediaLibrary.request();
    } else {
      status = await Permission.audio.request();
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
    }
    await Permission.notification.request();
    state = const AsyncLoading();
    state = AsyncData(await load());
    return status.isGranted;
  }

  Future<DeviceLibrary> load() async {
    if (kIsWeb) {
      return DeviceLibrary(granted: true, songs: _picked);
    }
    final granted = await _hasPermission();
    if (!granted) {
      return DeviceLibrary(granted: false, songs: _picked);
    }
    try {
      _query ??= OnAudioQuery();
      final raw = await _query!.querySongs(
        sortType: SongSortType.TITLE,
        orderType: OrderType.ASC_OR_SMALLER,
        uriType: UriType.EXTERNAL,
        ignoreCase: true,
      );
      final scanned = raw
          .where(_keepSong)
          .map(
            (s) => DeviceSong(
              id: '${s.id}',
              title: s.title,
              artist: s.artist ?? '',
              uri: s.uri ?? s.data,
              durationMs: s.duration ?? 0,
              album: s.album ?? '',
            ),
          )
          .toList();
      return DeviceLibrary(granted: true, songs: [...scanned, ..._picked]);
    } catch (_) {
      return DeviceLibrary(granted: true, songs: _picked);
    }
  }

  bool _keepSong(SongModel s) {
    if ((s.uri ?? s.data).isEmpty) return false;
    if (s.isRingtone == true || s.isNotification == true || s.isAlarm == true) {
      return false;
    }
    return true;
  }

  Future<List<DeviceSong>> pickFiles() async {
    final files = await FilePicker.pickFiles(type: FileType.audio);
    final songs = <DeviceSong>[];
    for (final f in files) {
      final path = f.path;
      final uri = (path != null && path.isNotEmpty)
          ? path
          : Uri.dataFromBytes(
              await f.readAsBytes(),
              mimeType: 'audio/mpeg',
            ).toString();
      songs.add(
        DeviceSong(
          id: uri,
          title: f.name,
          artist: '',
          uri: uri,
          durationMs: 0,
        ),
      );
    }
    if (songs.isNotEmpty) {
      _picked = [..._picked, ...songs];
      final current = state.valueOrNull;
      state = AsyncData(
        DeviceLibrary(
          granted: current?.granted ?? kIsWeb,
          songs: [...?current?.songs, ...songs],
        ),
      );
    }
    return songs;
  }

  Future<void> reload() async {
    state = const AsyncLoading();
    state = AsyncData(await load());
  }
}

final deviceLibraryProvider =
    AsyncNotifierProvider<DeviceLibraryNotifier, DeviceLibrary>(
      DeviceLibraryNotifier.new,
    );
