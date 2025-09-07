import 'dart:async';
import 'package:chef_app/app/localization/app_localization.dart';
import 'package:chef_app/app/localization/language_service.dart';
import 'package:chef_app/app/router/routes.dart';
import 'package:chef_app/core/constants/app_assets.dart';
import 'package:chef_app/core/constants/app_strings.dart';
import 'package:chef_app/core/di/injection.dart';
import 'package:flutter/material.dart';
import 'package:chef_app/app/router/app_router.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:app_links/app_links.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  setupDependencies();

  await AppLocalization.initEasyLocalization();
  final initialLocale = await LanguageService.getSavedLocale();
  final hasLanguage = await LanguageService.isLanguageSelected();

  runApp(
    EasyLocalization(
      supportedLocales: [const Locale('en'), const Locale('ar')],
      path: AppAssets.assetsTranslation,
      fallbackLocale: const Locale('en'),
      startLocale: initialLocale,
      child: MyApp(initialRoute: hasLanguage ? Routes.login : Routes.language),
    ),
  );
}

class MyApp extends StatefulWidget {

  final String initialRoute;
  const MyApp({super.key, required this.initialRoute});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  StreamSubscription? _sub;
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();

    _router = AppRouter.createRouter(widget.initialRoute);

    _appLinks = AppLinks();

    _sub = _appLinks.uriLinkStream.listen((Uri uri) {
      debugPrint('Full URI: $uri');

      if (uri.scheme == 'myapp' && uri.host == 'reset-password') {
        final code = uri.queryParameters['code'];
        if (code != null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _router.go('/reset-password?code=$code');
          });
        }
      }
    }, onError: (err) {
      debugPrint('Deep link error: $err');
    });

    _handleInitialLink();
  }

  // Handle the case when app is launched from a deep link
  Future<void> _handleInitialLink() async {
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        if (initialLink.scheme == 'myapp' && initialLink.host == 'reset-password') {
          final code = initialLink.queryParameters['code'];
          if (code != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _router.go('${Routes.resetPassword}?code=$code');
            });
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _router.go(Routes.login);
            });
          }
        }
      }
    } catch (err) {
      debugPrint('Failed to get initial link: $err');
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      key: ValueKey(context.locale.languageCode),
      title: AppStrings.chefApp.tr(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
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

