import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final addPlaceCollectionFormProvider = StateNotifierProvider.autoDispose<
    AddPlaceCollectionFormController, AddPlaceCollectionFormState>((ref) {
  return AddPlaceCollectionFormController();
});

class AddPlaceCollectionFormController extends StateNotifier<AddPlaceCollectionFormState> {
  AddPlaceCollectionFormController() : super(AddPlaceCollectionFormState.initial());

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
