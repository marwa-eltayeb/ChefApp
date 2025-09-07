import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';

class ProfileModel {
  final String id;
  final String userType;
  final String name;
  final String email;
  final String? phone;
  final String? brandName;
  final int? minCharge;
  final String? description;
  final Map<String, dynamic>? location;
  final String? profilePic;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProfileModel({
    required this.id,
    required this.userType,
    required this.name,
    required this.email,
    this.phone,
    this.brandName,
    this.minCharge,
    this.description,
    this.location,
    this.profilePic,
    required this.createdAt,
    required this.updatedAt,
  });

  Map<String, dynamic> toJson({bool forUpdate = false}) {
    final data = {
      "id": id,
      "user_type": userType,
      "name": name,
      "phone": phone,
      "brand_name": brandName,
      "min_charge": minCharge,
      "description": description,
      "location": location,
      "profile_pic": profilePic,
      "created_at": createdAt.toIso8601String(),
      "updated_at": updatedAt.toIso8601String(),
    };

    if (forUpdate) {
      data.remove("created_at"); // usually not updated manually
    }

    return data;
  }

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json["id"],
      userType: json["user_type"] ?? "chef",
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      brandName: json["brand_name"],
      minCharge: json["min_charge"],
      description: json["description"],
      location: json["location"],
      profilePic: json["profile_pic"],
      createdAt: DateTime.parse(json["created_at"]),
      updatedAt: DateTime.parse(json["updated_at"]),
    );
  }

  // Convert to domain entity
  ProfileEntity toEntity() {
    return ProfileEntity(
      id: id,
      userType: userType,
      name: name,
      email: email,
      phone: phone,
      brandName: brandName,
      minCharge: minCharge,
      description: description,
      location: location,
      profilePic: profilePic,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }

  // Create model from entity
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      id: entity.id,
      userType: entity.userType,
      name: entity.name,
      email: entity.email,
      phone: entity.phone,
      brandName: entity.brandName,
      minCharge: entity.minCharge,
      description: entity.description,
      location: entity.location,
      profilePic: entity.profilePic,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }
}
