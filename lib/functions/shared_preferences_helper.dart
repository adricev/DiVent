import 'dart:convert';
import 'package:divent/functions/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
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
