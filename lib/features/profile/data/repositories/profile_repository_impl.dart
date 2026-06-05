import 'dart:io';
import 'package:chef_app/core/errors/failures.dart';
import 'package:chef_app/features/profile/data/models/profile_model.dart';
import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';
import 'package:chef_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chef_app/features/profile/data/data_sources/profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<ProfileEntity> getProfile(String id) async {
    try {
      final model = await dataSource.getProfile(id);
      return model.toEntity();
    } catch (e) {
      throw PostgrestFailure.fromException(e);
    }
  }

  @override
  Future<ProfileEntity> updateProfile(ProfileEntity profile) async {
    try {
      final model = ProfileModel.fromEntity(profile);
      final updated = await dataSource.updateProfile(model);
      return updated.toEntity();
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