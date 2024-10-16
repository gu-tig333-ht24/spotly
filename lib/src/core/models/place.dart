import 'package:uuid/uuid.dart';
import 'dart:io';  // För att hantera filer

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image, // Vi använder 'image' som ett File-objekt
    required this.description, // Beskrivning av platsen
    required this.createdAt,   // Tidpunkt då platsen skapades
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image; // Bilden representeras som ett File-objekt
  final String description;  // Beskrivning
  final DateTime createdAt;   // Tidpunkt för när platsen skapades

  // Konvertera ett Place-objekt till en JSON-struktur
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': image.path, // Använd 'image.path' för att spara filvägen
      'description': description,
      'createdAt': createdAt.toIso8601String(), // Spara tid i ISO-format
    };
  }

  // Skapa ett Place-objekt från JSON-struktur
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      image: File(json['imagePath']), // Använd 'File' för att skapa ett File-objekt från filvägen
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
