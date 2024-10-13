// Add ProviderScope, that is required by Riverpod for state management handling
// Change from StatefulWidget to StatelessWidget

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'main_scaffold.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope( // Riverpod needs ProviderScope
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Spotly',
        theme: AppTheme.theme,
        home: const MainScaffold(),
      ),
    );
  }
}

