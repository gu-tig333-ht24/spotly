# Code Standards

A set of guidelines that we can try to adhere to help us maintain a consistent coding style and
guidance when we are uncertain.

### Imports

One good way of sorting imports is to have this order:

1. Dart libraries
2. Flutter libraries
3. Third party libraries (for example `riverpod`)
4. Our custom libraries

The order and spacing between the sections reduces the cognitive workload for our minds and helps us
maintain a consistent mental structure. If we are looking for something in particular we can quickly
locate where it is. Below is an example of `app.dart`. We have not imported any dart libraries, but
I added it as an illustration. As we can see it is easy to differentiate between the four sections.
We can also with the help of relative imports figure out where things are, and what libraries each
dart file requires. You can also in most editors right click on them and navigate to where that dart
file is with `Go To > Declaration or Usages` or something similar.

```dart
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'features/main/domain/bottom_tab.dart';
import 'features/main/providers/app_state_provider.dart';
import 'features/places/ui/pages/place_list_page.dart';
import 'features/search/ui/pages/search_page.dart';
import 'features/settings/ui/pages/settings_page.dart';

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appState = ref.watch(appStateProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConstants.appTitle,
      theme: AppTheme.theme,
      home: switch (appState.selectedTab) {
        BottomTab.places => const PlaceListPage(),
        BottomTab.search => const SearchPage(),
        BottomTab.settings => const SettingsPage(),
      },
    );
  }
}
```