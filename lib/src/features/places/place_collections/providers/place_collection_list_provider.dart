// import 'package:flutter/foundation.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';
// import '../../../../core/models/place_collection.dart';
// import 'package:spotly/src/core/widgets/image_input.dart';

// final placeCollectionListProvider = StateNotifierProvider.autoDispose<
//     PlaceCollectionListController, AsyncValue<List<PlaceCollection>>>((ref) {
//   return PlaceCollectionListController();
// });

// class PlaceCollectionListController
//     extends StateNotifier<AsyncValue<List<PlaceCollection>>> {
//   PlaceCollectionListController() : super(const AsyncValue.data([]));

//   Future<void> addPlaceCollection(String title, String description) async {
//     final List<PlaceCollection> currentCollections = List.from(
//       state.value ?? [],
//     );

//     try {
//       currentCollections.add(
//         PlaceCollection(
//           id: const Uuid().v4(),
//           title: title,
//           imagePath: imagePath, // Lägg till imagePath här
//           createdAt: DateTime.now(),
//           //description: description, // description parameter
//           description: 'No description provided', // Default description
//         ),
//       );
//       state = AsyncData(currentCollections);
//     } catch (e, st) {
//       state = AsyncError(e, st);

//       if (kDebugMode) {
//         debugPrint("❌ -> addPlaceCollection(), error: $e");
//       }
//     }
//   }
// }
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/models/place_collection.dart';
import '../../../main/domain/home_screen.dart';

final placeCollectionListProvider = StateNotifierProvider.autoDispose<
    PlaceCollectionListController, AsyncValue<List<PlaceCollection>>>((ref) {
  return PlaceCollectionListController();
});

class PlaceCollectionListController
    extends StateNotifier<AsyncValue<List<PlaceCollection>>> {
  PlaceCollectionListController() : super(const AsyncValue.data([]));

  // Lägger till imagePath som parameter här
  Future<void> addPlaceCollection(
      String title, String description, String imagePath) async {
    final List<PlaceCollection> currentCollections = List.from(
      state.value ?? [],
    );

    try {
      // Skapar och lägger till en ny PlaceCollection med imagePath
      currentCollections.add(
        PlaceCollection(
          id: const Uuid().v4(),
          title: title,
          imagePath: imagePath, // Använd den nya parameterbildvägen
          createdAt: DateTime.now(),
          description: description.isNotEmpty
              ? description
              : 'No description provided', // Hanterar beskrivningen
        ),
      );
      state = AsyncData(currentCollections);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> addPlaceCollection(), error: $e");
      }
    }
  }
}
