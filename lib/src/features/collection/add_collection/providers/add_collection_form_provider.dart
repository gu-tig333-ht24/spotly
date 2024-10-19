import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final addCollectionFormProvider = StateNotifierProvider.autoDispose<
    AddCollectionFormController, AddCollectionFormState>((ref) {
  return AddCollectionFormController();
});

class AddCollectionFormController
    extends StateNotifier<AddCollectionFormState> {
  AddCollectionFormController() : super(AddCollectionFormState.initial());

  void changeTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void changeDescription(String newDescription) {
    state = state.copyWith(description: newDescription);
  }
}

@immutable
class AddCollectionFormState {
  const AddCollectionFormState({
    required this.title,
    required this.description,
  });

  factory AddCollectionFormState.initial() => const AddCollectionFormState(
        title: "",
        description: "",
      );

  final String title;
  final String description;

  bool get isValid => title.isNotEmpty;

  AddCollectionFormState copyWith({
    String? title,
    String? description,
  }) {
    return AddCollectionFormState(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
