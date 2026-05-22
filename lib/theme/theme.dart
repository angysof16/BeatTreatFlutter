import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BeatTreatColors {
  static const background    = Color(0xFF0D0D0D);
  static const surface       = Color(0xFF1A1A2E);
  static const surfaceVariant= Color(0xFF2D2640);
  static const purple60      = Color(0xFF9B30D9);
  static const purple40      = Color(0xFF7C3AED);
  static const purpleDark    = Color(0xFF5B21B6);
  static const pink          = Color(0xFFEC4899);
  static const bottomBar     = Color(0xFF2A2A2A);
  static const fieldBg       = Color(0xFFEEEEEE);
  static const textGray      = Color(0xFF888888);
  static const textDark      = Color(0xFF1A1A1A);
  static const error         = Color(0xFFCF6679);
  static const gold          = Color(0xFFFFC107);
}

ThemeData beatTreatTheme() {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: BeatTreatColors.background,
    colorScheme: const ColorScheme.dark(
      primary: BeatTreatColors.purple60,
      surface: BeatTreatColors.surface,
      surfaceContainerHighest: BeatTreatColors.surfaceVariant,
      error: BeatTreatColors.error,
    ),
    textTheme: GoogleFonts.spaceGroteskTextTheme(
      ThemeData.dark().textTheme,
    ).copyWith(
      displayLarge: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
      headlineLarge: GoogleFonts.outfit(color: Colors.white, fontWeight: FontWeight.bold),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: BeatTreatColors.surface,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: BeatTreatColors.bottomBar,
      selectedItemColor: BeatTreatColors.purple60,
      unselectedItemColor: Colors.white,
    ),
  );
}
