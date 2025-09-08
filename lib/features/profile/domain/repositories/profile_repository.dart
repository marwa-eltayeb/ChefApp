import 'dart:io';

import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<ProfileEntity> getProfile(String id);
  Future<ProfileEntity> updateProfile(ProfileEntity profile);
  Future<String?> uploadMealImage(File imageFile, String userId);
}