import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';

class DeleteMealUseCase {
  final MealRepository repository;

  DeleteMealUseCase(this.repository);

  Future<void> call(String mealId) async {
    if (mealId.isEmpty) {
      throw Exception("Meal ID is required");
    }
    return await repository.deleteMeal(mealId);
  }
}
