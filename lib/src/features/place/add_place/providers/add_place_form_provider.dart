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
}

@immutable
class AddPlaceFormState {
  const AddPlaceFormState({
    required this.title,
    required this.description,
  });

  factory AddPlaceFormState.initial() => const AddPlaceFormState(
        title: "",
        description: "",
      );

  final String title;
  final String description;

  bool get isValid => title.isNotEmpty;

  AddPlaceFormState copyWith({
    String? title,
    String? description,
  }) {
    return AddPlaceFormState(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
