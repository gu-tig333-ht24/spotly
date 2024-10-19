import '../entities/collection_entity.dart';
import '../entities/place_entity.dart';
import '../interfaces/database_repository.dart';

class InMemoryDatabaseRepository implements DatabaseRepository {
  final List<CollectionEntity> _collections = [];
  int _currentCollectionId = 0;

  final List<PlaceEntity> _places = [];
  int _currentPlaceId = 0;

  // region Collections

  @override
  Future<CollectionEntity> createCollection(
      CollectionEntity entity) {
    _currentCollectionId += 1;
    entity = entity.copyWith(id: _currentCollectionId);
    _collections.add(entity);
    return Future.value(entity);
  }

  @override
  Future<List<CollectionEntity>> retrieveCollections() =>
      Future.value(
        List.unmodifiable(_collections),
      );

  @override
  Future<CollectionEntity?> retrieveCollectionById(int id) =>
      Future.value(
        _collections.where((entity) => entity.id == id).firstOrNull,
      );

  @override
  Future<bool> updateCollection(CollectionEntity entity) {
    int index = _collections.indexWhere((e) => e.id == entity.id);
    if (index == -1) {
      return Future.value(false);
    }

    _collections[index] = entity.copyWith(
      title: entity.title,
      description: entity.description,
    );
    return Future.value(true);
  }

  @override
  Future<bool> deleteCollectionById(int id) {
    int index = _collections.indexWhere((entity) => entity.id == id);
    if (index == -1) {
      return Future.value(false);
    }

    final deleted = _collections.remove(_collections[index]);
    if (deleted) {
      // Delete Place:s that were "related" to the deleted Collection
      _places.removeWhere((place) => place.collectionId == id);
    }

    return Future.value(deleted);
  }

  // endregion

  // region Places

  @override
  Future<PlaceEntity> createPlace(PlaceEntity entity) {
    _currentPlaceId += 1;
    entity = entity.copyWith(id: _currentPlaceId);
    _places.add(entity);
    return Future.value(entity);
  }

  @override
  Future<List<PlaceEntity>> retrievesPlacesByCollectionId(int collectionId) =>
      Future.value(
        List<PlaceEntity>.unmodifiable(
          _places.where((entity) => entity.collectionId == collectionId),
        ).toList(),
      );

  @override
  Future<PlaceEntity?> retrievePlaceById(int id) => Future.value(
        _places.where((entity) => entity.id == id).firstOrNull,
      );

  @override
  Future<bool> updatePlace(PlaceEntity entity) {
    int index = _places.indexWhere((e) => e.id == entity.id);
    if (index == -1) {
      return Future.value(false);
    }

    _places[index] = entity.copyWith(
      title: entity.title,
      imagePath: entity.imagePath,
      description: entity.description,
    );
    return Future.value(true);
  }

  @override
  Future<bool> deletePlaceById(int id) {
    int index = _places.indexWhere((entity) => entity.id == id);
    if (index == -1) {
      return Future.value(false);
    }

    return Future.value(
      _places.remove(_places[index]),
    );
  }

// endregion
}
