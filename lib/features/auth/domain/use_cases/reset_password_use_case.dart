import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/utils/auth_validators.dart';

class ResetPasswordUseCase {

  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<void> execute({required String newPassword, String? token}) {
    AuthValidators.validateResetPasswordInput(newPassword: newPassword, token: token);
    return repository.resetPassword(newPassword, token: token);
  }
}
