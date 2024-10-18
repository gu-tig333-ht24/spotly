import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/place.dart';
import '../../../../data/providers/database_providers.dart';
import '../../../../data/services/database_service.dart';

final placeListProvider = StateNotifierProvider.autoDispose<
    PlaceListController, AsyncValue<List<Place>>>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return PlaceListController(databaseService: service);
});

class PlaceListController extends StateNotifier<AsyncValue<List<Place>>> {
  PlaceListController({
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;

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

    // TODO: delete image by imagePath if not null

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
}
