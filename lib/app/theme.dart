import 'package:flutter/material.dart';

import '../core/models/appearance.dart';

class PulsePalette extends ThemeExtension<PulsePalette> {
  const PulsePalette({
    required this.background,
    required this.surface,
    required this.surfaceHigh,
    required this.text,
    required this.textMuted,
    required this.accent,
    required this.rest,
    required this.prepare,
    required this.done,
    required this.hairline,
  });

  final Color background;
  final Color surface;
  final Color surfaceHigh;
  final Color text;
  final Color textMuted;
  final Color accent;
  final Color rest;
  final Color prepare;
  final Color done;
  final Color hairline;

  /// Alarm / kitchen-timer: black field, warm digits, amber cue.
  static const clock = PulsePalette(
    background: Color(0xFF050505),
    surface: Color(0xFF121212),
    surfaceHigh: Color(0xFF1C1C1C),
    text: Color(0xFFF6F1E4),
    textMuted: Color(0xFF8C887C),
    accent: Color(0xFFE8A317),
    rest: Color(0xFF6B8CAE),
    prepare: Color(0xFF6A6560),
    done: Color(0xFF8FA08A),
    hairline: Color(0x22F6F1E4),
  );

  /// Bronze on charcoal — original Pulse atelier.
  static const atelier = PulsePalette(
    background: Color(0xFF0E0F10),
    surface: Color(0xFF16181A),
    surfaceHigh: Color(0xFF1E2124),
    text: Color(0xFFF4F1EA),
    textMuted: Color(0xFF9A958C),
    accent: Color(0xFFC4A574),
    rest: Color(0xFF7D8B99),
    prepare: Color(0xFF6E6A64),
    done: Color(0xFF8FA08A),
    hairline: Color(0x22F4F1EA),
  );

  /// OLED lab: near-black, mint work, cool rest.
  static const lab = PulsePalette(
    background: Color(0xFF000000),
    surface: Color(0xFF0A0A0A),
    surfaceHigh: Color(0xFF161616),
    text: Color(0xFFF7F7F7),
    textMuted: Color(0xFF8A8A8A),
    accent: Color(0xFF5EEAD4),
    rest: Color(0xFF64748B),
    prepare: Color(0xFF525252),
    done: Color(0xFF86EFAC),
    hairline: Color(0x22F7F7F7),
  );

  /// Olive and terracotta, warmer gym lighting.
  static const tierra = PulsePalette(
    background: Color(0xFF14110E),
    surface: Color(0xFF1C1814),
    surfaceHigh: Color(0xFF26201A),
    text: Color(0xFFF3EDE4),
    textMuted: Color(0xFFA89880),
    accent: Color(0xFFC4784A),
    rest: Color(0xFF7A8F62),
    prepare: Color(0xFF6B5E4E),
    done: Color(0xFF8FA08A),
    hairline: Color(0x22F3EDE4),
  );

  static PulsePalette ofId(AppThemeId id) {
    return switch (id) {
      AppThemeId.clock => clock,
      AppThemeId.atelier => atelier,
      AppThemeId.lab => lab,
      AppThemeId.tierra => tierra,
    };
  }

  @override
  PulsePalette copyWith({
    Color? background,
    Color? surface,
    Color? surfaceHigh,
    Color? text,
    Color? textMuted,
    Color? accent,
    Color? rest,
    Color? prepare,
    Color? done,
    Color? hairline,
  }) {
    return PulsePalette(
      background: background ?? this.background,
      surface: surface ?? this.surface,
      surfaceHigh: surfaceHigh ?? this.surfaceHigh,
      text: text ?? this.text,
      textMuted: textMuted ?? this.textMuted,
      accent: accent ?? this.accent,
      rest: rest ?? this.rest,
      prepare: prepare ?? this.prepare,
      done: done ?? this.done,
      hairline: hairline ?? this.hairline,
    );
  }

  @override
  PulsePalette lerp(ThemeExtension<PulsePalette>? other, double t) {
    if (other is! PulsePalette) return this;
    return PulsePalette(
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      surfaceHigh: Color.lerp(surfaceHigh, other.surfaceHigh, t)!,
      text: Color.lerp(text, other.text, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      rest: Color.lerp(rest, other.rest, t)!,
      prepare: Color.lerp(prepare, other.prepare, t)!,
      done: Color.lerp(done, other.done, t)!,
      hairline: Color.lerp(hairline, other.hairline, t)!,
    );
  }
}

extension PulseThemeX on BuildContext {
  PulsePalette get pulse =>
      Theme.of(this).extension<PulsePalette>() ?? PulsePalette.clock;
}

class PulseTheme {
  PulseTheme._();

  static ThemeData from(AppThemeId id) {
    final p = PulsePalette.ofId(id);
    final scheme = ColorScheme.dark(
      surface: p.background,
      primary: p.accent,
      onPrimary: p.background,
      secondary: p.rest,
      onSurface: p.text,
      onSurfaceVariant: p.textMuted,
      outline: p.hairline,
    );

    final base = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: scheme,
      fontFamily: 'Manrope',
      scaffoldBackgroundColor: p.background,
      extensions: [p],
    );

    return base.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: p.background,
        foregroundColor: p.text,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontFamily: 'Manrope',
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: p.text,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: p.background,
        indicatorColor: p.surfaceHigh,
        elevation: 0,
        height: 72,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return TextStyle(
            fontFamily: 'Manrope',
            fontSize: 12,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? p.accent : p.textMuted,
          );
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          final selected = states.contains(WidgetState.selected);
          return IconThemeData(
            color: selected ? p.accent : p.textMuted,
            size: 22,
          );
        }),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: p.accent,
          foregroundColor: p.background,
          minimumSize: const Size.fromHeight(52),
          textStyle: const TextStyle(
            fontFamily: 'Manrope',
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.text,
          side: BorderSide(color: p.hairline),
          minimumSize: const Size.fromHeight(48),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        hintStyle: TextStyle(color: p.textMuted),
      ),
      cardTheme: CardThemeData(
        color: p.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      dividerColor: p.hairline,
      snackBarTheme: SnackBarThemeData(
        backgroundColor: p.surfaceHigh,
        contentTextStyle: TextStyle(color: p.text, fontFamily: 'Manrope'),
      ),
      tabBarTheme: TabBarThemeData(
        indicatorColor: p.accent,
        labelColor: p.accent,
        unselectedLabelColor: p.textMuted,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: p.accent,
        foregroundColor: p.background,
      ),
    );
  }
}
