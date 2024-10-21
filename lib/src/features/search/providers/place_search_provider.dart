import 'dart:async';

import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/models/place.dart';
import '../../../data/providers/database_providers.dart';
import '../../../data/services/database_service.dart';

final placeSearchProvider = StateNotifierProvider.autoDispose<
    PlaceSearchController, AsyncValue<List<Place>>>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return PlaceSearchController(databaseService: service);
});

class PlaceSearchController extends StateNotifier<AsyncValue<List<Place>>> {
  PlaceSearchController({
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;

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
}
