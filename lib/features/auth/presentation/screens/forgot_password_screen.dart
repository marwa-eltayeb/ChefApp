import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/constants/app_assets.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/widgets/custom_text_field.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:chef_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:chef_app/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:chef_app/core/utils/form_validators.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
          } else if (state is AuthLinkSent) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(AppStrings.resetLinkSent.tr())),
            );
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
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => context.go(Routes.login),
              ),
              title: Text(
                AppStrings.forgetPasswordTitle.tr(),
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
                    children: [
                      const SizedBox(height: 60),

                      // Lock Icon
                      Image.asset(AppAssets.lock,
                        width: 200,
                        height: 200,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),

                      // Description Text
                      Text(
                        AppStrings.forgetPasswordDescription.tr(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF666666),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 40),

                      // Email TextField
                      CustomTextField(
                        controller: _emailController,
                        hintText: AppStrings.email.tr(),
                        keyboardType: TextInputType.emailAddress,
                        validator: FormValidators.validateEmailField,
                      ),

                      const SizedBox(height: 40),

                      // Send Code Button
                      CustomButton(
                        text: AppStrings.sendResetLink.tr(),
                        backgroundColor: const Color(0xFFF5A623),
                        textColor: Colors.white,
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            blocContext.read<AuthCubit>().forgotPassword(
                              email: _emailController.text.trim(),
                            );
                          }
                        },
                      ),
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
