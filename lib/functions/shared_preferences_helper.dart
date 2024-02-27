import 'dart:convert';

import 'package:divent/functions/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  static const String _userKey = 'user';

  static Future<void> saveBool(String key, bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> saveUser(ObjUser userObj, String name) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(name, jsonEncode(userObj.toJson()));
  }

  static Future<ObjUser?> getUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userString = prefs.getString('userData');
    return userString != null ? ObjUser.fromJson(jsonDecode(userString)) : null;
  }

  static Future<void> removeUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
  }
}
