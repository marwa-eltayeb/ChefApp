import 'package:chef_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:chef_app/features/auth/data/repositories/clients/supabase_auth_client.dart';
import 'package:chef_app/features/auth/domain/usecases/forgot_password_use_case.dart';
import 'package:chef_app/features/auth/domain/usecases/login_use_case.dart';
import 'package:chef_app/features/auth/domain/usecases/reset_password_use_case.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  // Supabase client
  final supabaseClient = Supabase.instance.client;
  getIt.registerSingleton<SupabaseClient>(supabaseClient);

  // Auth layer
  getIt.registerLazySingleton(() => SupabaseAuthClient(getIt<SupabaseClient>()));
  getIt.registerLazySingleton(() => AuthRepositoryImpl(getIt<SupabaseAuthClient>()));
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt<AuthRepositoryImpl>()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepositoryImpl>()));

  // Auth Cubit
  getIt.registerFactory(() => AuthCubit(
    loginUseCase: getIt<LoginUseCase>(),
    forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
  ));
}
