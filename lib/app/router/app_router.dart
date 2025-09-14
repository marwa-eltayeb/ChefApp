import 'package:chef_app/features/meal/presentation/screens/home_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/login_screen.dart';
import 'package:chef_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:chef_app/features/language/language_screen.dart';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_cubit.dart';
import 'package:chef_app/features/meal/presentation/screens/add_meal_screen.dart';
import 'package:chef_app/features/meal/presentation/screens/meal_list_screen.dart';
import 'package:flutter/material.dart';
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
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.editProfile,
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.changePassword,
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.settings,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    );
  }
}

