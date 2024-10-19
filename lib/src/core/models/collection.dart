class Collection {
  Collection({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  factory Collection.fromJson(Map<String, dynamic> json) {
    return Collection(
      id: json.containsKey("id") ? json["id"] as int : -1,
      title: json.containsKey("title") ? json["title"] : "",
      description: json.containsKey("description") ? json["description"] : "",
      createdAt: json.containsKey("createdAt")
          ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  final int id;
  final String title;
  final String description;
  final DateTime createdAt;

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "description": description,
      "createdAt": createdAt,
    };
  }
}
