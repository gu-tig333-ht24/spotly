import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final darkModeProvider = StateNotifierProvider<DarkModeNotifier, bool>((ref) {
  return DarkModeNotifier()..loadDarkModePreference();
});

class DarkModeNotifier extends StateNotifier<bool> {
  DarkModeNotifier() : super(true); // Default to dark mode


 void toggleDarkMode() {
    state = !state;
    _saveDarkModePreference(state);
  }

  Future<void> loadDarkModePreference() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isDarkMode') ?? true; // Default to dark mode
  }

  Future<void> _saveDarkModePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }
}
