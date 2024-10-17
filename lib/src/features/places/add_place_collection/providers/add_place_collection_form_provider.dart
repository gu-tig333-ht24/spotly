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
}

@immutable
class AddPlaceCollectionFormState {
  const AddPlaceCollectionFormState({
    required this.title,
  });

  factory AddPlaceCollectionFormState.initial() =>
      const AddPlaceCollectionFormState(title: "");

  final String title;

  bool get isValid => title.isNotEmpty;

  AddPlaceCollectionFormState copyWith({
    String? title,
  }) {
    return AddPlaceCollectionFormState(
      title: title ?? this.title,
    );
  }
}
