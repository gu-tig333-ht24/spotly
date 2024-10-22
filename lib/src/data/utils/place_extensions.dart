import '../../core/models/place.dart';
import '../database/entities/place_entity.dart';
import 'location_extensions.dart';

extension PlaceExtensions on Place {
  PlaceEntity toEntity() {
    // LocationEntity? location;
    // if (this.location != null) {
    //   location = LocationEntity(
    //     id: this.location?.id,
    //     latitude: this.location!.latitude,
    //     longitude: this.location!.longitude,
    //     address: this.location!.address ?? "",
    //   );
    // }

    return PlaceEntity(
      id: id,
      collectionId: collectionId,
      title: title,
      imagePath: imagePath,
      description: description,
      createdAt: createdAt,
      location: location?.toEntity(),
    );
  }
}
