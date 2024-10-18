class PlaceEntity {
  PlaceEntity({
    required this.id,
    required this.collectionId,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.createdAt,
  });

  factory PlaceEntity.fromMap(Map<String, dynamic> map) {
    return PlaceEntity(
      id: map.containsKey("id") ? map["id"] as int? : null,
      collectionId:
          map.containsKey("collectionId") ? map["collectionId"] as int : -1,
      title: map.containsKey("title") ? map["title"] : "",
      imagePath:
          map.containsKey("imagePath") ? map["imagePath"] as String? : null,
      description:
          map.containsKey("description") ? map["description"] as String? : null,
      createdAt: map.containsKey("createdAt")
          ? DateTime.tryParse(map["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  final int? id;
  final int collectionId;
  final String title;
  final String? imagePath;
  final String? description;
  final DateTime createdAt;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "collectionId": collectionId,
      "title": title,
      "imagePath": imagePath,
      "description": description,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  PlaceEntity copyWith({
    int? id,
    int? collectionId,
    String? title,
    String? imagePath,
    String? description,
    DateTime? createdAt,
  }) {
    return PlaceEntity(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
