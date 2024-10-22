import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

const kInteractiveColor = Colors.teal;
const kBackgroundColor = Color(0xff1a2120);

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
    listTileTheme: ListTileThemeData(
      tileColor: Colors.teal.shade900,
      iconColor: Colors.teal.shade100,
    ),
    appBarTheme: const AppBarTheme(
      iconTheme: IconThemeData(color: kInteractiveColor),
    ),
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      bodyLarge: TextStyle(color: darkColorScheme.onSurface),
      bodyMedium: TextStyle(color: darkColorScheme.onSurface),
      bodySmall: TextStyle(color: darkColorScheme.onSurface),
    ),
  );

  static ThemeData lightTheme = ThemeData().copyWith(
    scaffoldBackgroundColor: lightColorScheme.surface,
    colorScheme: lightColorScheme,
    listTileTheme: ListTileThemeData(
      tileColor: Colors.teal.shade500,
      iconColor: Colors.teal.shade50,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: kBackgroundColor,
      foregroundColor: Colors.white,
      iconTheme: IconThemeData(color: kInteractiveColor),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: kBackgroundColor,
      indicatorColor: Colors.teal.shade500,
      labelTextStyle:
          WidgetStateProperty.resolveWith<TextStyle>((Set<WidgetState> states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: Colors.white,
          );
        }

        return const TextStyle(
          color: Colors.white70,
        );
      }),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: Colors.white,
      ),
    ),
    textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
      bodyLarge: const TextStyle(color: Colors.black),
      bodyMedium: const TextStyle(color: Colors.black),
      bodySmall: const TextStyle(color: Colors.black),
    ),
  );
}
