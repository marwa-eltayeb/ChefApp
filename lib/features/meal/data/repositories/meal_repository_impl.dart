import 'dart:io';
import 'package:chef_app/core/errors/failures.dart';
import 'package:chef_app/features/meal/data/data_sources/meal_data_source.dart';
import 'package:chef_app/features/meal/data/models/meal_model.dart';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealDataSource dataSource;

  MealRepositoryImpl(this.dataSource);

  @override
  Future<MealEntity> addMeal(MealEntity meal) async {
    try {
      final model = MealModel(
        id: meal.id,
        chefId: meal.chefId,
        name: meal.name,
        description: meal.description,
        price: meal.price,
        category: meal.category,
        mealImages: meal.mealImages,
        howToSell: meal.howToSell,
        createdAt: meal.createdAt,
        updatedAt: meal.updatedAt,
      );
      final result = await dataSource.addMeal(model);
      return result.toEntity();
    } catch (e) {
      throw PostgrestFailure.fromException(e);
    }
  }

  @override
  Future<void> deleteMeal(String mealId) async {
    try {
      return await dataSource.deleteMeal(mealId);
    } catch (e) {
      throw PostgrestFailure.fromException(e);
    }
  }

  @override
  Future<MealEntity> editMeal(MealEntity meal) async {
    try {
      final model = MealModel(
        id: meal.id,
        chefId: meal.chefId,
        name: meal.name,
        description: meal.description,
        price: meal.price,
        category: meal.category,
        mealImages: meal.mealImages,
        howToSell: meal.howToSell,
        createdAt: meal.createdAt,
        updatedAt: meal.updatedAt,
      );
      final result = await dataSource.editMeal(model);
      return result.toEntity();
    } catch (e) {
      throw PostgrestFailure.fromException(e);
    }
  }

  @override
  Future<List<MealEntity>> loadMeals({String? chefId}) async {
    try {
      final result = await dataSource.loadMeals(chefId: chefId);
      return result.map((m) => m.toEntity()).toList();
    } catch (e) {
      throw PostgrestFailure.fromException(e);
    }
  }

  @override
  Future<String?> uploadMealImage(File imageFile, String userId) async {
    try {
      return await dataSource.uploadMealImage(imageFile, userId);
    } catch (e) {
      throw StorageFailure.fromException(e);
    }
  }
}
