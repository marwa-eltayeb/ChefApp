import 'dart:io';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/auth/domain/use_cases/get_current_user_id_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/add_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/delete_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/edit_meal_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/load_meals_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/upload_meal_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:chef_app/features/meal/presentation/cubit/meal_state.dart';

class MealCubit extends Cubit<MealState> {
  final AddMealUseCase addMealUseCase;
  final DeleteMealUseCase deleteMealUseCase;
  final EditMealUseCase editMealUseCase;
  final LoadMealsUseCase loadMealsUseCase;
  final UploadMealImageUseCase uploadMealImageUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;

  MealCubit({
    required this.addMealUseCase,
    required this.deleteMealUseCase,
    required this.editMealUseCase,
    required this.loadMealsUseCase,
    required this.uploadMealImageUseCase,
    required this.getCurrentUserIdUseCase,
  }) : super(MealInitial());

  Future<String?> _getCurrentUserId() async {
    try {
      return await getCurrentUserIdUseCase();
    } catch (e) {
      return null;
    }
  }

  Future<void> loadMeals() async {
    emit(MealLoading());
    try {
      final chefId = await _getCurrentUserId();
      if (chefId == null) throw Exception("User not authenticated");

      final meals = await loadMealsUseCase(chefId: chefId);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> addMeal(MealEntity meal, {File? imageFile}) async {
    emit(MealLoading());
    try {
      final chefId = await _getCurrentUserId();
      if (chefId == null) throw Exception("User not authenticated");

      meal = meal.copyWith(chefId: chefId);

      if (imageFile != null) {
        final chefId = await _getCurrentUserId();
        if (chefId == null) throw Exception("User not authenticated");

        final imageUrl = await uploadMealImageUseCase(imageFile, chefId);
        meal = meal.copyWith(mealImages: [imageUrl]);
      }

      await addMealUseCase(meal);
      final meals = await loadMealsUseCase(chefId: chefId);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> editMeal(MealEntity meal, {File? imageFile}) async {
    emit(MealLoading());
    try {
      final chefId = await _getCurrentUserId();
      if (chefId == null) throw Exception("User not authenticated");

      meal = meal.copyWith(chefId: chefId);

      if (imageFile != null) {
        final chefId = await _getCurrentUserId();
        if (chefId == null) throw Exception("User not authenticated");

        final imageUrl = await uploadMealImageUseCase(imageFile, chefId);
        meal = meal.copyWith(mealImages: [imageUrl]);
      }

      await editMealUseCase(meal);
      final meals = await loadMealsUseCase(chefId: chefId);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }

  Future<void> deleteMeal(String mealId) async {
    emit(MealLoading());
    try {
      final chefId = await _getCurrentUserId();
      if (chefId == null) throw Exception("User not authenticated");

      await deleteMealUseCase(mealId);
      final meals = await loadMealsUseCase(chefId: chefId);
      emit(MealLoaded(meals));
    } catch (e) {
      emit(MealError(e.toString()));
    }
  }
}