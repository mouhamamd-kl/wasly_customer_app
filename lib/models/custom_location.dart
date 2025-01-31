class CustomLocation {
  final double latitude;
  final double longitude;

  CustomLocation({required this.latitude, required this.longitude});

  factory CustomLocation.fromJson(Map<String, dynamic> json) {
    return CustomLocation(
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
