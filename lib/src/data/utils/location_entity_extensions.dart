import '../../core/models/location.dart';
import '../database/entities/location_entity.dart';

extension LocationEntityExtensions on LocationEntity {
  Location toModel() => Location(
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
}
