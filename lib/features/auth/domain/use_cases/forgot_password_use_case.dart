import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/utils/auth_validators.dart';

class ForgotPasswordUseCase {

  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<void> execute(String email) async {
    AuthValidators.validateForgotPasswordInput(email);
    return repository.forgotPassword(email);
  }
}
