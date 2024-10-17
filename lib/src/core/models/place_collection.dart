class PlaceCollection {
  PlaceCollection({
    required this.id,
    required this.title,
    required this.createdAt,
  });

  factory PlaceCollection.fromJson(Map<String, dynamic> json) {
    return PlaceCollection(
      id: json.containsKey("id") ? json["id"] : "",
      title: json.containsKey("title") ? json["title"] : "",
      createdAt: json.containsKey("createdAt")
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  final String id;
  final String title;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "createdAt": createdAt,
    };
  }
}
