import 'dart:io';

import 'package:chef_app/features/profile/data/models/profile_model.dart';
import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';
import 'package:chef_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chef_app/features/profile/data/data_sources/profile_data_source.dart';

class ProfileRepositoryImpl implements ProfileRepository {

  final ProfileDataSource dataSource;

  ProfileRepositoryImpl(this.dataSource);

  @override
  Future<ProfileEntity> getProfile(String id) async {
    final model = await dataSource.getProfile(id);
    return model.toEntity();
  }

  @override
  Future<ProfileEntity> updateProfile(ProfileEntity profile) async {
    final model = ProfileModel.fromEntity(profile);
    final updated = await dataSource.updateProfile(model);
    return updated.toEntity();
  }

  @override
  Future<String?> uploadMealImage(File imageFile, String userId) {
    return dataSource.uploadMealImage(imageFile, userId);
  }
}
