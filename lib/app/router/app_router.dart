import 'package:chef_app/features/language/language_screen.dart';
import 'package:flutter/material.dart';
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
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.forgotPassword,
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.resetPassword,
          builder: (context, state) => const Placeholder(),
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

        // Settings
        GoRoute(
          path: Routes.settings,
          builder: (context, state) => const Placeholder(),
        ),

        // Meals
        GoRoute(
          path: Routes.mealList,
          builder: (context, state) => const Placeholder(),
        ),
        GoRoute(
          path: Routes.addMeal,
          builder: (context, state) => const Placeholder(),
        ),
      ],
    );
  }
}
