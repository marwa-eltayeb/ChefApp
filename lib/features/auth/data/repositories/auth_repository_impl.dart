import 'package:chef_app/features/auth/data/repositories/clients/auth_client.dart';
import 'package:chef_app/features/auth/domain/entities/user_entity.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {

  final AuthClient client;

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
}
