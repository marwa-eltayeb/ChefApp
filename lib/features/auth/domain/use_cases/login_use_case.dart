import 'package:chef_app/features/auth/domain/entities/user_entity.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/utils/auth_validators.dart';

class LoginUseCase {

  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<UserEntity> execute(String email, String password) {
    AuthValidators.validateLoginInput(email: email, password: password);
    return repository.login(email, password);
  }
}
