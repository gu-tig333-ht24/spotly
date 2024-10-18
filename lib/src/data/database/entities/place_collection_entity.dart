class PlaceCollectionEntity {
  PlaceCollectionEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory PlaceCollectionEntity.fromMap(Map<String, dynamic> map) {
    return PlaceCollectionEntity(
      id: map["id"] as int?,
      title: map["title"] as String,
      description: map["description"] as String,
      createdAt: DateTime.parse(map["createdAt"] as String),
    );
  }

  final int? id;
  final String title;
  final String description;
  final DateTime createdAt;

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAt": createdAt.toIso8601String(),
    };
  }

  PlaceCollectionEntity copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? createdAt,
  }) {
    return PlaceCollectionEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
