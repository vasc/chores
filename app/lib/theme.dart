import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

@immutable
class SavannaTokens extends ThemeExtension<SavannaTokens> {
  const SavannaTokens({
    required this.bg,
    required this.card,
    required this.ink,
    required this.ink2,
    required this.accent,
    required this.gold,
    required this.green,
    required this.sky,
    required this.brown,
    required this.line,
  });

  final Color bg;
  final Color card;
  final Color ink;
  final Color ink2;
  final Color accent;
  final Color gold;
  final Color green;
  final Color sky;
  final Color brown;
  final Color line;

  Color get token => gold;

  static const sunset = SavannaTokens(
    bg: Color(0xFFFBF3E3),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2A1C10),
    ink2: Color(0xFF6B5640),
    accent: Color(0xFFF46A4E),
    gold: Color(0xFFF4B942),
    green: Color(0xFF2F6F4E),
    sky: Color(0xFF87B8C4),
    brown: Color(0xFF8C5A2E),
    line: Color(0x1A3C2814),
  );

  static const dusk = SavannaTokens(
    bg: Color(0xFFF2E4D0),
    card: Color(0xFFFFFCF5),
    ink: Color(0xFF2E1A1A),
    ink2: Color(0xFF7A5A4A),
    accent: Color(0xFFE04A3A),
    gold: Color(0xFFE8A72E),
    green: Color(0xFF3C7654),
    sky: Color(0xFF6B97AB),
    brown: Color(0xFF73421C),
    line: Color(0x1F3C1E0A),
  );

  static const oasis = SavannaTokens(
    bg: Color(0xFFEEF5E8),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF1D2E22),
    ink2: Color(0xFF5B6B5E),
    accent: Color(0xFFE8734A),
    gold: Color(0xFFE8B32E),
    green: Color(0xFF2F6F4E),
    sky: Color(0xFF7DB0A8),
    brown: Color(0xFF8C5A2E),
    line: Color(0x1A14321E),
  );

  /// Parent-facing muted palette (desktop dashboard).
  static const parent = SavannaTokens(
    bg: Color(0xFFF4EDE2),
    card: Color(0xFFFFFFFF),
    ink: Color(0xFF2A1C10),
    ink2: Color(0xFF7A6651),
    accent: Color(0xFFC85A4A),
    gold: Color(0xFFCFA057),
    green: Color(0xFF5A7A60),
    sky: Color(0xFF6B8C9A),
    brown: Color(0xFF73533A),
    line: Color(0x1A3C2814),
  );

  @override
  SavannaTokens copyWith({
    Color? bg,
    Color? card,
    Color? ink,
    Color? ink2,
    Color? accent,
    Color? gold,
    Color? green,
    Color? sky,
    Color? brown,
    Color? line,
  }) =>
      SavannaTokens(
        bg: bg ?? this.bg,
        card: card ?? this.card,
        ink: ink ?? this.ink,
        ink2: ink2 ?? this.ink2,
        accent: accent ?? this.accent,
        gold: gold ?? this.gold,
        green: green ?? this.green,
        sky: sky ?? this.sky,
        brown: brown ?? this.brown,
        line: line ?? this.line,
      );

  @override
  SavannaTokens lerp(ThemeExtension<SavannaTokens>? other, double t) {
    if (other is! SavannaTokens) return this;
    return SavannaTokens(
      bg: Color.lerp(bg, other.bg, t)!,
      card: Color.lerp(card, other.card, t)!,
      ink: Color.lerp(ink, other.ink, t)!,
      ink2: Color.lerp(ink2, other.ink2, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      gold: Color.lerp(gold, other.gold, t)!,
      green: Color.lerp(green, other.green, t)!,
      sky: Color.lerp(sky, other.sky, t)!,
      brown: Color.lerp(brown, other.brown, t)!,
      line: Color.lerp(line, other.line, t)!,
    );
  }
}

@immutable
class SavannaDensity extends ThemeExtension<SavannaDensity> {
  const SavannaDensity({
    required this.pad,
    required this.gap,
    required this.row,
    required this.radius,
    required this.cardPad,
  });

  final double pad;
  final double gap;
  final double row;
  final double radius;
  final double cardPad;

  static const cozy = SavannaDensity(pad: 20, gap: 14, row: 72, radius: 24, cardPad: 18);
  static const compact = SavannaDensity(pad: 14, gap: 8, row: 58, radius: 18, cardPad: 12);

