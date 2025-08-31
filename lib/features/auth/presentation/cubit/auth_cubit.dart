import 'package:bloc/bloc.dart';
import 'package:chef_app/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:chef_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:chef_app/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {

  final LoginUseCase loginUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  AuthCubit({
    required this.loginUseCase,
    required this.forgotPasswordUseCase,
    required this.resetPasswordUseCase,
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

}
