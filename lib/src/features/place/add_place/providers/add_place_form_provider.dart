import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/location.dart';

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

  void changeLocation(Location? newLocation) {
    state = state.copyWith(location: newLocation);
  }

  void changeSelectedImageFile(File? newFile) {
    state = state.copyWith(selectedImageFile: newFile);
  }
}

@immutable
class AddPlaceFormState {
  const AddPlaceFormState({
    required this.title,
    required this.description,
    this.imagePath,
    this.location,
    this.selectedImageFile,
  });

  factory AddPlaceFormState.initial() => const AddPlaceFormState(
        title: "",
        description: "",
        imagePath: null,
        location: null,
        selectedImageFile: null,
      );

  final String title;
  final String? description;
  final String? imagePath;
  final Location? location;

  final File? selectedImageFile;

  bool get isValid => title.isNotEmpty;

  AddPlaceFormState copyWith({
    String? title,
    String? description,
    String? imagePath,
    Location? location,
    File? selectedImageFile,
  }) {
    return AddPlaceFormState(
      title: title ?? this.title,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      location: location ?? this.location,
      selectedImageFile: selectedImageFile ?? this.selectedImageFile,
    );
  }
}
