import '../../core/models/place_collection.dart';
import '../database/entities/place_collection_entity.dart';

extension PlaceCollectionExtensions on PlaceCollection {
  PlaceCollectionEntity toEntity() => PlaceCollectionEntity(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
      );
}
