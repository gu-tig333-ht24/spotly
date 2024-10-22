class Location {
  const Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromMap(Map<String, dynamic> json) {
    return Location(
      id: json["id"] as int,
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
      address: json["address"] as String?,
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
}
