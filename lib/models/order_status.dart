class OrderStatus {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  OrderStatus({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create an `OrderStatus` from JSON
  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'],
      name: json['name'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `OrderStatus` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
