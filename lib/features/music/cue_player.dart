import 'package:just_audio/just_audio.dart';

class CuePlayer {
  CuePlayer()
      : _player = AudioPlayer(
          handleInterruptions: false,
          androidApplyAudioAttributes: false,
        );

  final AudioPlayer _player;

  Future<void> playPhase() => _play('assets/sounds/phase.wav');
  Future<void> playCountdown() => _play('assets/sounds/countdown.wav');
  Future<void> playComplete() => _play('assets/sounds/complete.wav');

  Future<void> _play(String asset) async {
    try {
      await _player.stop();
      await _player.setAsset(asset);
      await _player.play();
    } catch (_) {
      // Cues should never crash a workout.
    }
  }

  Future<void> dispose() => _player.dispose();
}
