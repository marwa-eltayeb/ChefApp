import 'package:chef_app/core/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class CategoryDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final categories = [
      'Appetizers',
      'Main Course',
      'Desserts',
      'Beverages',
      'Salads',
    ];

    return Container(
      height: 55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: DropdownButtonFormField<String>(
        value: value.isEmpty ? null : value,

        decoration: InputDecoration(
          hintText: AppStrings.category.tr(),
          hintStyle: const TextStyle(
            fontSize: 16,
            color: Color(0xFF999999),
            fontWeight: FontWeight.w400,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
        ),

        icon: const Icon(Icons.keyboard_arrow_down, color: Color(0xFF999999)),

        items: categories.map((String category) {
          return DropdownMenuItem<String>(
            value: category,
            child: Text(category),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
