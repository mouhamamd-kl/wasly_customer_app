import 'delivery_status.dart';

class Delivery {
  final int id;

  // Personal details
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;

  // Contact information
  final String phone;
  final String email;

  // Account details
  final String? emailVerifiedAt; // Nullable if not always verified

  // Additional attributes
  final String photo;

  // Relationships
  final DeliveryStatus?
      deliveryStatus; // Nullable because it's conditionally loaded

  // Location details
  final double? currentLatitude; // Nullable if not always set
  final double? currentLongitude; // Nullable if not always set

  // Chat information
  final String? chatId;

  // Timestamps
  final DateTime createdAt;
  final DateTime updatedAt;

  Delivery({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    this.emailVerifiedAt,
    required this.photo,
    this.deliveryStatus,
    this.currentLatitude,
    this.currentLongitude,
    this.chatId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Factory method to create a `Delivery` from JSON
  factory Delivery.fromJson(Map<String, dynamic> json) {
    return Delivery(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      phone: json['phone'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      photo: json['photo'],
      deliveryStatus: json['delivery_status'] != null
          ? DeliveryStatus.fromJson(json['delivery_status'])
          : null,
      currentLatitude: json['current_latitude'] != null
          ? json['current_latitude'].toDouble()
          : null,
      currentLongitude: json['current_longitude'] != null
          ? json['current_longitude'].toDouble()
          : null,
      chatId: json['chat_id'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  /// Convert `Delivery` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'gender': gender,
      'phone': phone,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'photo': photo,
      'delivery_status': deliveryStatus?.toJson(),
      'current_latitude': currentLatitude,
      'current_longitude': currentLongitude,
      'chat_id': chatId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
