class Place {
  Place({
    required this.id,
    required this.collectionId,
    required this.title,
    required this.imagePath,
    required this.description,
    required this.createdAt,
  });

  factory Place.fromMap(Map<String, dynamic> map) {
    return Place(
      id: map["id"] as int,
      collectionId: map["collectionId"] as int,
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

  final int id;
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

  Place copyWith({
    int? id,
    int? collectionId,
    String? title,
    String? imagePath,
    String? description,
    DateTime? createdAt,
  }) {
    return Place(
      id: id ?? this.id,
      collectionId: collectionId ?? this.collectionId,
      title: title ?? this.title,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
