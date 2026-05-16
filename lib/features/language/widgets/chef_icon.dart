import 'package:flutter/material.dart';

class ChefIcon extends StatelessWidget {
  const ChefIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo.png',
      width: 120,
      height: 120,
      fit: BoxFit.contain,
    );
  }
}