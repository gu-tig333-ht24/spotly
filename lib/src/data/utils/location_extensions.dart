import '../../core/models/location.dart';
import '../database/entities/location_entity.dart';

extension LocationExtensions on Location {
  LocationEntity toEntity() => LocationEntity(
        id: id != -1 ? id : null,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
}
