import '../entities/place_collection_entity.dart';
import '../entities/place_entity.dart';

abstract interface class DatabaseRepository {
  // region PlaceCollection

  Future<PlaceCollectionEntity> createPlaceCollection(
      PlaceCollectionEntity entity);

  Future<List<PlaceCollectionEntity>> retrievePlaceCollections();

  Future<PlaceCollectionEntity?> retrievePlaceCollectionById(int id);

  Future<bool> updatePlaceCollection(PlaceCollectionEntity entity);

  Future<bool> deletePlaceCollectionById(int id);

  // endregion

  // region Place

  Future<PlaceEntity> createPlace(PlaceEntity entity);

  Future<List<PlaceEntity>> retrievesPlacesByCollectionId(int collectionId);

  Future<PlaceEntity?> retrievePlaceById(int id);

  Future<bool> updatePlace(PlaceEntity entity);

  Future<bool> deletePlaceById(int id);

// endregion
}
