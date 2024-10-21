import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/place.dart';
import '../../../data/providers/database_providers.dart';
import '../../../data/services/database_service.dart';
import '../../../data/services/place_service.dart';

final placeSearchProvider = StateNotifierProvider.autoDispose<
    PlaceSearchController, AsyncValue<List<Place>>>((ref) {
  final DatabaseService databaseService = ref.read(databaseServiceProvider);
  final PlaceService placeService =
      PlaceService(databaseService: databaseService);
  return PlaceSearchController(
    databaseService: databaseService,
    placeService: placeService,
  );
});

class PlaceSearchController extends StateNotifier<AsyncValue<List<Place>>> {
  PlaceSearchController({
    required DatabaseService databaseService,
    required PlaceService placeService,
  })  : _databaseService = databaseService,
        _placeService = placeService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;
  final PlaceService _placeService;

  // A [Timer] is used as a debouncer to improve the search experience and to
  // avoid making too many database calls when the user is typing.
  Timer? _timer;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> searchPlaces(String searchText) async {
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 300), () async {
      try {
        if (searchText.isEmpty) {
          state = const AsyncData([]);
          return;
        }

        final List<Place> places =
            await _databaseService.searchPlaces(searchText);
        state = AsyncData(places);
      } catch (e, st) {
        state = AsyncError(e, st);

        if (kDebugMode) {
          debugPrint("❌ -> searchPlaces(), error: $e");
        }
      }
    });
  }

  Future<void> deletePlace(Place place) async {
    final deleted = await _placeService.deletePlace(place);
    if (!deleted) {
      return;
    }

    final List<Place> currentPlaces = List.from(state.value ?? []);

    try {
      currentPlaces.remove(place);
      state = AsyncData(currentPlaces);
    } catch (e, st) {
      state = AsyncError(e, st);
      if (kDebugMode) {
        debugPrint("❌ -> deletePlace(), error: $e");
      }
    }
  }
}
