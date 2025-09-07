import 'package:chef_app/core/constants/app_assets.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/di/injection.dart';
import 'package:chef_app/core/utils/form_validators.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/core/widgets/custom_text_field.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isOldPasswordVisible = false;
  bool isNewPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthPasswordChangeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(AppStrings.passwordChangedSuccessfully.tr()),
              ),
            );
            context.pop();
          } else if (state is AuthPasswordChangeFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8F8F8),
            appBar: AppBar(
              backgroundColor: const Color(0xFFFF8C00),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.pop(),
              ),
              title: Text(
                AppStrings.changePassword.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Container(
                height:
                    MediaQuery.of(context).size.height -
                    MediaQuery.of(context).padding.top -
                    kToolbarHeight,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 30),

                    SizedBox(
                      width: 250,
                      height: 250,
                      child: Image.asset(AppAssets.lock, fit: BoxFit.contain),
                    ),

                    const SizedBox(height: 40),

                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.changePassword.tr(),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF2D2D2D),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: oldPasswordController,
                            hintText: AppStrings.oldPassword.tr(),
                            isPassword: true,
                            isPasswordVisible: isOldPasswordVisible,
                            onTogglePasswordVisibility: () {
                              setState(() {
                                isOldPasswordVisible = !isOldPasswordVisible;
                              });
                            },
                            validator: (value) => FormValidators.validatePasswordField(value),
                          ),

                          const SizedBox(height: 16),

                          CustomTextField(
                            controller: newPasswordController,
                            hintText: AppStrings.newPassword.tr(),
                            isPassword: true,
                            isPasswordVisible: isNewPasswordVisible,
                            onTogglePasswordVisibility: () {
                              setState(() {
                                isNewPasswordVisible = !isNewPasswordVisible;
                              });
                            },
                            validator: (value) => FormValidators.validatePasswordField(value),
                          ),

                          const SizedBox(height: 16),

                          CustomTextField(
                            controller: confirmPasswordController,
                            hintText: AppStrings.confirmPassword.tr(),
                            isPassword: true,
                            isPasswordVisible: isConfirmPasswordVisible,
                            onTogglePasswordVisibility: () {
                              setState(() {
                                isConfirmPasswordVisible = !isConfirmPasswordVisible;
                              });
                            },
                            validator: (value) => FormValidators.validateConfirmPassword(value, newPasswordController.text,),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 52),

                    CustomButton(
                      text: state is AuthPasswordChangeLoading
                          ? AppStrings.updating.tr()
                          : AppStrings.resetPassword.tr(),
                      backgroundColor: const Color(0xFFFF8C00),
                      onPressed: state is AuthPasswordChangeLoading
                          ? () {}
                          : () => _changePassword(context),
                    ),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void _changePassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final cubit = context.read<AuthCubit>();

      cubit.changePassword(
        oldPassword: oldPasswordController.text.trim(),
        newPassword: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );
    }
  }
}
