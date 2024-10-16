import 'package:uuid/uuid.dart';
import 'dart:io';

const uuid = Uuid();

class Place {
  Place({
    required this.title,
    required this.image, // Add 'image' to the constructor
  }) : id = uuid.v4();

  final String id;
  final String title;
  final File image; // Final image field that must be initialized
}
