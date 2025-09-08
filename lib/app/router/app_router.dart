import 'package:chef_app/features/meal/presentation/screens/home_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:chef_app/features/language/language_screen.dart';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_cubit.dart';
import 'package:chef_app/features/meal/presentation/screens/add_meal_screen.dart';
import 'package:chef_app/features/meal/presentation/screens/meal_list_screen.dart';
import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chef_app/features/profile/presentation/screens/change_password_screen.dart';
import 'package:chef_app/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:chef_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:chef_app/features/profile/presentation/screens/setting_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chef_app/app/router/routes.dart';

class AppRouter {
  static GoRouter createRouter(String initialRoute) {
    return GoRouter(
      initialLocation: initialRoute,
      routes: [
        // Language
        GoRoute(
          path: Routes.language,
          builder: (context, state) => const LanguageScreen(),
        ),

        // Auth
        GoRoute(
          path: Routes.login,
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: Routes.forgotPassword,
          builder: (context, state) => const ForgetPasswordScreen(),
        ),
        GoRoute(
          path: Routes.resetPassword,
          builder: (context, state) => const ResetPasswordScreen(),
        ),
        GoRoute(
          path: Routes.signUp,
          builder: (context, state) => const SignUpScreen(),
        ),

        // Home
        GoRoute(
          path: Routes.home,
          builder: (context, state) => const HomeScreen(),
        ),

        // Meals
        GoRoute(
          path: Routes.mealList,
          builder: (context, state) => const MealListScreen(),
        ),
        GoRoute(
          path: Routes.addMeal,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>?;
            final cubit = extras?['cubit'] as MealCubit;
            final meal = extras?['meal'] as MealEntity?;

            return BlocProvider.value(
              value: cubit,
              child: AddMealScreen(meal: meal),
            );
          },
        ),

        // Profile
        GoRoute(
          path: Routes.profile,
          builder: (context, state) => const ProfileScreen(),
        ),
        GoRoute(
          path: Routes.editProfile,
          builder: (context, state) {
            final extras = state.extra as Map<String, dynamic>?;
            final cubit = extras?['cubit'] as ProfileCubit;
            final profile = extras?['profile'] as ProfileEntity?;

            if (profile == null) {
              throw Exception('Profile cannot be null for EditProfileScreen');
            }
            return BlocProvider.value(
              value: cubit,
              child: EditProfileScreen(profile: profile),
            );
          },
        ),
        GoRoute(
          path: Routes.changePassword,
          builder: (context, state) => const ChangePasswordScreen(),
        ),
        GoRoute(
            path: Routes.settings,
            builder: (context, state) => const SettingsScreen()
        ),
      ],
    );
  }
}

