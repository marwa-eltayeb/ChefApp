import 'dart:io';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_text_field.dart';
import 'package:chef_app/features/profile/domain/entities/profile_entity.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:chef_app/features/profile/presentation/cubit/profile_state.dart';
import 'package:chef_app/features/profile/presentation/widgets/meal_image_picker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'dart:convert';

class EditProfileScreen extends StatefulWidget {
  final ProfileEntity profile;

  const EditProfileScreen({super.key, required this.profile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController brandNameController;
  late final TextEditingController minimumChargeController;
  late final TextEditingController descriptionController;
  late final TextEditingController locationController;

  File? _selectedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.profile.name ?? '');
    phoneController = TextEditingController(text: widget.profile.phone ?? '');
    brandNameController =
        TextEditingController(text: widget.profile.brandName ?? '');
    minimumChargeController =
        TextEditingController(text: widget.profile.minCharge?.toString() ?? '');
    descriptionController =
        TextEditingController(text: widget.profile.description ?? '');
    locationController = TextEditingController(
        text: widget.profile.location != null ? jsonEncode(
            widget.profile.location) : '');
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    brandNameController.dispose();
    minimumChargeController.dispose();
    descriptionController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) =>
            const Center(
              child: CircularProgressIndicator(color: Colors.orange),
            ),
          );
        } else if (state is ProfileLoaded) {
          Navigator.of(context).pop();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.profileUpdatedSuccessfully.tr()),
              ));
          } else
              if (state is ProfileError)
          {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF8C00),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            AppStrings.editProfile.tr(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 24),

              Center(
                child: ProfileImagePicker(
                  initialFile: _selectedImage,
                  initialUrl: widget.profile.profilePic,
                  onImagePicked: (file) =>
                      setState(() => _selectedImage = file),
                ),
              ),

              const SizedBox(height: 40),

              // Form Fields
              CustomTextField(
                  controller: nameController,
                  hintText: AppStrings.name.tr()
              ),

              const SizedBox(height: 16),

              CustomTextField(controller: phoneController,
                hintText: AppStrings.phoneNumber.tr(),
                keyboardType: TextInputType.phone
              ),

              const SizedBox(height: 16),

              CustomTextField(
                  controller: brandNameController,
                  hintText: AppStrings.brandName.tr()
              ),

              const SizedBox(height: 16),

              CustomTextField(
                controller: minimumChargeController,
                hintText: AppStrings.minimumCharge.tr(),
                keyboardType: TextInputType.number,
              ),

              const SizedBox(height: 16),

              CustomTextField(
                  controller: descriptionController,
                  hintText: AppStrings.description.tr()
              ),

              const SizedBox(height: 16),

              CustomTextField(
                  controller: locationController,
                  hintText: AppStrings.location.tr()
              ),

              const SizedBox(height: 40),

              CustomButton(
                text: _isUploading
                    ? AppStrings.uploading.tr()
                    : AppStrings.updateProfile.tr(),
                onPressed: () {
                  if (!_isUploading) _updateProfile();
                },
                backgroundColor: _isUploading ? Colors.grey : Colors.orange,
                textColor: Colors.white,
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _updateProfile() async {
    setState(() => _isUploading = true);

    try {
      final profileCubit = context.read<ProfileCubit>();
      final updatedProfile = ProfileEntity(
        id: widget.profile.id,
        name: nameController.text,
        phone: phoneController.text,
        brandName: brandNameController.text,
        minCharge: int.tryParse(minimumChargeController.text) ?? 0,
        description: descriptionController.text,
        location: locationController.text.isNotEmpty ? jsonDecode(
            locationController.text) as Map<String, dynamic> : null,
        profilePic: widget.profile.profilePic,
        email: widget.profile.email,
        userType: widget.profile.userType,
        createdAt: widget.profile.createdAt,
        updatedAt: DateTime.now(),
      );

      await profileCubit.updateProfile(
          updatedProfile, imageFile: _selectedImage);
    } finally {
      if (mounted) setState(() => _isUploading = false);
    }
  }
}
