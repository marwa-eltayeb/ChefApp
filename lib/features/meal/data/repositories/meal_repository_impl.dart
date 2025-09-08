import 'dart:io';
import 'package:chef_app/features/meal/data/data_sources/meal_data_source.dart';
import 'package:chef_app/features/meal/data/models/meal_model.dart';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';

class MealRepositoryImpl implements MealRepository {
  final MealDataSource dataSource;

  MealRepositoryImpl(this.dataSource);

  @override
  Future<MealEntity> addMeal(MealEntity meal) async {
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
  }

  @override
  Future<void> deleteMeal(String mealId) {
    return dataSource.deleteMeal(mealId);
  }

  @override
  Future<MealEntity> editMeal(MealEntity meal) async {
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
  }

  @override
  Future<List<MealEntity>> loadMeals({String? chefId}) async {
    final result = await dataSource.loadMeals(chefId: chefId);
    return result.map((m) => m.toEntity()).toList();
  }

  @override
  Future<String?> uploadMealImage(File imageFile, String userId) {
    return dataSource.uploadMealImage(imageFile, userId);
  }
}
