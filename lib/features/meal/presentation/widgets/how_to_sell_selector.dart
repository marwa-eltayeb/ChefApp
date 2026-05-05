import 'package:chef_app/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class HowToSellSelector extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;

  const HowToSellSelector({
    super.key,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<HowToSellSelector> createState() => _HowToSellSelectorState();
}

class _HowToSellSelectorState extends State<HowToSellSelector> {

  late String _selected;

  @override
  void initState() {
    super.initState();
    _selected = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return RadioGroup<String>(
      groupValue: _selected,
      onChanged: (val) {
        setState(() => _selected = val!);
        widget.onChanged(val!);
      },
      child: Row(
        children: [
          Transform.translate(
            offset: const Offset(-12, 0),

            child: Row(
              children: [
                const Radio<String>(
                  value: AppStrings.mealNumber,
                  activeColor: Colors.orange,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                Text(
                  AppStrings.mealNumber.tr(),
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2D2D2D),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          Row(
            children: [
              const Radio<String>(
                value: AppStrings.mealQuantity,
                activeColor: Colors.orange,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              Text(
                AppStrings.mealQuantity.tr(),
                style: const TextStyle(
                  fontSize: 20,
                  color: Color(0xFF2D2D2D),
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}