import 'package:chef_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:chef_app/features/auth/domain/entities/user_entity.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthDataSource client;

  AuthRepositoryImpl(this.client);

  @override
  Future<UserEntity> login(String email, String password) async {
    final userModel = await client.login(email, password);
    return userModel.toEntity();
  }

  @override
  Future<void> forgotPassword(String email) => client.forgotPassword(email);

  @override
  Future<void> resetPassword(String newPassword, {String? token}) =>
      client.resetPassword(newPassword, token: token);

  @override
  Future<String?> getCurrentUserId() => client.getCurrentUserId();

  @override
  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return client.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }

  @override
  Future<void> logout() async {
    await client.logout();
  }

  @override
  Future<UserEntity> signUp({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? brandName,
    String? description,
  }) async {
    final userModel = await client.signUp(
      email: email,
      password: password,
      name: name,
      phone: phone,
      brandName: brandName,
      description: description,
    );
    return userModel.toEntity();
  }
}
