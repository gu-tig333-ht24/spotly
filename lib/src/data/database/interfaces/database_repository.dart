import '../entities/place_collection_entity.dart';

abstract interface class DatabaseRepository {
  Future<PlaceCollectionEntity> createPlaceCollection(
      PlaceCollectionEntity entity);

  Future<List<PlaceCollectionEntity>> retrievePlaceCollections();

  Future<PlaceCollectionEntity?> retrievePlaceCollectionById(int id);

  Future<bool> updatePlaceCollection(PlaceCollectionEntity entity);

  Future<bool> deletePlaceCollectionById(int id);
}
