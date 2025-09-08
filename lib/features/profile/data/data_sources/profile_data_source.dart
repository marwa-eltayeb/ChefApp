import 'dart:io';
import 'package:chef_app/features/profile/data/models/profile_model.dart';

abstract class ProfileDataSource {
  Future<ProfileModel> getProfile(String id);
  Future<ProfileModel> updateProfile(ProfileModel profile);
  Future<String?> uploadMealImage(File imageFile, String userId);
}

