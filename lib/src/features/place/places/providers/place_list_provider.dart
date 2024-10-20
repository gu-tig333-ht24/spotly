import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

import '../../../../core/models/place.dart';
import '../../../../data/providers/database_providers.dart';
import '../../../../data/services/database_service.dart';
import '../../add_place/providers/add_place_form_provider.dart';

final placeListProvider = StateNotifierProvider.autoDispose<PlaceListController,
    AsyncValue<List<Place>>>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return PlaceListController(databaseService: service);
});

class PlaceListController extends StateNotifier<AsyncValue<List<Place>>> {
  PlaceListController({
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;

  // TODO: _writeFileToStorage & _deleteFileFromStorage can be extracted out
  //       to its own service and provider.
  Future<String?> _writeFileToStorage(File file) async {
    try {
      final filePath = file.path;
      final appDir = await getApplicationDocumentsDirectory();
      final fileName = path.basename(filePath);
      final destinationPath = "${appDir.path}/$fileName";
      await File(filePath).copy(destinationPath);
      if (kDebugMode) {
        print("✅ -> File created: $filePath");
      }
      return destinationPath;
    } catch (e) {
      if (kDebugMode) {
        print("⚠️ -> Failed to create file. Error: $e");
      }
      return null;
    }
  }

  Future<void> _deleteFileFromStorage(String filePath) async {
    final file = File(filePath);

    if (!await file.exists()) {
      if (kDebugMode) {
        print("ℹ️ -> File does not exist: $filePath");
      }
      return;
    }

    try {
      await file.delete();
      if (kDebugMode) {
        print("✅ -> File deleted: $filePath");
      }
    } catch (e) {
      if (kDebugMode) {
        print("⚠️ -> Failed to delete file. Error: $e");
      }
    }
  }

  Future<void> addPlaceFromFormState(
    AddPlaceFormState formState,
    int collectionId,
  ) async {
    String? imagePath;
    if (formState.imagePath != null && formState.selectedImageFile != null) {
      imagePath = await _writeFileToStorage(formState.selectedImageFile!);
    }

    final place = Place(
      id: -1,
      collectionId: collectionId,
      title: formState.title,
      description: formState.description,
      imagePath: imagePath,
      createdAt: DateTime.now(),
      location: formState.location,
    );

    await addPlace(place);
  }

  Future<void> addPlace(Place place) async {
    final Place newPlace = await _databaseService.createPlace(place);

    final List<Place> currentPlaces = List.from(state.value ?? []);

    try {
      currentPlaces.add(newPlace);
      state = AsyncData(currentPlaces);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> addPlace(), error: $e");
      }
    }
  }

  Future<void> retrievePlaces(int collectionId) async {
    state = const AsyncLoading();

    final List<Place> places =
        await _databaseService.getPlacesByCollectionId(collectionId);

    try {
      state = AsyncData(places);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> retrievePlaces(), error: $e");
      }
    }
  }

  Future<void> deletePlace(Place place) async {
    final deleted = await _databaseService.deletePlaceById(place.id);
    if (!deleted) {
      return;
    }

    if (place.imagePath != null) {
      await _deleteFileFromStorage(place.imagePath!);
    }

    final List<Place> currentPlaces = List.from(state.value ?? []);

    try {
      currentPlaces.remove(place);
      state = AsyncData(currentPlaces);
    } catch (e, st) {
      state = AsyncError(e, st);
      if (kDebugMode) {
        debugPrint("❌ -> addPlace(), error: $e");
      }
    }
  }

  Future<void> importPlace(File file, int collectionId) async {
    final String content = await file.readAsString();
    final Map<String, dynamic> map = jsonDecode(content);
    Place place = Place.fromMap(map);

    if (map.containsKey("image") && map["image"] != null) {
      // Decode the image
      final imageBytes = base64Decode(map["image"]);
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = "${directory.path}/${place.title}.png";
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(imageBytes);
      place = place.copyWith(imagePath: imagePath);
    }

    await addPlace(place);
  }
}
