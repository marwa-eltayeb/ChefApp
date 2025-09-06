import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';

class LoadMealsUseCase {

  final MealRepository repository;

  LoadMealsUseCase(this.repository);

  Future<List<MealEntity>> call({String? chefId}) async {
    return await repository.loadMeals(chefId: chefId);
  }
}
