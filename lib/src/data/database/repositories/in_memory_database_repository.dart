import '../entities/place_collection_entity.dart';
import '../interfaces/database_repository.dart';

class InMemoryDatabaseRepository implements DatabaseRepository {
  final List<PlaceCollectionEntity> _items = [];
  int _autoIncrementedId = 0;

  @override
  Future<PlaceCollectionEntity> createPlaceCollection(
      PlaceCollectionEntity entity) {
    _autoIncrementedId += 1;
    entity = entity.copyWith(id: _autoIncrementedId);
    _items.add(entity);
    return Future.value(entity);
  }

  @override
  Future<List<PlaceCollectionEntity>> retrievePlaceCollections() =>
      Future.value(
        List.unmodifiable(_items),
      );

  @override
  Future<PlaceCollectionEntity?> retrievePlaceCollectionById(int id) =>
      Future.value(
        _items.where((entity) => entity.id == id).firstOrNull,
      );

  @override
  Future<bool> updatePlaceCollection(PlaceCollectionEntity entity) {
    int index = _items.indexWhere((e) => e.id == entity.id);
    if (index == -1) {
      return Future.value(false);
    }

    _items[index] = entity.copyWith(
      title: entity.title,
      description: entity.description,
    );
    return Future.value(true);
  }

  @override
  Future<bool> deletePlaceCollectionById(int id) {
    int index = _items.indexWhere((entity) => entity.id == id);
    if (index == -1) {
      return Future.value(false);
    }

    return Future.value(
      _items.remove(_items[index]),
    );
  }
}
