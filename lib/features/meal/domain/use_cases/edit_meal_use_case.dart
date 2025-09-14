import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';
import 'package:chef_app/features/meal/domain/utils/meal_validator.dart';

class EditMealUseCase {
  final MealRepository repository;

  EditMealUseCase(this.repository);

  Future<MealEntity> call(MealEntity meal) async {

    final nameError = MealValidator.validateName(meal.name);
    if (nameError != null) throw Exception(nameError);

    final priceError = MealValidator.validatePrice(meal.price);
    if (priceError != null) throw Exception(priceError);

    final categoryError = MealValidator.validateCategory(meal.category);
    if (categoryError != null) throw Exception(categoryError);

    return await repository.editMeal(meal);
  }
}
