class CustomLocation {
  final double latitude;
  final double longitude;

  CustomLocation({required this.latitude, required this.longitude});

  factory CustomLocation.fromJson(Map<String, dynamic> json) {
    return CustomLocation(
      latitude: json['latitude'].toDouble(),
      longitude: json['longitude'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
