import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chef_app/core/constants/app_constants.dart';

class LanguageService {

  final SharedPreferences prefs;
  LanguageService(this.prefs);

  Future<void> saveLanguageCode(String code) async {
    await prefs.setString(AppConstants.langKey, code);
    await prefs.setBool(AppConstants.isLanguageSelectedKey, true);
  }

  Future<Locale> getSavedLocale() async {
    final code = prefs.getString(AppConstants.langKey) ?? 'en';
    return Locale(code);
  }

  Future<bool> isLanguageSelected() async {
    return prefs.getBool(AppConstants.isLanguageSelectedKey) ?? false;
  }
}
