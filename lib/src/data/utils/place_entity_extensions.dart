import '../../core/models/place.dart';
import '../database/entities/place_entity.dart';

extension PlaceEntityExtensions on PlaceEntity {
  Place toModel({required int id}) => Place(
        id: id,
        collectionId: collectionId,
        title: title,
        imagePath: imagePath,
        description: description,
        createdAt: createdAt,
      );
}
