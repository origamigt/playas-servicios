import 'package:shared_preferences/shared_preferences.dart';

class PrefencesRPM {
  /*
        Method that returns the  value requeried, 'value' if not set
  */
  static Future<String> getValue(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(value) ?? 'value';
  }

  static getValueRpp(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(value) ?? 'value';
  }

  /*
       Method that saves the user language code
  */
  static Future<bool> saveValue(String code, String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setString(code, value);
  }

  /*
      DELETE ALL KEYS
   */

  static Future<bool> deleteAllKeys() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  static Future<bool> deleteKey(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
