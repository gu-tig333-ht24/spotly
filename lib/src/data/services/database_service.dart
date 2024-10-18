import '../../core/models/place.dart';
import '../../core/models/place_collection.dart';
import '../database/entities/place_collection_entity.dart';
import '../database/entities/place_entity.dart';
import '../database/interfaces/database_repository.dart';
import '../utils/place_collection_entity_extensions.dart';
import '../utils/place_collection_extensions.dart';
import '../utils/place_entity_extensions.dart';
import '../utils/place_extensions.dart';

class DatabaseService {
  DatabaseService({required DatabaseRepository repository})
      : _repository = repository;

  final DatabaseRepository _repository;

  // region Collections

  Future<PlaceCollection> createPlaceCollection(
      String title, String description) async {
    final entity = await _repository.createPlaceCollection(
      PlaceCollectionEntity(
        id: null,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      ),
    );
    return entity.toModel(id: entity.id!);
  }

  Future<List<PlaceCollection>> getPlaceCollections() async {
    final List<PlaceCollectionEntity> entities =
        await _repository.retrievePlaceCollections();
    return entities
        .map<PlaceCollection?>(
          (entity) => entity.id == null ? null : entity.toModel(id: entity.id!),
        )
        .whereType<PlaceCollection>()
        .toList();
  }

  Future<PlaceCollection?> getPlaceCollectionById(int id) async {
    final PlaceCollectionEntity? entity =
        await _repository.retrievePlaceCollectionById(id);
    if (entity == null || entity.id == null) {
      return null;
    }

    return entity.toModel(id: entity.id!);
  }

  Future<bool> updatePlaceCollection(PlaceCollection placeCollection) =>
      _repository.updatePlaceCollection(placeCollection.toEntity());

  Future<bool> deletePlaceCollectionById(int id) =>
      _repository.deletePlaceCollectionById(id);

  // endregion

  // region Places

  Future<Place> createPlace(Place place) async {
    final entity = await _repository.createPlace(
      PlaceEntity(
        id: null,
        collectionId: place.collectionId,
        title: place.title,
        imagePath: place.imagePath,
        description: place.description,
        createdAt: DateTime.now(),
      ),
    );
    return entity.toModel(id: entity.id!);
  }

  Future<List<Place>> getPlacesByCollectionId(int collectionId) async {
    final List<PlaceEntity> entities =
        await _repository.retrievesPlacesByCollectionId(collectionId);
    return entities
        .map<Place?>(
          (entity) => entity.id == null ? null : entity.toModel(id: entity.id!),
        )
        .whereType<Place>()
        .toList();
  }

  Future<Place?> getPlaceById(int id) async {
    final PlaceEntity? entity = await _repository.retrievePlaceById(id);
    if (entity == null || entity.id == null) {
      return null;
    }

    return entity.toModel(id: entity.id!);
  }

  Future<bool> updatePlace(Place place) =>
      _repository.updatePlace(place.toEntity());

  Future<bool> deletePlaceById(int id) => _repository.deletePlaceById(id);

// endregion
}
