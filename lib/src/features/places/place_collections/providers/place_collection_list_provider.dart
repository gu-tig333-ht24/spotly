import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/place_collection.dart';
import '../../../../data/providers/database_providers.dart';
import '../../../../data/services/database_service.dart';

final placeCollectionListProvider = StateNotifierProvider<
    PlaceCollectionListController, AsyncValue<List<PlaceCollection>>>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return PlaceCollectionListController(databaseService: service);
});

class PlaceCollectionListController
    extends StateNotifier<AsyncValue<List<PlaceCollection>>> {
  PlaceCollectionListController({
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;

  Future<void> addPlaceCollection(String title, String description) async {
    final PlaceCollection newCollection =
        await _databaseService.createPlaceCollection(
      title,
      description,
    );

    final List<PlaceCollection> currentCollections = List.from(
      state.value ?? [],
    );

    try {
      currentCollections.add(newCollection);
      state = AsyncData(currentCollections);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> addPlaceCollection(), error: $e");
      }
    }
  }

  Future<void> retrieveCollections() async {
    state = const AsyncLoading();

    final List<PlaceCollection> collections =
        await _databaseService.getPlaceCollections();

    try {
      state = AsyncData(collections);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> retrieveCollections(), error: $e");
      }
    }
  }

  Future<void> deleteCollection(PlaceCollection collection) async {
    final deleted = await _databaseService.deletePlaceCollectionById(
      collection.id,
    );

    if (!deleted) {
      // TODO: show snackbar message indicating that something went wrong?
      return;
    }

    final List<PlaceCollection> currentCollections = List.from(
      state.value ?? [],
    );

    try {
      currentCollections.remove(collection);
      state = AsyncData(currentCollections);
    } catch (e, st) {
      state = AsyncError(e, st);
      if (kDebugMode) {
        debugPrint("❌ -> addPlaceCollection(), error: $e");
      }
    }
  }
}
