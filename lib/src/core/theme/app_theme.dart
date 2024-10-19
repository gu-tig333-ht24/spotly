import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._internal();

  static final darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
  );

  static final lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
  );

  static ThemeData darkTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: darkColorScheme.surface,
    colorScheme: darkColorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      bodyLarge: TextStyle(color: darkColorScheme.onSurface),
      bodyMedium: TextStyle(color: darkColorScheme.onSurface),
      bodySmall: TextStyle(color: darkColorScheme.onSurface),
    ),
  );

  static ThemeData lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: lightColorScheme.surface,
    colorScheme: lightColorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      bodyLarge: TextStyle(color: Colors.black), // Black text for lightmode 
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
    ),
  );
}