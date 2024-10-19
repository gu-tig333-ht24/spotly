import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class PlaceLocation {
  const PlaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  final double latitude;
  final double longitude;
  final String address;

  // Konvertera PlaceLocation till JSON-format
  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
    };
  }

  // Skapa en PlaceLocation från JSON
  factory PlaceLocation.fromJson(Map<String, dynamic> json) {
    return PlaceLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
      address: json['address'],
    );
  }
}

class Place2 {
  Place2({
    required this.title,
    required this.image, // Använd image som File-objekt
    required this.description, // Beskrivning av platsen
    required this.createdAt, // Datum då platsen skapades
    //required this.location, // Obligatoriskt fält för location
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image;
  final String description;
  final DateTime createdAt;
  //final PlaceLocation location; // Final variabel för platsens position

  // Konvertera Place-objekt till JSON-format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': image.path, // Använd 'image.path' för att spara filvägen
      'description': description,
      'createdAt': createdAt.toIso8601String(), // Spara datum i ISO-format
      //'location': location.toJson(), // Lägg till platsinformationen
    };
  }

  // Skapa ett Place-objekt från JSON
  factory Place2.fromJson(Map<String, dynamic> json) {
    return Place2(
      title: json['title'],
      image: File(json['imagePath']), // Skapa ett File-objekt från filvägen
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      //location: PlaceLocation.fromJson(
      //json['location']), // Återställ platsinformation från JSON
    );
  }
}

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
