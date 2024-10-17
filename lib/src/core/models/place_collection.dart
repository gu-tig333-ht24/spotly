class PlaceCollection {
  PlaceCollection({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.description,
  });

  factory PlaceCollection.fromJson(Map<String, dynamic> json) {
    return PlaceCollection(
      id: json.containsKey("id") ? json["id"] : "",
      title: json.containsKey("title") ? json["title"] : "",
      createdAt: json.containsKey("createdAt")
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
          description: json.containsKey("description") ? json["description"] : "", // Parse description
    );
  }

  final String id;
  final String title;
  final DateTime createdAt;
  final String description; // Add description field

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "createdAt": createdAt,
      "description": description, // Include description in JSON
    };
  }
}
