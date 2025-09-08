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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _brandNameController = TextEditingController();
  final TextEditingController _brandDescriptionController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _brandNameController.dispose();
    _brandDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<AuthCubit>(),
      child: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => const Center(
                child: CircularProgressIndicator(color: Color(0xFFF5A623)),
              ),
            );
          } else if (state is AuthSignUpSuccess) {
            Navigator.of(context).pop(); // Close loading dialog
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.signUpSuccess.tr())),
            );
            context.go(
              Routes.home,
            ); // Or Routes.login if email verification needed
          } else if (state is AuthFailure) {
            Navigator.of(context).pop(); // Close loading dialog
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Builder(
          builder: (blocContext) => Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: const Color(0xFFF5A623),
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.go(Routes.login),
              ),
              title: Text(
                AppStrings.signUpTitle.tr(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: false,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      Text(
                        AppStrings.welcomeToChefApp.tr(),
                        style: const TextStyle(
                          fontSize: 24,
                          color: Color(0xFF2D2D2D),
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        AppStrings.createAccountDescription.tr(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      const SizedBox(height: 30),

                      CustomTextField(
                        controller: _nameController,
                        hintText: AppStrings.fullName.tr(),
                        validator: FormValidators.validateName,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _emailController,
                        hintText: AppStrings.email.tr(),
                        validator: FormValidators.validateEmailField,
                        keyboardType: TextInputType.emailAddress,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _phoneController,
                        hintText: AppStrings.phoneNumber.tr(),
                        validator: FormValidators.validatePhone,
                        keyboardType: TextInputType.phone,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _brandNameController,
                        hintText: AppStrings.brandName.tr(),
                        validator: FormValidators.validateBrandName,
                      ),
                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _brandDescriptionController,
                        hintText: AppStrings.description.tr(),
                        validator: FormValidators.validateDescription,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _passwordController,
                        hintText: AppStrings.password.tr(),
                        isPassword: true,
                        isPasswordVisible: _isPasswordVisible,
                        onTogglePasswordVisibility: () {
                          setState(
                            () => _isPasswordVisible = !_isPasswordVisible,
                          );
                        },
                        validator: FormValidators.validatePasswordField,
                      ),

                      const SizedBox(height: 16),

                      CustomTextField(
                        controller: _confirmPasswordController,
                        hintText: AppStrings.confirmPassword.tr(),
                        isPassword: true,
                        isPasswordVisible: _isConfirmPasswordVisible,
                        onTogglePasswordVisibility: () {
                          setState(
                            () => _isConfirmPasswordVisible =
                                !_isConfirmPasswordVisible,
                          );
                        },
                        validator: (value) =>
                            FormValidators.validateConfirmPassword(value, _passwordController.text,),
                      ),

                      const SizedBox(height: 50),

                      CustomButton(
                        text: AppStrings.signUp.tr(),
                        backgroundColor: const Color(0xFFF5A623),
                        textColor: Colors.white,
                        onPressed: () => _handleSignUp(blocContext),
                      ),

                      const SizedBox(height: 10),

                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.alreadyHaveAccount.tr(),
                              style: const TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 14,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                context.go(Routes.login);
                              },
                              child: Text(
                                AppStrings.login.tr(),
                                style: const TextStyle(
                                  color: Color(0xFFF5A623),
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
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

  void _handleSignUp(BuildContext blocContext) {
    if (_formKey.currentState?.validate() ?? false) {
      blocContext.read<AuthCubit>().signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        name: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        description: _brandDescriptionController.text.trim(),
        brandName: _brandNameController.text.trim(),
      );
    }
  }
}
