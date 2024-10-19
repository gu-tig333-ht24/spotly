import '../../core/models/place.dart';
import '../database/entities/place_entity.dart';

extension PlaceExtensions on Place {
  PlaceEntity toEntity() => PlaceEntity(
        id: id,
        collectionId: collectionId,
        title: title,
        imagePath: imagePath,
        description: description,
        createdAt: createdAt,
      );
}
