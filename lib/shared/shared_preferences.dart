import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  static SharedPreferences? sharedPreferences;
  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> setData({
    required String key,
    required dynamic value,
  }) async {
    if (key is double) {
      return await sharedPreferences!.setDouble(key, value);
    }
    if (key is int) {
      return await sharedPreferences!.setInt(key, value);
    }
    if (key is String) {
      return await sharedPreferences!.setString(key, value);
    } else {
      return await sharedPreferences!.setBool(key, value);
    }
  }

  static dynamic getData({
    required String key,
  }) {
    return sharedPreferences!.get(key);
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences!.remove(key);
  }
}
