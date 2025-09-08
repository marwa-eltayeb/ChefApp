import 'dart:io';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';

abstract class MealRepository {
  Future<MealEntity> addMeal(MealEntity meal);
  Future<void> deleteMeal(String mealId);
  Future<MealEntity> editMeal(MealEntity meal);
  Future<List<MealEntity>> loadMeals({String? chefId});
  Future<String?> uploadMealImage(File imageFile, String userId);
}
