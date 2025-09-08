import 'package:chef_app/features/auth/domain/entities/user_entity.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthLoggedIn extends AuthState {
  final UserEntity user;
  AuthLoggedIn(this.user);
}

class AuthLinkSent extends AuthState {}

class AuthPasswordReset extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

class AuthLoggedOut extends AuthState {}

class AuthPasswordChangeLoading extends AuthState {}

class AuthPasswordChangeSuccess extends AuthState {}

class AuthPasswordChangeFailure extends AuthState {
  final String message;
  AuthPasswordChangeFailure(this.message);
}

class AuthSignUpSuccess extends AuthState {
  final UserEntity user;
  AuthSignUpSuccess(this.user);
}

class AuthSignUpFailure extends AuthState {
  final String message;
  AuthSignUpFailure(this.message);
}


