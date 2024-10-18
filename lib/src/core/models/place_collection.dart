// class PlaceCollection {
//   PlaceCollection({
//     required this.id,
//     required this.title,
//     required this.createdAt,
//   });

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

class PlaceCollection {
  final String id;
  final String title;
  final String imagePath; // Lägg till bildvägen här
  final DateTime createdAt;

  PlaceCollection({
    required this.id,
    required this.title,
    required this.imagePath, // Lägg till bildvägen i konstruktorn
    required this.createdAt,
  });

  // Konvertera till JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': imagePath, // Lägg till bildvägen i JSON
      'createdAt': createdAt.toIso8601String(),
    };
  }

  // Skapa en instans från JSON
  factory PlaceCollection.fromJson(Map<String, dynamic> json) {
    return PlaceCollection(
      id: json['id'],
      title: json['title'],
      imagePath: json['imagePath'], // Lägg till här
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
