import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppLocalization {
  static Future<void> initEasyLocalization() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}

