import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/place.dart';
import 'dart:io';
import 'package:spotly/src/core/widgets/image_input.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = Place(title: title, image: image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
