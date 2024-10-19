// class PlaceCollection {
//   final String id;
//   final String title;
//   final String imagePath; // Lägg till bildvägen här
//   final DateTime createdAt;

//   PlaceCollection({
//     required this.id,
//     required this.title,
//     required this.imagePath, // Lägg till bildvägen i konstruktorn
//     required this.createdAt,
//     required this.description,
//   });

//   // Konvertera till JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'imagePath': imagePath, // Lägg till bildvägen i JSON
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }

//   // Skapa en instans från JSON
//   factory PlaceCollection.fromJson(Map<String, dynamic> json) {
//     return PlaceCollection(
//       id: json.containsKey("id") ? json["id"] : "",
//       title: json.containsKey("title") ? json["title"] : "",
//       createdAt: json.containsKey("createdAt")
//           ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
//           : DateTime.now(),
//     );
//   }

//   final String id;
//   final String title;
//   final DateTime createdAt;

//   Map<String, dynamic> toJson() {
//     return {
//       "id": id,
//       "title": title,
//       "createdAt": createdAt,
//     };
//   }
// }
// class PlaceCollection {
//   final String id;
//   final String title;
//   final String imagePath; // Bildvägen
//   final String description; // Lägg till beskrivningsfältet här
//   final DateTime createdAt;
//
//   // Konstruktorn inkluderar 'description' nu
//   PlaceCollection({
//     required this.id,
//     required this.title,
//     required this.imagePath, // Lägg till bildvägen i konstruktorn
//     required this.createdAt,
//     required this.description, // Lägg till beskrivningen här
//   });
//
//   // Konvertera till JSON
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'imagePath': imagePath, // Lägg till bildvägen i JSON
//       'description': description, // Lägg till beskrivningen i JSON
//       'createdAt': createdAt.toIso8601String(),
//     };
//   }
//
//   // Skapa en instans från JSON
//   factory PlaceCollection.fromJson(Map<String, dynamic> json) {
//     return PlaceCollection(
//       id: json.containsKey("id") ? json["id"] : "",
//       title: json.containsKey("title") ? json["title"] : "",
//       imagePath: json.containsKey("imagePath")
//           ? json["imagePath"]
//           : "", // Hämtar bildvägen från JSON
//       description: json.containsKey("description")
//           ? json["description"]
//           : "", // Hämtar beskrivningen från JSON
//       createdAt: json.containsKey("createdAt")
//           ? DateTime.tryParse(json["createdAt"]) ?? DateTime.now()
//           : DateTime.now(),
//     );
//   }
// }

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
