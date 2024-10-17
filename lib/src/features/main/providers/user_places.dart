import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/place.dart';


class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super(const []);

// void addPlace(String title, File image, String description) {  
    //final newPlace = Place(
     // title: title,
     // image: image,
    //  description: description,  
    //  createdAt: DateTime.now(), // Set current date as 'createdAt'
    //);
    void addPlace(Place newPlace) {
    state = [newPlace, ...state];  // Add new places to state
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
