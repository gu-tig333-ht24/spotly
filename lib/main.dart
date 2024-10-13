//Flutter group project at Gothenburg University, group 5
// The app "Spotly" focuses on saving and viewing places using Google Maps and giving users the ability to add
// their favourite places. With this app you can snap an image of your location, edit it and save it.

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'src/app.dart';

Future<void> main() async {
  // TODO: Any necessary pre-setup such as loading shared preferences

  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    // Riverpod needs ProviderScope
    const ProviderScope(
      child: MainApp(),
    ),
  );
}
