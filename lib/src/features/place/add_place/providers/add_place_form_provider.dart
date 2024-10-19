import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final addPlaceFormProvider = StateNotifierProvider.autoDispose<
    AddPlaceFormController, AddPlaceFormState>((ref) {
  return AddPlaceFormController();
});

class AddPlaceFormController extends StateNotifier<AddPlaceFormState> {
  AddPlaceFormController() : super(AddPlaceFormState.initial());

  void changeTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void changeDescription(String newDescription) {
    state = state.copyWith(description: newDescription);
  }

  void changeImagePath(String? newImagePath) {
    state = state.copyWith(imagePath: newImagePath);
  }
}

@immutable
class AddPlaceFormState {
  const AddPlaceFormState({
    required this.title,
    required this.description,
    this.imagePath,
  });

  factory AddPlaceFormState.initial() => const AddPlaceFormState(
        title: "",
        description: "",
        imagePath: null,
      );

  final String title;
  final String description;
  final String? imagePath;

  bool get isValid => title.isNotEmpty;

  AddPlaceFormState copyWith({
    String? title,
    String? description,
    String? imagePath,
  }) {
    return AddPlaceFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}
