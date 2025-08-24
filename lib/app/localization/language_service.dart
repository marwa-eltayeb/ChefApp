import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chef_app/core/constants/app_constants.dart';

class LanguageService {

  static Future<void> saveLanguageCode(String code) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(AppConstants.langKey, code);
    await prefs.setBool(AppConstants.isLanguageSelectedKey, true);
  }

  static Future<Locale> getSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(AppConstants.langKey) ?? 'en';
    return Locale(code);
  }

  static Future<bool> isLanguageSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(AppConstants.isLanguageSelectedKey) ?? false;
  }
}
