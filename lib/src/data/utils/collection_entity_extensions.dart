import '../../core/models/collection.dart';
import '../database/entities/collection_entity.dart';

extension CollectionEntityExtensions on CollectionEntity {
  Collection toModel({required int id}) => Collection(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
      );
}
