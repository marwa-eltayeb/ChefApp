import 'package:chef_app/features/auth/domain/entities/user_entity.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/utils/auth_validators.dart';

class SignUpUseCase {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  Future<UserEntity> execute({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? brandName,
    String? description,
  }) {
    AuthValidators.validateSignUpInput(
      email: email,
      password: password,
      name: name,
      phone: phone,
      brandName: brandName,
      description: description,
    );

    return repository.signUp(
      email: email,
      password: password,
      name: name,
      phone: phone,
      brandName: brandName,
      description: description,
    );
  }
}