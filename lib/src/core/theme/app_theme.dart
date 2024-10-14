import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:spotly/src/features/places/providers/places.dart';
import 'package:spotly/src/core/widgets/places_list.dart';

class AppTheme {
  // Private constructor, should not be instantiated.
  AppTheme._internal();

  static final colorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 102, 6, 247),
  );

  static ThemeData theme = ThemeData().copyWith(
    useMaterial3: true,
    scaffoldBackgroundColor: colorScheme.background,
    colorScheme: colorScheme,
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      titleSmall: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleMedium: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
      titleLarge: GoogleFonts.ubuntuCondensed(
        fontWeight: FontWeight.bold,
      ),
    ),
  );
}
