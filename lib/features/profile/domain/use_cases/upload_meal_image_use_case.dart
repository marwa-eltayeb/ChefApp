import 'dart:io';
import 'package:chef_app/features/profile/domain/repositories/profile_repository.dart';

class UploadMealImageUseCase {

  final ProfileRepository repository;

  UploadMealImageUseCase(this.repository);

  Future<String> call(File imageFile, String userId) async {
    final result = await repository.uploadMealImage(imageFile, userId);
    if (result == null) throw Exception("Failed to upload image");
    return result;
  }
}