  @override
  SavannaDensity copyWith({
    double? pad,
    double? gap,
    double? row,
    double? radius,
    double? cardPad,
  }) =>
      SavannaDensity(
        pad: pad ?? this.pad,
        gap: gap ?? this.gap,
        row: row ?? this.row,
        radius: radius ?? this.radius,
        cardPad: cardPad ?? this.cardPad,
      );

  @override
  SavannaDensity lerp(ThemeExtension<SavannaDensity>? other, double t) {
    if (other is! SavannaDensity) return this;
    return SavannaDensity(
      pad: pad + (other.pad - pad) * t,
      gap: gap + (other.gap - gap) * t,
      row: row + (other.row - row) * t,
      radius: radius + (other.radius - radius) * t,
      cardPad: cardPad + (other.cardPad - cardPad) * t,
    );
  }
}

extension SavannaThemeX on BuildContext {
  SavannaTokens get savanna => Theme.of(this).extension<SavannaTokens>()!;
  SavannaDensity get density => Theme.of(this).extension<SavannaDensity>()!;
}

/// Space Grotesk is used inline for numeric readouts (tokens, XP).
TextStyle spaceGrotesk({
  double fontSize = 14,
  FontWeight fontWeight = FontWeight.w700,
  Color? color,
  double? letterSpacing,
  double? height,
}) =>
    GoogleFonts.spaceGrotesk(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );

ThemeData buildTheme(
  Brightness brightness, {
  SavannaTokens tokens = SavannaTokens.sunset,
  SavannaDensity density = SavannaDensity.cozy,
}) {
  final scheme = ColorScheme(
    brightness: brightness,
    primary: tokens.accent,
    onPrimary: Colors.white,
    primaryContainer: tokens.accent.withValues(alpha: 0.15),
    onPrimaryContainer: tokens.ink,
    secondary: tokens.green,
    onSecondary: Colors.white,
    secondaryContainer: tokens.green.withValues(alpha: 0.14),
    onSecondaryContainer: tokens.ink,
    tertiary: tokens.gold,
    onTertiary: Colors.white,
    error: const Color(0xFFB3261E),
    onError: Colors.white,
    surface: tokens.bg,
    onSurface: tokens.ink,
    surfaceContainerHighest: tokens.card,
    outline: tokens.line,
  );

  final textTheme = GoogleFonts.nunitoTextTheme(ThemeData(brightness: brightness).textTheme)
      .apply(bodyColor: tokens.ink, displayColor: tokens.ink);

  return ThemeData(
    colorScheme: scheme,
    useMaterial3: true,
    scaffoldBackgroundColor: tokens.bg,
    textTheme: textTheme,
    extensions: [tokens, density],
    appBarTheme: AppBarTheme(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      foregroundColor: tokens.ink,
      elevation: 0,
      scrolledUnderElevation: 0,
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 18,
        fontWeight: FontWeight.w800,
        color: tokens.ink,
        letterSpacing: -0.3,
      ),
    ),
    cardTheme: CardThemeData(
      color: tokens.card,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(density.radius)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: tokens.accent,
        foregroundColor: Colors.white,
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: -0.2),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: const StadiumBorder(),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: tokens.ink,
        side: BorderSide(color: tokens.line, width: 1.5),
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w800, fontSize: 16, letterSpacing: -0.2),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
        shape: const StadiumBorder(),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: tokens.ink2,
        textStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 14),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: tokens.card,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(density.radius),
        borderSide: BorderSide(color: tokens.line, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(density.radius),
        borderSide: BorderSide(color: tokens.line, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(density.radius),
        borderSide: BorderSide(color: tokens.accent, width: 2),
      ),
      labelStyle: GoogleFonts.nunito(color: tokens.ink2, fontWeight: FontWeight.w700),
      hintStyle: GoogleFonts.nunito(color: tokens.ink2.withValues(alpha: 0.6)),
    ),
    dividerTheme: DividerThemeData(color: tokens.line, thickness: 1, space: 1),
    chipTheme: ChipThemeData(
      backgroundColor: tokens.gold.withValues(alpha: 0.18),
      labelStyle: GoogleFonts.nunito(fontWeight: FontWeight.w700, fontSize: 12, letterSpacing: -0.2),
      side: BorderSide.none,
      shape: const StadiumBorder(),
    ),
  );
}
