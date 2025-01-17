class CustomerAddress {
  final int id;
  final int customerId;
  final String label;
  final double longitude;
  final double latitude;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomerAddress({
    required this.id,
    required this.customerId,
    required this.label,
    required this.longitude,
    required this.latitude,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a `CustomerAddress` from JSON
  factory CustomerAddress.fromJson(Map<String, dynamic> json) {
    return CustomerAddress(
      id: json['id'],
      customerId: json['customer_id'],
      label: json['label'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      isDefault: json['is_default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `CustomerAddress` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'label': label,
      'longitude': longitude,
      'latitude': latitude,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
