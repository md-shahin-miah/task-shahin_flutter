import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constants/app_constant.dart';


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
  //
  // static getUserId() {
  //   return getString(AppConstant.userId, def: "");
  // }
  //
  // static void setUserId(String value) {
  //   setString(AppConstant.userId, value);
  // }
  //
  // static getCategoryId() {
  //   return getString(AppConstant.selectedCategoryId, def: "");
  // }
  //
  // static void setCategoryId(String value) {
  //   setString(AppConstant.selectedCategoryId, value);
  // }
  //
  // static isUserLoggedIn() {
  //   return getBool(AppConstant.loginKey, def: false);
  // }
  //
  // static void setIsUserLoggedIn(bool value) {
  //   setBool(AppConstant.loginKey, value);
  // }
  //
  // static isOnBoardingScreenDone() {
  //   return getBool(AppConstant.isOnBoarding, def: false);
  // }
  //
  // static void setOnBoardingScreenDone(bool value) {
  //   setBool(AppConstant.isOnBoarding, value);
  // }
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  //
  // // save device token in shared preference
  // static void saveDeviceToken(String? deviceToken) {
  //   setString("deviceToken", deviceToken??"");
  // }
  //
  // // get device token from shared preference
  // static String getDeviceToken() {
  //   return getString("deviceToken", def: "");
  // }


}
