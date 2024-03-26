import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  Prefs._internal();

  static late SharedPreferences _instance;

  static init() async {
    _instance = await SharedPreferences.getInstance();
  }

  static Future saveLanguage(String language) async {
    await _instance.setString('language', language);
  }

  static String loadLanguage() {
    return _instance.getString('language')!;
  }

  static Future saveDifficulty(String difficulty) async {
    await _instance.setString('difficulty', difficulty);
  }

  static String loadDifficulty() {
    return _instance.getString('difficulty') ?? 'easy';
  }

  static clear() {
    _instance.clear();
  }
}
