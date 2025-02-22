import '../../core/models/location.dart';
import '../database/entities/location_entity.dart';

extension LocationEntityExtensions on LocationEntity {
  Location toModel({required int id}) => Location(
        id: id,
        latitude: latitude,
        longitude: longitude,
        address: address,
      );
}
