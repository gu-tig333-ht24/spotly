import 'package:flutter/foundation.dart';

import '../domain/bottom_tab.dart';

@immutable
class AppState {
  final BottomTab selectedTab;

  const AppState({
    required this.selectedTab,
  });

  factory AppState.initial() {
    return const AppState(
      selectedTab: BottomTab.places,
    );
  }

  AppState copyWith({
    BottomTab? selectedTab,
  }) {
    return AppState(
      selectedTab: selectedTab ?? this.selectedTab,
    );
  }
}
