import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/meal/presentation/widgets/meal_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_cubit.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_state.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class MealListScreen extends StatefulWidget {
  const MealListScreen({super.key});

  @override
  State<MealListScreen> createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  late final MealCubit _mealCubit;

  @override
  void initState() {
    super.initState();
    _mealCubit = GetIt.I<MealCubit>()..loadMeals();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _mealCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFFF5F5F5),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                CustomButton(
                  text: AppStrings.addMeal.tr(),
                  onPressed: () async {
                    await GoRouter.of(context,).push(Routes.addMeal, extra: {'cubit': _mealCubit});
                  },
                  backgroundColor: Colors.orange,
                  textColor: Colors.white,
                ),

                const SizedBox(height: 24),

                Expanded(
                  child: BlocBuilder<MealCubit, MealState>(
                    builder: (context, state) {
                      if (state is MealLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is MealLoaded) {
                        if (state.meals.isEmpty) {
                          return Center(child: Text(AppStrings.noMeals.tr()));
                        }
                        return ListView.builder(
                          itemCount: state.meals.length,
                          itemBuilder: (context, index) {
                            final meal = state.meals[index];
                            return MenuItem(
                              imageUrl: meal.mealImages.isNotEmpty ? meal.mealImages.first : "",
                              title: meal.name,
                              subtitle: meal.description ?? "",
                              price: "${meal.price.toInt()} ${AppStrings.le.tr()}",
                              onDelete: () {
                                if (meal.id != null) {
                                  _mealCubit.deleteMeal(meal.id!);
                                }
                              },
                              onLongPress: () async {
                                await context.push(
                                  Routes.addMeal,
                                  extra: {'cubit': _mealCubit, 'meal': meal},
                                );
                              },
                            );
                          },
                        );
                      } else if (state is MealError) {
                        return Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        );
                      }
                      return Center(child: Text(AppStrings.noMeals.tr()));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
