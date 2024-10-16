import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/place.dart';
import 'dart:io';


class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

 void addPlace(String title, File image, String description) {  
    final newPlace = Place(
      title: title,
      image: image,
      description: description,  
      createdAt: DateTime.now(), // Set current date as 'createdAt'
    );
    state = [newPlace, ...state];  // Add nw places to state
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
