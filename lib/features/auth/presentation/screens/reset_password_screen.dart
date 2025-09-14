import 'package:chef_app/core/constants/app_assets.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/utils/form_validators.dart';
import 'package:chef_app/core/widgets/custom_text_field.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:chef_app/app/router/routes.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:chef_app/core/di/injection.dart';

class ResetPasswordScreen extends StatefulWidget {

  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNewPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            );
          } else if (state is AuthPasswordReset) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.passwordResetSuccess.tr())),
            );
            context.go(Routes.login);
          } else if (state is AuthFailure) {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Builder(
          builder: (blocContext) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5A623),
              elevation: 0,
              title: Text(
                AppStrings.createNewPasswordTitle.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                      // Lock Icon
                      Center(
                        child: Image.asset(AppAssets.lock,
                          width: 200,
                          height: 200,
                          fit: BoxFit.contain,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Description
                      Text(
                        AppStrings.createNewPasswordDescription.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF2D2D2D),
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 30),

                      // New Password
                      CustomTextField(
                        controller: _newPasswordController,
                        hintText: AppStrings.newPassword.tr(),
                        isPassword: true,
                        isPasswordVisible: _isNewPasswordVisible,
                        onTogglePasswordVisibility: () {
                          setState(() => _isNewPasswordVisible = !_isNewPasswordVisible);
                        },
                        validator: FormValidators.validatePasswordField,
                      ),

                      const SizedBox(height: 20),

                      // Confirm Password
                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: AppStrings.confirmPassword.tr(),
                        isPassword: true,
                        isPasswordVisible: _isConfirmPasswordVisible,
                        onTogglePasswordVisibility: () {
                          setState(() => _isConfirmPasswordVisible = !_isConfirmPasswordVisible);
                        },
                        validator: (value) => FormValidators.validateConfirmPassword(value, _newPasswordController.text),
                      ),

                      const SizedBox(height: 20),

                      // Reset Button
                      CustomButton(
                        text: AppStrings.resetPassword.tr(),
                        backgroundColor: const Color(0xFFF5A623),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            blocContext.read<AuthCubit>().resetPassword(
                              newPassword: _newPasswordController.text,
                            );
                          }
                        },
                      ),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
