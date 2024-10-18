// // import 'package:flutter/foundation.dart';

// // import 'package:flutter_riverpod/flutter_riverpod.dart';

// // final addPlaceCollectionFormProvider = StateNotifierProvider.autoDispose<
// //     AddPlaceCollectionFormController, AddPlaceCollectionFormState>((ref) {
// //   return AddPlaceCollectionFormController();
// // });

// // class AddPlaceCollectionFormController extends StateNotifier<AddPlaceCollectionFormState> {
// //   AddPlaceCollectionFormController() : super(AddPlaceCollectionFormState.initial());

// //   void changeTitle(String newTitle) {
// //     state = state.copyWith(title: newTitle);
// //   }
// // }

// // @immutable
// // class AddPlaceCollectionFormState {
// //   const AddPlaceCollectionFormState({
// //     required this.title,
// //   });

// //   factory AddPlaceCollectionFormState.initial() =>
// //       const AddPlaceCollectionFormState(title: "");

// //   final String title;

// //   bool get isValid => title.isNotEmpty;

// //   AddPlaceCollectionFormState copyWith({
// //     String? title,
// //   }) {
// //     return AddPlaceCollectionFormState(
// //       title: title ?? this.title,
// //     );
// //   }
// // }
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

//   Future<void> addPlaceCollection(String title, String imagePath) async {  // Lägg till bildvägen
//     final List<PlaceCollection> currentCollections = List.from(
//       state.value ?? [],
//     );

//     try {
//       currentCollections.add(
//         PlaceCollection(
//           id: const Uuid().v4(),
//           title: title,
//           imagePath: imagePath,  // Lägg till bildvägen
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

final addPlaceCollectionFormProvider = StateNotifierProvider.autoDispose<
    AddPlaceCollectionFormController, AddPlaceCollectionFormState>((ref) {
  return AddPlaceCollectionFormController();
});

class AddPlaceCollectionFormController
    extends StateNotifier<AddPlaceCollectionFormState> {
  AddPlaceCollectionFormController()
      : super(AddPlaceCollectionFormState.initial());

  void changeTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }
// Method to handle description change
  void changeDescription(String newDescription) {
    state = state.copyWith(description: newDescription);
  }
}

@immutable
class AddPlaceCollectionFormState {
  const AddPlaceCollectionFormState({
    required this.title,
    required this.description,
  });

  factory AddPlaceCollectionFormState.initial() =>
      const AddPlaceCollectionFormState(title: "", description: "");

  final String title;
  final String description;

  bool get isValid => title.isNotEmpty && description.isNotEmpty;

  AddPlaceCollectionFormState copyWith({
    String? title,
    String? description,
  }) {
    return AddPlaceCollectionFormState(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
