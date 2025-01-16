import 'store.dart';

class StoreOwner {
  final int id;
  final String firstName;
  final String lastName;
  final String birthDate;
  final String gender;
  final String phone;
  final String email;
  final String photo;
  final String? chatId; // Nullable if not always present
  final String? emailVerifiedAt; // Nullable if not always verified
  final DateTime createdAt;
  final DateTime updatedAt;
  final Store? store; // Nullable because it's loaded conditionally

  StoreOwner({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.birthDate,
    required this.gender,
    required this.phone,
    required this.email,
    required this.photo,
    this.chatId,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    this.store,
  });

  /// Factory method to create a `StoreOwner` from JSON
  factory StoreOwner.fromJson(Map<String, dynamic> json) {
    return StoreOwner(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: json['birth_date'],
      gender: json['gender'],
      phone: json['phone'],
      email: json['email'],
      photo: json['photo'],
      chatId: json['chat_id'],
      emailVerifiedAt: json['email_verified_at'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      store: json['store'] != null ? Store.fromJson(json['store']) : null,
    );
  }

  /// Convert `StoreOwner` to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate,
      'gender': gender,
      'phone': phone,
      'email': email,
      'photo': photo,
      'chat_id': chatId,
      'email_verified_at': emailVerifiedAt,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'store': store?.toJson(),
    };
  }
}
