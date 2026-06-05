import 'dart:async';
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
import 'package:sentry_flutter/sentry_flutter.dart';
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

  await EasyLocalization.ensureInitialized();
  final languageService = getIt<LanguageService>();
  final initialLocale = await languageService.getSavedLocale();
  final hasLanguage = await languageService.isLanguageSelected();

  await SentryFlutter.init(
    (options) {
      options.dsn = dotenv.env['SENTRY_DSN'];
      options.tracesSampleRate = .01;
      options.environment = 'production';
    },
    appRunner: () => runApp(
      EasyLocalization(
        supportedLocales: [const Locale('en'), const Locale('ar')],
        path: AppAssets.assetsTranslation,
        fallbackLocale: const Locale('en'),
        startLocale: initialLocale,
        child: MyApp(initialRoute: hasLanguage ? Routes.login : Routes.language),
      ),
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

  final _theme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );

  late final GoRouter _router;
  StreamSubscription? _streamSubscription;
  late final AppLinks _appLinks;

  @override
  void initState() {
    super.initState();

    _router = AppRouter.createRouter(widget.initialRoute);

    _appLinks = AppLinks();

    _streamSubscription = _appLinks.uriLinkStream.listen(
      (Uri uri) {
        debugPrint('Full URI: $uri');

        if (uri.scheme == 'myapp' && uri.host == 'reset-password') {
          final code = uri.queryParameters['code'];
          if (code != null) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _router.go('/reset-password?code=$code');
            });
          }
        }
      },
      onError: (err) {
        debugPrint('Deep link error: $err');
      },
    );

    _handleInitialLink();
  }

  // Handle the case when app is launched from a deep link
  Future<void> _handleInitialLink() async {
    try {
      final Uri? initialLink = await _appLinks.getInitialLink();
      if (initialLink != null) {
        if (initialLink.scheme == 'myapp' &&
            initialLink.host == 'reset-password') {
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
    _streamSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: AppStrings.chefApp.tr(),
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: _theme,
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
    );
  }
}
