// Business-level validators for authentication use cases.
class AuthValidators {

  static final RegExp _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static const int _minPasswordLength = 8;

  static void validateLoginInput({
    required String email,
    required String password,
  }) {
    _validateEmail(email);

    if (password.isEmpty) {
      throw ArgumentError('error_password_required');
    }
    if (password.length < _minPasswordLength) {
      throw ArgumentError('error_password_too_short');
    }
  }

  static void validateForgotPasswordInput(String email) {
    _validateEmail(email);
  }

  static void validateResetPasswordInput({
    required String newPassword,
    String? token,
  }) {
    if (newPassword.isEmpty) {
      throw ArgumentError('error_password_required');
    }
    if (newPassword.length < _minPasswordLength) {
      throw ArgumentError('error_password_too_short');
    }

    if (token != null && token.isEmpty) {
      throw ArgumentError('error_reset_token_required');
    }
  }

  static void _validateEmail(String email) {
    if (email.isEmpty) {
      throw ArgumentError('error_email_required');
    }
    if (!_emailRegex.hasMatch(email)) {
      throw ArgumentError('error_invalid_email');
    }
  }

  static String? validatePassword(String password) {
    if (password.isEmpty) {
      return "error_password_required";
    }
    if (password.length < _minPasswordLength) {
      return "error_password_too_short";
    }

    final regex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d).+$');
    if (!regex.hasMatch(password)) {
      return "error_password_weak";
    }
    return null;
  }

  static String? validatePasswordMatch(String newPassword, String confirmPassword) {
    if (newPassword != confirmPassword) {
      return "error_password_mismatch";
    }
    return null;
  }

  static void validateSignUpInput({
    required String email,
    required String password,
    required String name,
    required String phone,
    String? brandName,
    String? description,
  }) {
    _validateEmail(email);

    if (password.isEmpty) {
      throw ArgumentError('error_password_required');
    }
    if (password.length < _minPasswordLength) {
      throw ArgumentError('error_password_too_short');
    }

    if (name.isEmpty) {
      throw ArgumentError('error_name_required');
    }

    if (phone.isEmpty) {
      throw ArgumentError('error_phone_required');
    }

    if (brandName == null || brandName.isEmpty) {
      throw ArgumentError('error_brand_name_required');
    }
  }
  
}
