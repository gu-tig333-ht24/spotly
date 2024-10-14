import 'package:flutter/material.dart';
import 'package:spotly/src/features/places/providers/places.dart';
import 'package:spotly/src/core/widgets/places_list.dart';

enum BottomTab {
  places,
  search,
  settings;

  factory BottomTab.fromIndex(int index) => switch (index) {
        0 => places,
        1 => search,
        _ => settings,
      };

  String get label => switch (this) {
        BottomTab.places => "Places",
        BottomTab.search => "Search",
        BottomTab.settings => "Settings",
      };

  IconData get icon => switch (this) {
        BottomTab.places => Icons.place,
        BottomTab.search => Icons.search,
        BottomTab.settings => Icons.settings,
      };
}
