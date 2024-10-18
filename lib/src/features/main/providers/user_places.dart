// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import '../../../core/models/place.dart';

// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   UserPlacesNotifier() : super(const []);

// // void addPlace(String title, File image, String description) {
//   //final newPlace = Place(
//   // title: title,
//   // image: image,
//   //  description: description,
//   //  createdAt: DateTime.now(), // Set current date as 'createdAt'
//   //);
//   void addPlace(Place newPlace) {
//     state = [newPlace, ...state]; // Add new places to state
//   }
// }

// final userPlacesProvider =
//     StateNotifierProvider<UserPlacesNotifier, List<Place>>(
//   (ref) => UserPlacesNotifier(),
// );

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/models/place.dart';

class UserPlacesNotifier extends StateNotifier<List<Place>> {
  UserPlacesNotifier() : super([]) {
    _loadPlaces();
  }

  // Ladda platser från SharedPreferences
  Future<void> _loadPlaces() async {
    final prefs = await SharedPreferences.getInstance();
    final savedPlacesData = prefs.getStringList('places') ?? [];

    final loadedPlaces = savedPlacesData.map((placeData) {
      final placeParts = placeData.split('|');
      return Place(
        title: placeParts[0],
        image: File(placeParts[1]),
        description:
            'No description', // Du kan lägga till detta fält om du vill
        createdAt: DateTime.now(),
      );
    }).toList();

    state = loadedPlaces;
  }

  void addPlace(Place newPlace) {
    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<Place>>(
  (ref) => UserPlacesNotifier(),
);
