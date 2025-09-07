import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/utils/auth_validators.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> call({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    // validate old password
    final oldError = AuthValidators.validatePassword(oldPassword);
    if (oldError != null) throw ArgumentError(oldError);

    // validate new password
    final newError = AuthValidators.validatePassword(newPassword);
    if (newError != null) throw ArgumentError(newError);

    // check confirm match
    final matchError = AuthValidators.validatePasswordMatch(newPassword, confirmPassword);
    if (matchError != null) throw ArgumentError(matchError);

    // must not reuse same password
    if (oldPassword == newPassword) {
      throw ArgumentError("error_password_reuse");
    }

    return repository.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
  }
}
