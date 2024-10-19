import '../../core/models/place_collection.dart';
import '../database/entities/place_collection_entity.dart';

extension PlaceCollectionEntityExtensions on PlaceCollectionEntity {
  PlaceCollection toModel({required int id}) => PlaceCollection(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
      );
}
