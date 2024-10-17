import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/bottom_tab.dart';
import '../providers/app_state_provider.dart';

class CustomNavigationBar extends ConsumerWidget {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AppStateController appStateController = ref.read(
      appStateProvider.notifier,
    );
    final AppState appState = ref.watch(appStateProvider);

    return NavigationBar(
      onDestinationSelected: (int tabIndex) {
        final newTab = BottomTab.fromIndex(tabIndex);
        appStateController.changeBottomTab(newTab);
      },
      selectedIndex: appState.selectedTab.index,
      destinations: BottomTab.values
          .map(
            (tab) => NavigationDestination(
              icon: Icon(
                tab.icon,
                color: Colors.grey,
              ),
              selectedIcon: Icon(
                tab.icon,
                color: Colors.white,
              ),
              label: tab.label,
            ),
          )
          .toList(),
    );
  }
}
