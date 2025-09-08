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

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                child: CircularProgressIndicator(color: Colors.orange),
              ),
            );
          } else if (state is AuthLoggedIn) {
            Navigator.of(context).pop();
            context.go(Routes.home);
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
            body: SingleChildScrollView(
              child: Column(
                children: [

                  // Top section with background image
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppAssets.background),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        AppStrings.welcomeBack.tr(),
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),

                  // Bottom section with form
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Form( // Wrap the form here
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 40),

                          // Email TextField
                          CustomTextField(
                            controller: _emailController,
                            hintText: AppStrings.email.tr(),
                            keyboardType: TextInputType.emailAddress,
                            validator: FormValidators.validateEmailField,
                          ),

                          const SizedBox(height: 20),

                          // Password TextField
                          CustomTextField(
                            controller: _passwordController,
                            hintText: AppStrings.password.tr(),
                            isPassword: true,
                            isPasswordVisible: _isPasswordVisible,
                            onTogglePasswordVisibility: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                            validator: FormValidators.validatePasswordField,
                          ),

                          const SizedBox(height: 16),

                          // Forget password link
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {
                                context.go(Routes.forgotPassword);
                              },
                              child: Text(
                                AppStrings.forgetPassword.tr(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF999999),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Sign in button
                          CustomButton(
                            text: AppStrings.signIn.tr(),
                            onPressed: () {
                              if (_formKey.currentState?.validate() ?? false) {
                                blocContext.read<AuthCubit>().login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              }
                            },
                            backgroundColor: const Color(0xFFF5A623),
                            textColor: Colors.white,
                          ),

                          SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                          // Don't have account text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                AppStrings.dontHaveAnAccount.tr(),
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF999999),
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  context.push(Routes.signUp);
                                },
                                child: Text(
                                  AppStrings.signUp.tr(),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFFF5A623),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

