import 'package:chef_app/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String newPassword, {String? token});
  Future<String?> getCurrentUserId();
  Future<void> changePassword({required String oldPassword, required String newPassword,});
  Future<void> logout();
  Future<UserModel> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? brandName,
    String? description,
  });
}

