import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static late SharedPreferences prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static const String _cachedLanguageCode = "cachedLanguageCode";

  static String getCachedLanguageCode() {
    final code = prefs.getString(_cachedLanguageCode);
    if (code != null) {
      return code;
    } else {
      return 'en';
    }
  }

  static Future<void> cacheLanguageCode(String code) async {
    await prefs.setString(_cachedLanguageCode, code);
  }
}
