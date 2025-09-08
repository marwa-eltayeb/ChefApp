import 'dart:io';
import 'package:chef_app/features/meal/data/models/meal_model.dart';

abstract class MealDataSource {
  Future<MealModel> addMeal(MealModel meal);
  Future<void> deleteMeal(String mealId);
  Future<MealModel> editMeal(MealModel meal);
  Future<List<MealModel>> loadMeals({String? chefId});
  Future<String?> uploadMealImage(File imageFile, String userId);
}
