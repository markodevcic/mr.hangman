import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._internal();

  static late SharedPreferences _instance;

  static initializePrefs() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future saveLanguage(String language) async {
    await _instance.setString('language', language);
  }

  static String loadLanguage() {
    return _instance.getString('language') ?? Platform.localeName;
  }

  static clear() {
    _instance.clear();
  }
}
