import 'package:flutter/material.dart';

import '../../app/theme.dart';
import '../../core/format.dart';
import '../../core/models/appearance.dart';
import '../../core/models/workout_snapshot.dart';
import 'timer_ring.dart';

class WorkoutClock extends StatelessWidget {
  const WorkoutClock({
    super.key,
    required this.layout,
    required this.snap,
    required this.phaseLabel,
    required this.phaseColor,
    this.exerciseLabel = '',
  });

  final TimerLayout layout;
  final WorkoutSnapshot snap;
  final String phaseLabel;
  final Color phaseColor;
  final String exerciseLabel;

  @override
  Widget build(BuildContext context) {
    final palette = context.pulse;
    final shortest = MediaQuery.sizeOf(context).shortestSide;
    final clock = TimeFormat.workoutClock(snap.remaining, snap.segmentDuration);
    final giantSize = (shortest * 0.30).clamp(88.0, 188.0);
    final bothSize = (shortest * 0.22).clamp(72.0, 140.0);
    final ringFont = (shortest * 0.16).clamp(56.0, 96.0);
    final ringBox = (shortest * 0.58).clamp(240.0, 440.0);
    final digits = _Digits(
      text: clock,
      palette: palette,
      fontSize: switch (layout) {
        TimerLayout.giant => giantSize,
        TimerLayout.both => bothSize,
        TimerLayout.ring => ringFont,
      },
      tight: layout != TimerLayout.ring,
    );

    return switch (layout) {
      TimerLayout.giant => _Giant(
          snap: snap,
          phaseLabel: phaseLabel,
          phaseColor: phaseColor,
          palette: palette,
          digits: digits,
          exerciseLabel: exerciseLabel,
          digitHeight: giantSize,
        ),
      TimerLayout.ring => _RingOnly(
          snap: snap,
          phaseLabel: phaseLabel,
          phaseColor: phaseColor,
          palette: palette,
          digits: digits,
          exerciseLabel: exerciseLabel,
          size: ringBox,
        ),
      TimerLayout.both => _Both(
          snap: snap,
          phaseLabel: phaseLabel,
          phaseColor: phaseColor,
          palette: palette,
          digits: digits,
          exerciseLabel: exerciseLabel,
          size: ringBox,
        ),
    };
  }
}

class _Digits extends StatelessWidget {
  const _Digits({
    required this.text,
    required this.palette,
    required this.fontSize,
    required this.tight,
  });

  final String text;
  final PulsePalette palette;
  final double fontSize;
  final bool tight;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(
          fontSize: fontSize,
          height: 0.88,
          fontWeight: FontWeight.w600,
          letterSpacing: tight ? -3 : 0,
          fontFeatures: const [FontFeature.tabularFigures()],
          color: palette.text,
        ),
      ),
    );
  }
}

class _PhaseMark extends StatelessWidget {
  const _PhaseMark({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w600,
        letterSpacing: 4,
        fontSize: 13,
      ),
    );
  }
}

class _Giant extends StatelessWidget {
  const _Giant({
    required this.snap,
    required this.phaseLabel,
    required this.phaseColor,
    required this.palette,
    required this.digits,
    required this.exerciseLabel,
    required this.digitHeight,
  });

  final WorkoutSnapshot snap;
  final String phaseLabel;
  final Color phaseColor;
  final PulsePalette palette;
  final Widget digits;
  final String exerciseLabel;
  final double digitHeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: snap.segmentProgress,
              minHeight: 4,
              color: phaseColor,
              backgroundColor: palette.hairline,
            ),
          ),
        ),
        const SizedBox(height: 28),
        _PhaseMark(label: phaseLabel, color: phaseColor),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(height: digitHeight, child: Center(child: digits)),
        ),
        if (exerciseLabel.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              exerciseLabel,
              style: TextStyle(color: palette.textMuted),
            ),
          ),
      ],
    );
  }
}

class _RingOnly extends StatelessWidget {
  const _RingOnly({
    required this.snap,
    required this.phaseLabel,
    required this.phaseColor,
    required this.palette,
    required this.digits,
    required this.exerciseLabel,
    required this.size,
  });

  final WorkoutSnapshot snap;
  final String phaseLabel;
  final Color phaseColor;
  final PulsePalette palette;
  final Widget digits;
  final String exerciseLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: size,
      width: size,
      child: TimerRing(
        progress: snap.segmentProgress,
        color: phaseColor,
        strokeWidth: 5,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PhaseMark(label: phaseLabel, color: phaseColor),
            const SizedBox(height: 8),
            SizedBox(height: size * 0.32, child: digits),
            if (exerciseLabel.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Text(
                  exerciseLabel,
                  style: TextStyle(color: palette.textMuted, fontSize: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _Both extends StatelessWidget {
  const _Both({
    required this.snap,
    required this.phaseLabel,
    required this.phaseColor,
    required this.palette,
    required this.digits,
    required this.exerciseLabel,
    required this.size,
  });

  final WorkoutSnapshot snap;
  final String phaseLabel;
  final Color phaseColor;
  final PulsePalette palette;
  final Widget digits;
  final String exerciseLabel;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PhaseMark(label: phaseLabel, color: phaseColor),
        const SizedBox(height: 16),
        SizedBox(
          height: size,
          width: size,
          child: TimerRing(
            progress: snap.segmentProgress,
            color: phaseColor,
            strokeWidth: 3.5,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: digits,
            ),
          ),
        ),
        if (exerciseLabel.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              exerciseLabel,
              style: TextStyle(color: palette.textMuted),
            ),
          ),
      ],
    );
  }
}

TimerLayout nextTimerLayout(TimerLayout current) {
  return switch (current) {
    TimerLayout.giant => TimerLayout.ring,
    TimerLayout.ring => TimerLayout.both,
    TimerLayout.both => TimerLayout.giant,
  };
}

IconData timerLayoutIcon(TimerLayout layout) {
  return switch (layout) {
    TimerLayout.giant => Icons.filter_1,
    TimerLayout.ring => Icons.radio_button_unchecked,
    TimerLayout.both => Icons.adjust,
  };
}
