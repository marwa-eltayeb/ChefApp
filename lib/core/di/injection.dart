import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:chef_app/features/auth/domain/use_cases/change_password_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/logout_use_case.dart';
import 'package:chef_app/features/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:chef_app/features/profile/data/data_sources/profile_data_source.dart';
import 'package:chef_app/features/profile/data/data_sources/supabase_profile_data_source.dart';
import 'package:chef_app/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:chef_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chef_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:chef_app/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_cubit.dart';
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
  getIt.registerLazySingleton<ProfileDataSource>(() => SupabaseProfileDataSource(getIt<SupabaseClient>()));

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt<AuthDataSource>()));
  getIt.registerLazySingleton<MealRepository>(() => MealRepositoryImpl(getIt<MealDataSource>()));
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(getIt<ProfileDataSource>()));

  // Auth Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ForgotPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ResetPasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetCurrentUserIdUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => ChangePasswordUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => LogoutUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt<AuthRepository>()));

  // Meal Use Cases
  getIt.registerLazySingleton(() => AddMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => DeleteMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => EditMealUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => LoadMealsUseCase(getIt<MealRepository>()));
  getIt.registerLazySingleton(() => UploadMealImageUseCase(getIt<MealRepository>()));

  // Profile Use Cases
  getIt.registerLazySingleton(() => GetProfileUseCase(getIt<ProfileRepository>()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt<ProfileRepository>()));

  // Cubits
  getIt.registerLazySingleton(() => AuthCubit(
    loginUseCase: getIt<LoginUseCase>(),
    forgotPasswordUseCase: getIt<ForgotPasswordUseCase>(),
    resetPasswordUseCase: getIt<ResetPasswordUseCase>(),
    changePasswordUseCase: getIt<ChangePasswordUseCase>(),
    logoutUseCase: getIt<LogoutUseCase>(),
    signUpUseCase: getIt<SignUpUseCase>(),
  ));

  getIt.registerFactory(() => MealCubit(
    addMealUseCase: getIt<AddMealUseCase>(),
    deleteMealUseCase: getIt<DeleteMealUseCase>(),
    editMealUseCase: getIt<EditMealUseCase>(),
    loadMealsUseCase: getIt<LoadMealsUseCase>(),
    uploadMealImageUseCase: getIt<UploadMealImageUseCase>(),
    getCurrentUserIdUseCase: getIt<GetCurrentUserIdUseCase>(),
  ));

  getIt.registerFactory(() => ProfileCubit(
    getProfileUseCase: getIt<GetProfileUseCase>(),
    updateProfileUseCase: getIt<UpdateProfileUseCase>(),
    uploadMealImageUseCase: getIt<UploadMealImageUseCase>(),
    getCurrentUserIdUseCase: getIt<GetCurrentUserIdUseCase>(),
  ));
}