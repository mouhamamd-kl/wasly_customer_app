class Customer {
  final int? id;
  final String firstName;
  final String lastName;
  final DateTime? birthDate;
  final String? gender;
  final String phone;
  final String email;
  final String? photo;
  final String? token;
  final DateTime? emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  Customer({
    this.id,
    required this.firstName,
    required this.lastName,
    this.birthDate,
    this.gender,
    required this.phone,
    required this.email,
    this.photo,
    this.token,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory Customer.fromJson(Map<String, dynamic> json) {
    return Customer(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      birthDate: json['birth_date'] != null
          ? DateTime.parse(json['birth_date'])
          : null,
      gender: json['gender'],
      phone: json['phone'],
      email: json['email'],
      photo: json['photo'],
      token: json['token'],
      emailVerifiedAt: json['email_verified_at'] != null
          ? DateTime.parse(json['email_verified_at'])
          : null,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'birth_date': birthDate?.toIso8601String(),
      'gender': gender,
      'phone': phone,
      'email': email,
      'photo': photo,
      'token': token,
      'email_verified_at': emailVerifiedAt?.toIso8601String(),
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
