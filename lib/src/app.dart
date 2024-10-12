import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'main_scaffold.dart';

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Great Places',
      theme: AppTheme.theme,
      home: const MainScaffold(),
    );
  }
}
