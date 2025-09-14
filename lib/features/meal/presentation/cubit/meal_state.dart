import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';

abstract class MealState {}

class MealInitial extends MealState {}

class MealLoading extends MealState {}

class MealLoaded extends MealState {
  final List<MealEntity> meals;
  MealLoaded(this.meals);
}

class MealError extends MealState {
  final String message;
  MealError(this.message);
}