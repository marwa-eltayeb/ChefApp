import 'package:chef_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String id;
  final String email;
  final String? token;

  UserModel({
    required this.id,
    required this.email,
    this.token,
  });

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      email: email,
    );
  }
}
