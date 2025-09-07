import 'package:bloc/bloc.dart';
import 'package:chef_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;
  final LogoutUseCase logoutUseCase;
  final ChangePasswordUseCase changePasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
    required this.logoutUseCase,
    required this.changePasswordUseCase,
  }) : super(AuthInitial());

  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      final user = await loginUseCase.execute(email, password);
      emit(AuthLoggedIn(user));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await forgotPasswordUseCase.execute(email);
      emit(AuthLinkSent());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> resetPassword({required String newPassword, String? token}) async {
    emit(AuthLoading());
    try {
      await resetPasswordUseCase.execute(newPassword: newPassword, token: token);
      emit(AuthPasswordReset());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    emit(AuthPasswordChangeLoading());
    try {
      await changePasswordUseCase(
        oldPassword: oldPassword,
        newPassword: newPassword,
        confirmPassword: confirmPassword,
      );
      emit(AuthPasswordChangeSuccess());
    } catch (e) {
      emit(AuthPasswordChangeFailure(e.toString()));
    }
  }
}
