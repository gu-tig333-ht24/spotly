import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final addPlaceListFormProvider = StateNotifierProvider.autoDispose<
    AddPlaceListFormController, AddPlaceListFormState>((ref) {
  return AddPlaceListFormController();
});

class AddPlaceListFormController extends StateNotifier<AddPlaceListFormState> {
  AddPlaceListFormController() : super(AddPlaceListFormState.initial());

  void changeTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }
}

@immutable
class AddPlaceListFormState {
  const AddPlaceListFormState({
    required this.title,
  });

  factory AddPlaceListFormState.initial() =>
      const AddPlaceListFormState(title: "");

  final String title;

  bool get isValid => title.isNotEmpty;

  AddPlaceListFormState copyWith({
    String? title,
  }) {
    return AddPlaceListFormState(
      title: title ?? this.title,
    );
  }
}
