import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/constants/app_assets.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/di/injection.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/language/widgets/chef_icon.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:chef_app/app/localization/language_service.dart';
import 'package:go_router/go_router.dart';

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bgLanguage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(flex: 2),
              const ChefIcon(),
              const SizedBox(height: 40),

              Text(
                AppStrings.welcomeToChefApp.tr(),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                AppStrings.pleaseChooseYourLanguage.tr(),
                style: const TextStyle(fontSize: 16, color: Color(0xFF666666)),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              // Language Selection Buttons
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [

                    Expanded(
                      child: CustomButton(
                        text: AppStrings.english.tr(),
                        onPressed: () => _onLanguageSelected(context, AppStrings.englishCode),
                      ),
                    ),

                    const SizedBox(width: 20),

                    Expanded(
                      child: CustomButton(
                        text: AppStrings.arabic.tr(),
                        onPressed: () => _onLanguageSelected(context, AppStrings.arabicCode),
                      ),
                    ),

                  ],
                ),
              ),

              const Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }

  void _onLanguageSelected(BuildContext context, String languageCode) async {
    final languageService = getIt<LanguageService>();
    await languageService.saveLanguageCode(languageCode);
    if (!context.mounted) return;
    context.setLocale(Locale(languageCode));
    context.go(Routes.login);
  }
}
