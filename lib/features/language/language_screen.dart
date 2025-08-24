import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/widgets/custom_button.dart';
import 'package:chef_app/features/language/widgets/ChefIcon.dart';
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
            image: AssetImage('assets/images/bg_language.png'),
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
                tr('welcome'),
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2D2D2D),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              Text(
                tr('choose_language'),
                style: const TextStyle(
                  fontSize: 16,
                  color: Color(0xFF666666),
                ),
                textAlign: TextAlign.center,
              ),

              const Spacer(flex: 3),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: tr('english'),
                        onPressed: () => _onLanguageSelected(context, 'en'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: CustomButton(
                        text: tr('arabic'),
                        onPressed: () => _onLanguageSelected(context, 'ar'),
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

  void _onLanguageSelected(BuildContext context, String languageCode) {
    LanguageService.saveLanguageCode(languageCode).then((_) {
      if (!context.mounted) return;
      context.setLocale(Locale(languageCode));
      context.go(Routes.login);
    });
  }
}
