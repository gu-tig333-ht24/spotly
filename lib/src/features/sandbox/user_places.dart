// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../../core/models/place.dart';
// import 'dart:io';

// class UserPlacesNotifier extends StateNotifier<List<Place>> {
//   UserPlacesNotifier() : super([]) {
//     _loadPlaces();
//   }

//   // Ladda platser från SharedPreferences
//   Future<void> _loadPlaces() async {
//     final prefs = await SharedPreferences.getInstance();
//     final savedPlacesData = prefs.getStringList('places') ?? [];

//     final loadedPlaces = savedPlacesData.map((placeData) {
//       final placeParts = placeData.split('|');
//       return Place(
//         title: placeParts[0],
//         image: File(placeParts[1]),
//         description:
//             'No description', // Du kan lägga till detta fält om du vill
//         createdAt: DateTime.now(),
//       );
//     }).toList();

//     state = loadedPlaces;
//   }

//   void addPlace(Place newPlace) {
//     state = [newPlace, ...state];
//   }
// }

// final userPlacesProvider =
//     StateNotifierProvider<UserPlacesNotifier, List<Place>>(
//   (ref) => UserPlacesNotifier(),
// );
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/place.dart';
import 'dart:io';

import '../../core/models/location.dart';

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

      // Skapa en standardplats om ingen platsdata finns
      final placeLocation = Location(
        latitude: 0.0, // Ange default-värden om ingen plats är sparad
        longitude: 0.0,
        address: 'No address available',
      );

      return Place(
        id: -1,
        collectionId: -1,
        title: placeParts[0],
        imagePath: File(placeParts[1]).path,
        description: 'No description',
        // Du kan lägga till detta fält om du vill
        createdAt: DateTime.now(),
        //  location: placeLocation, // Ange platsen för det inlästa objektet
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
