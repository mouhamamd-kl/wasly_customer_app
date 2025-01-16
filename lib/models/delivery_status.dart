class DeliveryStatus {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  DeliveryStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a `DeliveryStatus` from JSON
  factory DeliveryStatus.fromJson(Map<String, dynamic> json) {
    return DeliveryStatus(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `DeliveryStatus` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
