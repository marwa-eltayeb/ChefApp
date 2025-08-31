class UserEntity {
  final String id;
  final String email;
  final String? name;
  final String? userType;

  UserEntity({
    required this.id,
    required this.email,
    this.name,
    this.userType,
  });
}
