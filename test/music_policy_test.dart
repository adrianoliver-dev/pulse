import 'package:flutter_test/flutter_test.dart';
import 'package:pulse/core/models/phase.dart';
import 'package:pulse/features/music/music_policy.dart';

void main() {
  test('alwaysOn keeps music through rest and prepare', () {
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.alwaysOn,
        phase: PhaseKind.rest,
        isPaused: false,
        isFinished: false,
      ),
      MusicAction.playFull,
    );
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.alwaysOn,
        phase: PhaseKind.prepare,
        isPaused: false,
        isFinished: false,
      ),
      MusicAction.playFull,
    );
  });

  test('duckOnRest only dips volume, never pauses', () {
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.duckOnRest,
        phase: PhaseKind.rest,
        isPaused: false,
        isFinished: false,
      ),
      MusicAction.playDucked,
    );
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.duckOnRest,
        phase: PhaseKind.work,
        isPaused: false,
        isFinished: false,
      ),
      MusicAction.playFull,
    );
  });

  test('user pause and finished always pause music', () {
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.alwaysOn,
        phase: PhaseKind.work,
        isPaused: true,
        isFinished: false,
      ),
      MusicAction.pause,
    );
    expect(
      MusicPolicy.actionFor(
        behavior: MusicBehavior.alwaysOn,
        phase: PhaseKind.work,
        isPaused: false,
        isFinished: true,
      ),
      MusicAction.pause,
    );
  });

  test('cue duck is gentle over full music', () {
    expect(MusicPolicy.cueDuckLevel(MusicAction.playFull), 0.62);
    expect(MusicPolicy.cueDuckLevel(MusicAction.playDucked), 0.42);
  });
}
