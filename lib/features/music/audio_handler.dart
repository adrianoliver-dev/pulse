import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class PulseAudioHandler extends BaseAudioHandler with QueueHandler, SeekHandler {
  PulseAudioHandler() {
    _init();
  }

  final AudioPlayer player = AudioPlayer();
  List<MediaItem> _items = [];
  MediaItem? _baseItem;
  String? _overrideTitle;
  String? _overrideSubtitle;
  double _userVolume = 1;

  Future<void> _init() async {
    if (!kIsWeb) {
      try {
        final session = await AudioSession.instance;
        await session.configure(
          const AudioSessionConfiguration.music().copyWith(
            avAudioSessionCategoryOptions: AVAudioSessionCategoryOptions.mixWithOthers,
            androidWillPauseWhenDucked: false,
          ),
        );
      } catch (_) {}
    }

    player.playerStateStream.listen((_) => _broadcast());
    player.currentIndexStream.listen((_) => _syncItem());
    player.positionStream.listen((_) {});
    player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) {
        _broadcast();
      }
    });
    player.shuffleModeEnabledStream.listen((_) => _broadcast());
    player.loopModeStream.listen((_) => _broadcast());
    _broadcast();
  }

  Future<void> loadQueue(
    List<MediaItem> items, {
    int index = 0,
    bool autoplay = false,
  }) async {
    _items = List.of(items);
    queue.add(_items);
    if (_items.isEmpty) {
      mediaItem.add(null);
      await player.stop();
      return;
    }
    final sources = _items.map((item) {
      final raw = item.extras?['uri'] as String? ?? item.id;
      return AudioSource.uri(_toUri(raw), tag: item);
    }).toList();
    final safeIndex = index.clamp(0, _items.length - 1);
    await player.setAudioSources(sources, initialIndex: safeIndex);
    _baseItem = _items[safeIndex];
    _emitMedia();
    if (autoplay) {
      await play();
    } else {
      _broadcast();
    }
  }

  Future<void> setVolume(double volume) async {
    _userVolume = volume.clamp(0.0, 1.0);
    await player.setVolume(_userVolume);
  }

  Future<void> duck([double to = 0.22]) => player.setVolume(to.clamp(0.0, 1.0));

  Future<void> unduck() => player.setVolume(_userVolume);

  void setTimerDisplay({String? title, String? subtitle}) {
    _overrideTitle = title;
    _overrideSubtitle = subtitle;
    _emitMedia();
  }

  void clearTimerDisplay() {
    _overrideTitle = null;
    _overrideSubtitle = null;
    _emitMedia();
  }

  bool get hasQueue => _items.isNotEmpty;

  @override
  Future<void> play() => player.play();

  @override
  Future<void> pause() => player.pause();

  @override
  Future<void> stop() async {
    await player.pause();
    await player.seek(Duration.zero);
    _broadcast();
  }

  @override
  Future<void> seek(Duration position) => player.seek(position);

  @override
  Future<void> skipToNext() => player.seekToNext();

  @override
  Future<void> skipToPrevious() => player.seekToPrevious();

  @override
  Future<void> skipToQueueItem(int index) async {
    if (index < 0 || index >= _items.length) return;
    await player.seek(Duration.zero, index: index);
  }

  @override
  Future<void> setShuffleMode(AudioServiceShuffleMode shuffleMode) async {
    final enabled = shuffleMode != AudioServiceShuffleMode.none;
    await player.setShuffleModeEnabled(enabled);
    _broadcast();
  }

  @override
  Future<void> setRepeatMode(AudioServiceRepeatMode repeatMode) async {
    final loop = switch (repeatMode) {
      AudioServiceRepeatMode.one => LoopMode.one,
      AudioServiceRepeatMode.all || AudioServiceRepeatMode.group => LoopMode.all,
      _ => LoopMode.off,
    };
    await player.setLoopMode(loop);
    _broadcast();
  }

  void _syncItem() {
    final i = player.currentIndex;
    if (i == null || i < 0 || i >= _items.length) return;
    _baseItem = _items[i];
    _emitMedia();
    _broadcast();
  }

  void _emitMedia() {
    final base = _baseItem;
    if (base == null) {
      mediaItem.add(null);
      return;
    }
    mediaItem.add(
      base.copyWith(
        title: _overrideTitle ?? base.title,
        album: _overrideSubtitle ?? base.album,
      ),
    );
  }

  void _broadcast() {
    final playing = player.playing;
    playbackState.add(
      PlaybackState(
        controls: [
          MediaControl.skipToPrevious,
          if (playing) MediaControl.pause else MediaControl.play,
          MediaControl.skipToNext,
        ],
        systemActions: const {MediaAction.seek},
        androidCompactActionIndices: const [0, 1, 2],
        processingState: switch (player.processingState) {
          ProcessingState.idle => AudioProcessingState.idle,
          ProcessingState.loading => AudioProcessingState.loading,
          ProcessingState.buffering => AudioProcessingState.buffering,
          ProcessingState.ready => AudioProcessingState.ready,
          ProcessingState.completed => AudioProcessingState.completed,
        },
        playing: playing,
        updatePosition: player.position,
        bufferedPosition: player.bufferedPosition,
        speed: player.speed,
        queueIndex: player.currentIndex,
        shuffleMode: player.shuffleModeEnabled
            ? AudioServiceShuffleMode.all
            : AudioServiceShuffleMode.none,
        repeatMode: switch (player.loopMode) {
          LoopMode.one => AudioServiceRepeatMode.one,
          LoopMode.all => AudioServiceRepeatMode.all,
          LoopMode.off => AudioServiceRepeatMode.none,
        },
      ),
    );
  }

  Uri _toUri(String raw) {
    if (raw.startsWith('content:') ||
        raw.startsWith('file:') ||
        raw.startsWith('http')) {
      return Uri.parse(raw);
    }
    return Uri.file(raw);
  }
}
