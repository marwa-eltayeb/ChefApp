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
import 'package:chef_app/features/meal/data/data_sources/meal_data_source.dart';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';
import 'package:chef_app/features/meal/data/data_sources/supabase_meal_data_source.dart';
import 'package:chef_app/features/meal/data/repositories/meal_repository_impl.dart';
import 'package:chef_app/features/meal/domain/use_cases/add_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/delete_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/edit_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/load_meals_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/upload_meal_image_use_case.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_cubit.dart';

final getIt = GetIt.instance;

void setupDependencies() {

  final supabaseClient = Supabase.instance.client;
  getIt.registerSingleton<SupabaseClient>(supabaseClient);

  // Data Sources
  getIt.registerLazySingleton<AuthDataSource>(() => SupabaseAuthDataSource(getIt<SupabaseClient>()));
  getIt.registerLazySingleton<MealDataSource>(() => SupabaseMealDataSource(getIt<SupabaseClient>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthDataSource>()));
  getIt.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(getIt<MealDataSource>()));

  // Auth Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserIdUseCase(getIt<AuthRepository>()));

  // Meal Use Cases
  getIt.registerLazySingleton(() => AddMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => DeleteMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => EditMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => LoadMealsUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => UploadMealImageUseCase(getIt<MealRepository>()));

  // Cubits
  getIt.registerFactory(() => AuthCubit(
    loginUseCase: getIt<LoginUseCase>(),
    forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
  ));

  getIt.registerFactory(() => MealCubit(
    addMealUseCase: getIt<AddMealUseCase>(),
    deleteMealUseCase: getIt<DeleteMealUseCase>(),
    editMealUseCase: getIt<EditMealUseCase>(),
    loadMealsUseCase: getIt<LoadMealsUseCase>(),
    uploadMealImageUseCase: getIt<UploadMealImageUseCase>(),
    getCurrentUserIdUseCase: getIt<GetCurrentUserIdUseCase>(),
  ));
}