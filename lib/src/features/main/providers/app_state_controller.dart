import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/bottom_tab.dart';
import 'app_state.dart';

class AppStateController extends StateNotifier<AppState> {
  AppStateController() : super(AppState.initial());

  void changeBottomTab(BottomTab newTab) {
    state = state.copyWith(selectedTab: newTab);
  }
}
