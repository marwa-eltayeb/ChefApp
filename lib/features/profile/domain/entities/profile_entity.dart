class ProfileEntity {
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

  const ProfileEntity({
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

  ProfileEntity copyWith({
    String? id,
    String? userType,
    String? name,
    String? email,
    String? phone,
    String? brandName,
    int? minCharge,
    String? description,
    Map<String, dynamic>? location,
    String? profilePic,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ProfileEntity(
      id: id ?? this.id,
      userType: userType ?? this.userType,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      brandName: brandName ?? this.brandName,
      minCharge: minCharge ?? this.minCharge,
      description: description ?? this.description,
      location: location ?? this.location,
      profilePic: profilePic ?? this.profilePic,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}
