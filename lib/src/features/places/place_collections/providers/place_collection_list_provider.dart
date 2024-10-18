// import 'package:flutter/foundation.dart';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:uuid/uuid.dart';

// import '../../../../core/models/place_collection.dart';

// final placeCollectionListProvider = StateNotifierProvider.autoDispose<
//     PlaceCollectionListController, AsyncValue<List<PlaceCollection>>>((ref) {
//   return PlaceCollectionListController();
// });

// class PlaceCollectionListController
//     extends StateNotifier<AsyncValue<List<PlaceCollection>>> {
//   PlaceCollectionListController() : super(const AsyncValue.data([]));

//   Future<void> addPlaceCollection(String title) async {
//     final List<PlaceCollection> currentCollections = List.from(
//       state.value ?? [],
//     );

//     try {
//       currentCollections.add(
//         PlaceCollection(
//           id: const Uuid().v4(),
//           title: title,
//           createdAt: DateTime.now(),
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

final placeCollectionListProvider = StateNotifierProvider.autoDispose<
    PlaceCollectionListController, AsyncValue<List<PlaceCollection>>>((ref) {
  return PlaceCollectionListController();
});

class PlaceCollectionListController
    extends StateNotifier<AsyncValue<List<PlaceCollection>>> {
  PlaceCollectionListController() : super(const AsyncValue.data([]));

  Future<void> addPlaceCollection(String title, String description) async {
    final List<PlaceCollection> currentCollections = List.from(
      state.value ?? [],
    );

    try {
      currentCollections.add(
        PlaceCollection(
          id: const Uuid().v4(),
          title: title,
          imagePath: imagePath, // Lägg till imagePath här
          createdAt: DateTime.now(),
          //description: description, // description parameter
          description: 'No description provided', // Default description
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
