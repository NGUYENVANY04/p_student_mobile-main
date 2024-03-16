import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static const _userIdKey = 'uid';

  //Get uid
  static Future<String?> getUid() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(_userIdKey);
    } catch (e) {
      return null;
    }
  }

  //Set uid
  static Future<void> setUid(String uid) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey,uid);
  }

  
}
