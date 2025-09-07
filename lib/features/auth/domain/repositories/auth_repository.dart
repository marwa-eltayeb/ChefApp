import 'package:chef_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String newPassword, {String? token});
  Future<String?> getCurrentUserId();
  Future<void> changePassword({required String oldPassword, required String newPassword,});
  Future<void> logout();
}

