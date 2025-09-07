import 'dart:io';
import 'package:chef_app/features/auth/domain/use_cases/get_current_user_id_use_case.dart';
import 'package:chef_app/features/meal/domain/use_cases/upload_meal_image_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chef_app/features/profile/domain/use_cases/get_profile_use_case.dart';
import 'package:chef_app/features/profile/domain/use_cases/update_profile_use_case.dart';
import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';

import 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UploadMealImageUseCase uploadMealImageUseCase;
  final GetCurrentUserIdUseCase getCurrentUserIdUseCase;

  ProfileCubit({
    required this.getProfileUseCase,
    required this.updateProfileUseCase,
    required this.uploadMealImageUseCase,
    required this.getCurrentUserIdUseCase,
  }) : super(ProfileInitial());

  // Load profile
  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final userId = await getCurrentUserIdUseCase();
      if (userId == null) {
        emit(ProfileError("No logged-in user"));
        return;
      }
      final profile = await getProfileUseCase(userId);
      emit(ProfileLoaded(profile));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateProfile(ProfileEntity profile, {File? imageFile}) async {
    emit(ProfileLoading());
    try {
      final userId = await getCurrentUserIdUseCase();
      if (userId == null) throw Exception("User not authenticated");
      var updatedProfile = profile.copyWith(id: userId);

      if (imageFile != null) {
        final imageUrl = await uploadMealImageUseCase(imageFile, userId);
        updatedProfile = updatedProfile.copyWith(profilePic: imageUrl);
      }

      final result = await updateProfileUseCase(updatedProfile);

      emit(ProfileLoaded(result));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }



}



