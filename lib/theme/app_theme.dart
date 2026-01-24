
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Dark Theme Colors (Black-Orange - Ay 🌙)
  static const Color alienOrange = Color(0xFFFF9800); // Bright Orange
  static const Color darkOrange = Color(0xFFFB8C00); // Dark Orange
  static const Color darkBlack = Color(0xFF000000); // Pure Black
  static const Color darkSurface = Color(0xFF0A0A0A); // Very dark surface
  
  // Light Theme Colors (Orange-White - Güneş ☀️)
  static const Color skyOrange = Color(0xFFFF9800); // Orange
  static const Color lightOrange = Color(0xFFFFA726); // Light Orange
  static const Color pureWhite = Color(0xFFFFFFFF); // Pure White
  static const Color lightSurface = Color(0xFFF5F5F5); // Light grey

  static const Color glassBackground = Color(0x1AFFFFFF);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xFF1E1E1E), // Dark grey instead of black
      colorScheme: const ColorScheme.dark(
        primary: alienOrange,
        secondary: alienOrange,
        surface: darkSurface,
        onSurface: Colors.white,
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme).apply(
        bodyColor: Colors.white,
        displayColor: Colors.white,
      ),
      /* cardTheme: CardTheme(
        color: glassBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.1)),
        ),
      ), */
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: alienOrange,
          foregroundColor: Colors.black,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: const Color(0xFFF8F9FA), // Soft white instead of pure white
      colorScheme: const ColorScheme.light(
        primary: skyOrange,
        secondary: lightOrange,
        surface: lightSurface,
        onSurface: Color(0xFF212121),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme).apply(
         bodyColor: const Color(0xFF212121),
         displayColor: const Color(0xFF212121),
      ),
       /* cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ), */
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: skyOrange,
          foregroundColor: Colors.white,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'Roboto',
          ),
        ),
      ),
    );
  }
}
