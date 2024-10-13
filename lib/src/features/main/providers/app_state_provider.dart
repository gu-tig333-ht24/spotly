import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_state.dart';
import 'app_state_controller.dart';

final appStateProvider =
    StateNotifierProvider.autoDispose<AppStateController, AppState>((ref) {
  return AppStateController();
});
