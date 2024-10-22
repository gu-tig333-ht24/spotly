class Location {
  const Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map["id"] as int,
      latitude: map["latitude"] as double,
      longitude: map["longitude"] as double,
      address: map["address"] as String?,
    );
  }

  final int id;
  final double latitude;
  final double longitude;
  final String? address;

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
    };
  }

  Location copyWith({
    int? id,
    double? latitude,
    double? longitude,
    String? address,
  }) {
    return Location(
      id: id ?? this.id,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      address: address ?? this.address,
    );
  }
}
