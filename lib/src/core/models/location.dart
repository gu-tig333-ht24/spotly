class Location {
  const Location({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromMap(Map<String, dynamic> json) {
    return Location(
      latitude: json["latitude"] as double,
      longitude: json["longitude"] as double,
      address: json["address"] as String?,
    );
  }

  final double latitude;
  final double longitude;
  final String? address;

  Map<String, dynamic> toMap() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "address": address,
    };
  }
}
