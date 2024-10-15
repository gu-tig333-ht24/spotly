// Provider for settings-related logic
// StateNotifier used for handling of state and StateNotifierProvider used to expose it in the app

import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define notifier to handle the state
class SettingsNotifier extends StateNotifier<SettingsState> {
  SettingsNotifier() : super(SettingsState());

  // Toggle switch for notifications
  void toggleNotifications(bool value) {
    state = state.copyWith(notificationsEnabled: value);
  }
}

// Define state for settings
class SettingsState {
  final bool notificationsEnabled;

  SettingsState({this.notificationsEnabled = false});

  // Create a copy of state with new values
  SettingsState copyWith({bool? notificationsEnabled}) {
    return SettingsState(
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    );
  }
}

// Create a Provider that exposes to UI
final settingsProvider =
    StateNotifierProvider<SettingsNotifier, SettingsState>((ref) {
  return SettingsNotifier();
});
