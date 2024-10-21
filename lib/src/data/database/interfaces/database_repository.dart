import '../entities/collection_entity.dart';
import '../entities/place_entity.dart';

abstract interface class DatabaseRepository {
  // region Collection

  Future<CollectionEntity> createCollection(CollectionEntity entity);

  Future<List<CollectionEntity>> retrieveCollections();

  Future<CollectionEntity?> retrieveCollectionById(int id);

  Future<bool> updateCollection(CollectionEntity entity);

  Future<bool> deleteCollectionById(int id);

  // endregion

  // region Place

  Future<PlaceEntity> createPlace(PlaceEntity entity);

  Future<List<PlaceEntity>> retrievesPlacesByCollectionId(int collectionId);

  Future<PlaceEntity?> retrievePlaceById(int id);

  Future<bool> updatePlace(PlaceEntity entity);

  Future<bool> deletePlaceById(int id);

  Future<List<PlaceEntity>> searchPlaces(String searchText);

// endregion
}
