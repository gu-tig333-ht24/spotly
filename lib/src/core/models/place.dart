import 'package:uuid/uuid.dart';
import 'dart:io';  // For file handling 

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image, // Use image as file object  
    required this.description, // Place description
    required this.createdAt,   // Date when place is created
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image; 
  final String description; 
  final DateTime createdAt;   

  // Convert the Place object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'imagePath': image.path, // Use 'image.path' to save the filepath 
      'description': description,
      'createdAt': createdAt.toIso8601String(), // Save date in ISO format  
    };
  }

  // Create a Place-object from JSON
  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      title: json['title'],
      image: File(json['imagePath']), // Använd 'File' för att skapa ett File-objekt från filvägen
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
