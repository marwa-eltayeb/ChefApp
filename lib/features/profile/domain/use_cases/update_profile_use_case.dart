import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';
import 'package:chef_app/features/profile/domain/repositories/profile_repository.dart';
import 'package:chef_app/features/profile/domain/utils/profile_validator.dart';

class UpdateProfileUseCase {
  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<ProfileEntity> call(ProfileEntity profile) async {
    final nameError = ProfileValidator.validateName(profile.name);
    if (nameError != null) throw Exception(nameError);

    final phoneError = ProfileValidator.validatePhone(profile.phone);
    if (phoneError != null) throw Exception(phoneError);

    final brandNameError = ProfileValidator.validateBrandName(profile.brandName);
    if (brandNameError != null) throw Exception(brandNameError);

    final minChargeError = ProfileValidator.validateMinCharge(profile.minCharge);
    if (minChargeError != null) throw Exception(minChargeError);

    final descriptionError = ProfileValidator.validateDescription(profile.description);
    if (descriptionError != null) throw Exception(descriptionError);

    final picError = ProfileValidator.validateProfilePic(profile.profilePic);
    if (picError != null) throw Exception(picError);

    return await repository.updateProfile(profile);
  }
}
