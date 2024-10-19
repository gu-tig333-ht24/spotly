import '../../core/models/collection.dart';
import '../database/entities/collection_entity.dart';

extension CollectionExtensions on Collection {
  CollectionEntity toEntity() => CollectionEntity(
        id: id,
        title: title,
        description: description,
        createdAt: createdAt,
      );
}
