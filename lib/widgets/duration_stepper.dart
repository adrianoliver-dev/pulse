import 'package:flutter/material.dart';

import '../../core/format.dart';
import '../../app/theme.dart';

const kQuickDurations = [5, 10, 15, 20, 30, 45, 60];

class DurationStepper extends StatelessWidget {
  const DurationStepper({
    super.key,
    required this.seconds,
    required this.onChanged,
    this.step = 5,
    this.min = 0,
    this.max = 99 * 60,
    this.quickValues,
  });

  final int seconds;
  final ValueChanged<int> onChanged;
  final int step;
  final int min;
  final int max;
  final List<int>? quickValues;

  @override
  Widget build(BuildContext context) {
    final palette = context.pulse;
    return Column(
      children: [
        Row(
          children: [
            _StepButton(
              icon: Icons.remove,
              onPressed: seconds - step >= min
                  ? () => onChanged((seconds - step).clamp(min, max))
                  : null,
            ),
            Expanded(
              child: Text(
                TimeFormat.mmss(Duration(seconds: seconds)),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  fontFeatures: const [FontFeature.tabularFigures()],
                  color: palette.text,
                ),
              ),
            ),
            _StepButton(
              icon: Icons.add,
              onPressed: seconds + step <= max
                  ? () => onChanged((seconds + step).clamp(min, max))
                  : null,
            ),
          ],
        ),
        if (quickValues != null && quickValues!.isNotEmpty) ...[
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: quickValues!.map((v) {
              final selected = seconds == v;
              return GestureDetector(
                onTap: () => onChanged(v.clamp(min, max)),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 160),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? palette.accent : palette.surfaceHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    TimeFormat.pretty(Duration(seconds: v)),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: selected ? palette.background : palette.text,
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ],
    );
  }
}

class CountStepper extends StatelessWidget {
  const CountStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 1,
    this.max = 99,
  });

  final int value;
  final ValueChanged<int> onChanged;
  final int min;
  final int max;

  @override
  Widget build(BuildContext context) {
    final palette = context.pulse;
    return Row(
      children: [
        _StepButton(
          icon: Icons.remove,
          onPressed: value > min ? () => onChanged(value - 1) : null,
        ),
        Expanded(
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 40,
              height: 1,
              fontWeight: FontWeight.w600,
              fontFeatures: const [FontFeature.tabularFigures()],
              color: palette.text,
            ),
          ),
        ),
        _StepButton(
          icon: Icons.add,
          onPressed: value < max ? () => onChanged(value + 1) : null,
        ),
      ],
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = context.pulse;
    return IconButton.filledTonal(
      onPressed: onPressed,
      style: IconButton.styleFrom(
        backgroundColor: palette.surfaceHigh,
        foregroundColor: palette.text,
        disabledForegroundColor: palette.textMuted,
      ),
      icon: Icon(icon),
    );
  }
}
