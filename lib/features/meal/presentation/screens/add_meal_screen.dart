import 'dart:io';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/utils/form_validators.dart';
import 'package:chef_app/features/meal/domain/entities/meal_entity.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_cubit.dart';
import 'package:chef_app/features/meal/presentation/cubit/meal_state.dart';
import 'package:chef_app/features/meal/presentation/widgets/category_dropdown.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chef_app/core/widgets/custom_text_field.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/meal/presentation/widgets/meal_image_picker.dart';

class AddMealScreen extends StatefulWidget {
  final MealEntity? meal;

  const AddMealScreen({super.key, this.meal});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _howToSell = AppStrings.mealNumber;
  File? _selectedImage;
  bool _isUploading = false;

  @override
  void initState() {
    super.initState();
    if (widget.meal != null) {
      _nameController.text = widget.meal!.name;
      _priceController.text = widget.meal!.price.toString();
      _categoryController.text = widget.meal!.category ?? '';
      _descriptionController.text = widget.meal!.description ?? '';
      _howToSell = widget.meal!.howToSell ?? AppStrings.mealNumber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MealCubit, MealState>(
      listener: (context, state) {
        if (state is MealLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator(color: Colors.orange)),
          );
        } else if (state is MealLoaded) {
          Navigator.of(context).pop();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                widget.meal != null
                    ? AppStrings.mealUpdatedSuccessfully.tr()
                    : AppStrings.mealAddedSuccessfully.tr(),
              ),
            ),
          );
        } else if (state is MealError) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            widget.meal != null ? AppStrings.editMeal.tr() : AppStrings.addMeal.tr(),
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          backgroundColor: Colors.orange,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [

                const SizedBox(height: 20),

                Center(
                  child: MealImagePicker(
                    initialFile: _selectedImage,
                    initialUrl: widget.meal?.mealImages.isNotEmpty == true ? widget.meal!.mealImages.first : null,
                    onImagePicked: (file) => setState(() => _selectedImage = file),
                  ),
                ),

                const SizedBox(height: 40),

                CustomTextField(
                  controller: _nameController,
                  hintText: AppStrings.mealName.tr(),
                  validator: FormValidators.validateMealName,
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _priceController,
                  hintText: AppStrings.mealPrice.tr(),
                  keyboardType: TextInputType.number,
                  validator: FormValidators.validateMealPrice,
                ),

                const SizedBox(height: 16),

                CategoryDropdown(
                  value: _categoryController.text,
                  onChanged: (val) => setState(() => _categoryController.text = val ?? ''),
                ),

                const SizedBox(height: 16),

                CustomTextField(
                  controller: _descriptionController,
                  hintText: AppStrings.mealDescription.tr(),
                  validator: FormValidators.validateMealDescription,
                ),

                const SizedBox(height: 32),

                Row(
                  children: [
                    Transform.translate(
                      offset: const Offset(-12, 0),
                      child: Row(
                        children: [
                          Radio<String>(
                            value: AppStrings.mealNumber,
                            groupValue: _howToSell,
                            onChanged: (val) => setState(() => _howToSell = val!),
                            activeColor: Colors.orange,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          Text(
                            AppStrings.mealNumber.tr(),
                            style: const TextStyle(fontSize: 20, color: Color(0xFF2D2D2D)),
                          ),
                        ],
                      ),
                    ),

                    const Spacer(),

                    Row(
                      children: [
                        Radio<String>(
                          value: AppStrings.mealQuantity,
                          groupValue: _howToSell,
                          onChanged: (val) => setState(() => _howToSell = val!),
                          activeColor: Colors.orange,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        Text(
                          AppStrings.mealQuantity.tr(),
                          style: const TextStyle(fontSize: 20, color: Color(0xFF2D2D2D)),
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                CustomButton(
                  text: _isUploading
                      ? AppStrings.uploading.tr()
                      : (widget.meal != null ? AppStrings.editMeal.tr() : AppStrings.addMeal.tr()),
                  onPressed: () {if (!_isUploading) _submit();},
                  backgroundColor: _isUploading ? Colors.grey : Colors.orange,
                  textColor: Colors.white,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isUploading = true);

    try {
      final meal = MealEntity(
        id: widget.meal?.id,
        chefId: widget.meal?.chefId ?? '',
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0.0,
        category: _categoryController.text,
        mealImages: widget.meal?.mealImages ?? [],
        howToSell: _howToSell,
        createdAt: widget.meal?.createdAt ?? DateTime.now(),
        updatedAt: DateTime.now(),
      );

      final cubit = context.read<MealCubit>();
      if (widget.meal != null) {
        await cubit.editMeal(meal, imageFile: _selectedImage);
      } else {
        await cubit.addMeal(meal, imageFile: _selectedImage);
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    } finally {
      setState(() => _isUploading = false);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
