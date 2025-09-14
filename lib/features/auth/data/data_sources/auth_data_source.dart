import 'package:chef_app/features/auth/data/models/user_model.dart';

abstract class AuthDataSource {
  Future<UserModel> login(String email, String password);
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String newPassword, {String? token});
  Future<String?> getCurrentUserId();
}

