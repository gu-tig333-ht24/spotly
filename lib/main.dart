// // Flutter group project at Gothenburg University, group 5
// // The app "Spotly" focuses on saving and viewing places using Google Maps and giving users the ability to add
// // their favourite places. With this app you can snap an image of your location, edit it and save it.

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'src/app.dart';

// Future<void> main() async {
//   // TODO: Any necessary pre-setup such as loading shared preferences

//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(
//     // Riverpod needs ProviderScope
//     const ProviderScope(
//       child: MainApp(),
//     ),
//   );
// }

// main.dart
// main.dart
// main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'src/features/main/domain/home_screen.dart'; // Import PlacesScreen
import 'package:google_fonts/google_fonts.dart';
// Import PlacesScreen

// Define your color scheme
final colorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 102, 6, 247),
  background: const Color.fromARGB(255, 56, 49, 66),
);

// Define your theme
final theme = ThemeData().copyWith(
  scaffoldBackgroundColor: colorScheme.surface,
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

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Great Places',
      theme: theme, // Use the theme defined above
      home: const HomeScreen(),
    );
  }
}


////////////////////////////////////////


// import 'package:spotly/src/features/places/providers/places.dart';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';

// final colorScheme = ColorScheme.fromSeed(
//   brightness: Brightness.dark,
//   seedColor: const Color.fromARGB(255, 102, 6, 247),
//   background: const Color.fromARGB(255, 56, 49, 66),
// );

// final theme = ThemeData().copyWith(
//   useMaterial3: true,
//   scaffoldBackgroundColor: colorScheme.background,
//   colorScheme: colorScheme,
//   textTheme: GoogleFonts.ubuntuCondensedTextTheme().copyWith(
//     titleSmall: GoogleFonts.ubuntuCondensed(
//       fontWeight: FontWeight.bold,
//     ),
//     titleMedium: GoogleFonts.ubuntuCondensed(
//       fontWeight: FontWeight.bold,
//     ),
//     titleLarge: GoogleFonts.ubuntuCondensed(
//       fontWeight: FontWeight.bold,
//     ),
//   ),
// );

// void main() {
//   runApp(
//     const MyApp(),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Great Places',
//       theme: theme,
//       home: const PlacesScreen(),
//     );
//   }
// }


// Flutter group project at Gothenburg University, group 5
// The app "Spotly" focuses on saving and viewing places using Google Maps and giving users the ability to add
// their favourite places. With this app you can snap an image of your location, edit it and save it.
