import 'dart:io';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  final File? initialFile;
  final String? initialUrl;
  final void Function(File?) onImagePicked;

  const ProfileImagePicker({
    super.key,
    this.initialFile,
    this.initialUrl,
    required this.onImagePicked,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();
  final bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    _selectedImage = widget.initialFile;
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      widget.onImagePicked(_selectedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;
    if (_selectedImage != null) {
      imageWidget = Image.file(_selectedImage!, fit: BoxFit.cover);
    } else if (widget.initialUrl != null && widget.initialUrl!.isNotEmpty) {
      imageWidget = Image.network(
        widget.initialUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.restaurant, size: 50, color: Colors.white),
      );
    } else {
      imageWidget = const Icon(Icons.restaurant, size: 50, color: Colors.white);
    }

    return GestureDetector(
      onTap: _showPickerDialog,
      child: Stack(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              color: Color(0xFFFFC107),
              shape: BoxShape.circle,
            ),
            child: ClipOval(child: imageWidget),
          ),

          if (_isUploading)
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.black54,
                  shape: BoxShape.circle,
                ),
                child: const Center(child: CircularProgressIndicator(color: Colors.white)),
              ),
            ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              width: 36,
              height: 36,
              decoration: const BoxDecoration(
                color: Colors.deepOrange,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.edit, color: Colors.white, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  void _showPickerDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(AppStrings.uploadPhoto.tr()),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(AppStrings.camera.tr()),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(AppStrings.gallery.tr()),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }
}
