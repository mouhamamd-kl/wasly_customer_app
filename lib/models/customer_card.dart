class CustomerCard {
  final int id;
  final int customerId;
  final String cardNumber; // Last 4 digits only
  final String expirationDate;
  final String cardType;
  final DateTime createdAt;
  final DateTime updatedAt;

  CustomerCard({
    required this.id,
    required this.customerId,
    required this.cardNumber,
    required this.expirationDate,
    required this.cardType,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a `CustomerCard` from JSON
  factory CustomerCard.fromJson(Map<String, dynamic> json) {
    return CustomerCard(
      id: json['id'],
      customerId: json['customer_id'],
      cardNumber: json['card_number'], // Already masked by the API
      expirationDate: json['expiration_date'],
      cardType: json['card_type'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `CustomerCard` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customer_id': customerId,
      'card_number': cardNumber,
      'expiration_date': expirationDate,
      'card_type': cardType,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
