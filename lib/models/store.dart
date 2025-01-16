import 'package:google_place_plus/google_place_plus.dart';
import 'package:wasly/models/custom_location.dart';

class Store {
  final int id;
  final String name;
  final String photo;
  final CustomLocation location;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;

  Store({
    required this.id,
    required this.name,
    required this.photo,
    required this.location,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      location: CustomLocation.fromJson(json['location']),
      phone: json['phone'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'location': location.toJson(),
      'phone': phone,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
