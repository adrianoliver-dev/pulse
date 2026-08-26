import 'dart:math' as math;

import 'package:flutter/material.dart';

class TimerRing extends StatelessWidget {
  const TimerRing({
    super.key,
    required this.progress,
    required this.color,
    required this.child,
    this.strokeWidth = 4,
  });

  final double progress;
  final Color color;
  final Widget child;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _RingPainter(
        progress: progress.clamp(0, 1),
        color: color,
        strokeWidth: strokeWidth,
      ),
      child: Center(child: child),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
  });

  final double progress;
  final Color color;
  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(Offset.zero);
    final radius = math.min(size.width, size.height) / 2 - strokeWidth;
    final bg = Paint()
      ..color = color.withValues(alpha: 0.14)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    final fg = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = strokeWidth;
    canvas.drawCircle(center, radius, bg);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      fg,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.color != color ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}
