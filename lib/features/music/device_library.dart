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
  });

  final String id;
  final String title;
  final String artist;
  final String uri;
  final int durationMs;
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
          .where((s) => (s.uri ?? s.data).isNotEmpty)
          .map(
            (s) => DeviceSong(
              id: '${s.id}',
              title: s.title,
              artist: s.artist ?? '',
              uri: s.uri ?? s.data,
              durationMs: s.duration ?? 0,
            ),
          )
          .toList();
      return DeviceLibrary(granted: true, songs: [...scanned, ..._picked]);
    } catch (_) {
      return DeviceLibrary(granted: true, songs: _picked);
    }
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
