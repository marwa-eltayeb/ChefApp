import 'package:chef_app/app/localization/app_localization.dart';
import 'package:chef_app/app/localization/language_service.dart';
import 'package:chef_app/app/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:chef_app/app/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {

  await AppLocalization.initEasyLocalization();
  final initialLocale = await LanguageService.getSavedLocale();
  final hasLanguage = await LanguageService.isLanguageSelected();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: initialLocale,
      child: MyApp(initialRoute: hasLanguage ? Routes.login : Routes.language),
    ),
  );
}

class MyApp extends StatelessWidget {

  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Chef App',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.createRouter(initialRoute),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}

