// import 'package:uuid/uuid.dart';
// import 'dart:io'; // For file handling

// const uuid = Uuid();

// class PlaceLocation {
//   const PlaceLocation({
//     required this.latitude,
//     required this.longitude,
//     required this.address,
//   });
//   final double latitude;
//   final double longitude;
//   final String address;
// }

// class Place {
//   Place({
//     required this.title,
//     required this.image, // Use image as file object
//     required this.description, // Place description
//     required this.createdAt,
//     required this.location, // Date when place is created
//   }) : id = uuid.v4();

//   final String id;
//   final String title;
//   final File image;
//   final String description;
//   final DateTime createdAt;
//   final PlaceLocation location;

//   // Convert the Place object to JSON format
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'imagePath': image.path, // Use 'image.path' to save the filepath
//       'description': description,
//       'createdAt': createdAt.toIso8601String(), // Save date in ISO format
//     };
//   }

//   // Create a Place-object from JSON
//   factory Place.fromJson(Map<String, dynamic> json) {
//     return Place(
//       title: json['title'],
//       image: File(json[
//           'imagePath']), // Använd 'File' för att skapa ett File-objekt från filvägen
//       description: json['description'],
//       createdAt: DateTime.parse(json['createdAt']),
//     );
//   }
// }
import 'package:uuid/uuid.dart';
import 'dart:io'; // För filhantering

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

class Place {
  Place({
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
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      image: File(json['imagePath']), // Skapa ett File-objekt från filvägen
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      //location: PlaceLocation.fromJson(
      //json['location']), // Återställ platsinformation från JSON
    );
  }
}
