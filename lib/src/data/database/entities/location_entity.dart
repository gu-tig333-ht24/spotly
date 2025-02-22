class LocationEntity {
  LocationEntity({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory LocationEntity.fromMap(Map<String, dynamic> map) {
    return LocationEntity(
      id: map["id"] as int?,
      latitude: map["latitude"] as double,
      longitude: map["longitude"] as double,
      address: map["address"] as String?,
    );
  }

  final int? id;
  final double latitude;
  final double longitude;
  final String? address;

  Map<String, dynamic> toMap() => {
        "id": id,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };

  LocationEntity copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return LocationEntity(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}
