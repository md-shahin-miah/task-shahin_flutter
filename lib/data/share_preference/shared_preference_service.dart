import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../common/constants/app_constant.dart';



class SharePreferenceUtil {
  static late SharedPreferences prefs;
  static final Map<String, dynamic> _memoryPrefs = <String, dynamic>{};

  static Future<SharedPreferences> init() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static void setString(String key, String value) {
    prefs.setString(key, value);
    _memoryPrefs[key] = value;
  }

  static void setInt(String key, int value) {
    prefs.setInt(key, value);
    _memoryPrefs[key] = value;
  }

  static void setDouble(String key, double value) {
    prefs.setDouble(key, value);
    _memoryPrefs[key] = value;
  }

  static void setBool(String key, bool value) {
    prefs.setBool(key, value);
    _memoryPrefs[key] = value;
  }

  static String getString(String key, {required String def}) {
    String? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= prefs.getString(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static int getInt(String key, {required int def}) {
    int? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= prefs.getInt(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static double getDouble(String key, {required double def}) {
    double? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= prefs.getDouble(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static bool getBool(String key, {bool def = false}) {
    bool? val;
    if (_memoryPrefs.containsKey(key)) {
      val = _memoryPrefs[key];
    }
    val ??= prefs.getBool(key);
    val ??= def;
    _memoryPrefs[key] = val;
    return val;
  }

  static getUserToken() {
    return getString(AppConstant.userToken, def: "");
  }

  static void setUserToken(String value) {
    setString(AppConstant.userToken, value);
  }
  static isRememberMe() {
    return getBool(AppConstant.remember, def: false);
  }

  static void setRememberMe(bool value) {
    setBool(AppConstant.remember, value);
  }



}
