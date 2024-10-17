import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/bottom_tab.dart';

final appStateProvider =
    StateNotifierProvider.autoDispose<AppStateController, AppState>((ref) {
  return AppStateController();
});

class AppStateController extends StateNotifier<AppState> {
  AppStateController() : super(AppState.initial());

  void changeBottomTab(BottomTab newTab) {
    state = state.copyWith(selectedTab: newTab);
  }
}

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
