import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:chef_app/app/router/routes.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',

    routes: [

      // Temporary Screen
      GoRoute(
        path: '/',
        builder: (context, state) => Scaffold(
          body: Container(
            color: Colors.deepPurple.shade100,
            child: const Center(
              child: Text(
                "Temporary Screen",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
        ),
      ),

      // Language
      GoRoute(
        path: Routes.language,
        builder: (context, state) => const Placeholder(),
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
