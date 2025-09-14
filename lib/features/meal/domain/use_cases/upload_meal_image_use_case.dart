import 'dart:io';
import 'package:chef_app/features/meal/domain/repositories/meal_repository.dart';

class UploadMealImageUseCase {
  final MealRepository repository;

  UploadMealImageUseCase(this.repository);

  Future<String> call(File imageFile, String userId) async {
    final result = await repository.uploadMealImage(imageFile, userId);
    if (result == null) throw Exception("Failed to upload image");
    return result;
  }
}

