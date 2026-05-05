import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/features/meal/presentation/screens/meal_list_screen.dart';
import 'package:chef_app/features/profile/presentation/screens/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {

  int _currentIndex = 0;
  final List<Widget> _tabs = const [
    MealListScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    final List<BottomNavigationBarItem> navItems = [
      BottomNavigationBarItem(
        icon: const Icon(Icons.restaurant_menu),
        label: AppStrings.meals.tr(),
      ),
      BottomNavigationBarItem(
        icon: const Icon(Icons.person),
        label: AppStrings.profile.tr(),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _tabs,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: navItems,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}


