import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const kInteractiveColor = Colors.teal;

class AppTheme {
  AppTheme._internal();

  static final darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: kInteractiveColor,
  );

  static final lightColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.light,
    seedColor: kInteractiveColor,
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
      bodyLarge: const TextStyle(color: Colors.black),
      bodyMedium: const TextStyle(color: Colors.black),
      bodySmall: const TextStyle(color: Colors.black),
    ),
  );
}
