import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final collectionFormProvider = StateNotifierProvider.autoDispose<
    CollectionFormController, CollectionFormState>((ref) {
  return CollectionFormController();
});

class CollectionFormController
    extends StateNotifier<CollectionFormState> {
  CollectionFormController() : super(CollectionFormState.initial());

  void changeTitle(String newTitle) {
    state = state.copyWith(title: newTitle);
  }

  void changeDescription(String newDescription) {
    state = state.copyWith(description: newDescription);
  }
}

@immutable
class CollectionFormState {
  const CollectionFormState({
    required this.title,
    required this.description,
  });

  factory CollectionFormState.initial() => const CollectionFormState(
        title: "",
        description: null,
      );

  final String title;
  final String? description;

  bool get isValid => title.isNotEmpty;

  CollectionFormState copyWith({
    String? title,
    String? description,
  }) {
    return CollectionFormState(
      title: title ?? this.title,
      description: description ?? this.description,
    );
  }
}
