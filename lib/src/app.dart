import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/enums/bottom_tab.dart';
import 'core/providers/app_state_provider.dart';
import 'core/providers/dark_mode_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/collection/collections/ui/pages/collection_list_page.dart';
import 'features/search/ui/pages/search_page.dart';
import 'features/settings/ui/pages/settings_page.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);
    final isDarkMode = ref.watch(darkModeProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      home: switch (appState.selectedTab) {
        BottomTab.collections => const CollectionListPage(),
        BottomTab.search => const SearchPage(),
        BottomTab.settings => const SettingsPage(),
      },
    );
  }
}
