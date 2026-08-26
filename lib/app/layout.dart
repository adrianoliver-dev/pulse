import 'package:flutter/material.dart';

class PulseLayout {
  PulseLayout._();

  static const compactMax = 600.0;
  static const expandedMin = 840.0;
  static const maxContent = 760.0;

  static bool isCompact(BuildContext context) =>
      MediaQuery.sizeOf(context).width < compactMax;

  static bool isExpanded(BuildContext context) =>
      MediaQuery.sizeOf(context).width >= expandedMin;

  static bool isWideWorkout(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return size.width >= 720 && size.width > size.height;
  }

  static double pageGutter(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w >= expandedMin) return 28;
    if (w >= compactMax) return 24;
    return 20;
  }
}

class PulsePage extends StatelessWidget {
  const PulsePage({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final gutter = PulseLayout.pageGutter(context);
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: PulseLayout.maxContent),
        child: Padding(
          padding: padding ?? EdgeInsets.fromLTRB(gutter, 8, gutter, 32),
          child: child,
        ),
      ),
    );
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
    required this.icon,
    required this.title,
    this.body,
    this.action,
  });

  final IconData icon;
  final String title;
  final String? body;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final palette = Theme.of(context).colorScheme;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 420),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 40, color: palette.primary),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
              if (body != null) ...[
                const SizedBox(height: 10),
                Text(
                  body!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: palette.onSurfaceVariant, height: 1.4),
                ),
              ],
              if (action != null) ...[
                const SizedBox(height: 24),
                action!,
              ],
            ],
          ),
        ),
      ),
    );
  }
}
