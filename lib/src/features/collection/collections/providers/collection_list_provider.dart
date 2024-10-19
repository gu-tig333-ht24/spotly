import 'package:flutter/foundation.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/models/collection.dart';
import '../../../../data/providers/database_providers.dart';
import '../../../../data/services/database_service.dart';

final collectionListProvider = StateNotifierProvider<CollectionListController,
    AsyncValue<List<Collection>>>((ref) {
  final DatabaseService service = ref.read(databaseServiceProvider);
  return CollectionListController(databaseService: service);
});

class CollectionListController
    extends StateNotifier<AsyncValue<List<Collection>>> {
  CollectionListController({
    required DatabaseService databaseService,
  })  : _databaseService = databaseService,
        super(const AsyncValue.data([]));

  final DatabaseService _databaseService;

  Future<void> addCollection(String title, String description) async {
    final Collection newCollection =
        await _databaseService.createCollection(
      title,
      description,
    );

    final List<Collection> currentCollections = List.from(
      state.value ?? [],
    );

    try {
      currentCollections.add(newCollection);
      state = AsyncData(currentCollections);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> addCollection(), error: $e");
      }
    }
  }

  Future<void> retrieveCollections() async {
    state = const AsyncLoading();

    final List<Collection> collections =
        await _databaseService.retrieveCollections();

    try {
      state = AsyncData(collections);
    } catch (e, st) {
      state = AsyncError(e, st);

      if (kDebugMode) {
        debugPrint("❌ -> retrieveCollections(), error: $e");
      }
    }
  }

  Future<void> deleteCollection(Collection collection) async {
    final deleted = await _databaseService.deleteCollectionById(
      collection.id,
    );
    if (!deleted) {
      // TODO: show snackbar message indicating that something went wrong?
      return;
    }

    final List<Collection> currentCollections = List.from(
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
