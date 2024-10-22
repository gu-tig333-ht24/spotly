import 'package:flutter/material.dart';

enum BottomTab {
  collections,
  search,
  settings;

  factory BottomTab.fromIndex(int index) => switch (index) {
        0 => collections,
        1 => search,
        _ => settings,
      };

  String get label => switch (this) {
        BottomTab.collections => "Collections",
        BottomTab.search => "Search",
        BottomTab.settings => "Settings",
      };

  IconData get icon => switch (this) {
        BottomTab.collections => Icons.place_rounded,
        BottomTab.search => Icons.search_rounded,
        BottomTab.settings => Icons.settings_rounded,
      };
}
