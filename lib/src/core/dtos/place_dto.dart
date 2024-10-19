import '../models/place_location.dart';

class PlaceDto {
  PlaceDto({
    required this.title,
    required this.description,
    required this.imagePath,
    this.location,
  });

  final String title;
  final String description;
  final String? imagePath;
  final PlaceLocation? location;
}
