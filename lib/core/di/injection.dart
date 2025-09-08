import 'package:chef_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chef_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chef_app/features/auth/data/data_sources/auth_data_source.dart';
import 'package:chef_app/features/auth/data/data_sources/supabase_auth_data_source.dart';
import 'package:chef_app/features/auth/domain/repositories/auth_repository.dart';
import 'package:chef_app/features/auth/domain/use_cases/forgot_password_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/get_current_user_id_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/login_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  final supabaseClient = Supabase.instance.client;
  getIt.registerSingleton<SupabaseClient>(supabaseClient);

  // Data Sources
  getIt.registerLazySingleton<AuthDataSource>(() => SupabaseAuthDataSource(getIt<SupabaseClient>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthDataSource>()));

  // Auth Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserIdUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepository>()));

  // Cubits
  getIt.registerLazySingleton(() => AuthCubit(
    loginUseCase: getIt<LoginUseCase>(),
    forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    changePasswordUseCase: getIt<ChangePasswordUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
    signUpUseCase: getIt<SignUpUseCase>(),
  ));
}