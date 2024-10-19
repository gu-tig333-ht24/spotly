import '../../core/models/place.dart';
import '../../core/models/collection.dart';
import '../database/entities/collection_entity.dart';
import '../database/entities/place_entity.dart';
import '../database/interfaces/database_repository.dart';
import '../utils/collection_entity_extensions.dart';
import '../utils/collection_extensions.dart';
import '../utils/place_entity_extensions.dart';
import '../utils/place_extensions.dart';

class DatabaseService {
  DatabaseService({required DatabaseRepository repository})
      : _repository = repository;

  final DatabaseRepository _repository;

  // region Collections

  Future<Collection> createCollection(
    String title,
    String description,
  ) async {
    final entity = await _repository.createCollection(
      CollectionEntity(
        id: null,
        title: title,
        description: description,
        createdAt: DateTime.now(),
      ),
    );
    return entity.toModel(id: entity.id!);
  }

  Future<List<Collection>> retrieveCollections() async {
    final List<CollectionEntity> entities =
        await _repository.retrieveCollections();
    return entities
        .map<Collection?>(
          (entity) => entity.id == null ? null : entity.toModel(id: entity.id!),
        )
        .whereType<Collection>()
        .toList();
  }

  Future<Collection?> retrieveCollectionById(int id) async {
    final CollectionEntity? entity =
        await _repository.retrieveCollectionById(id);
    if (entity == null || entity.id == null) {
      return null;
    }

    return entity.toModel(id: entity.id!);
  }

  Future<bool> updateCollection(Collection collection) =>
      _repository.updateCollection(collection.toEntity());

  Future<bool> deleteCollectionById(int id) =>
      _repository.deleteCollectionById(id);

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
