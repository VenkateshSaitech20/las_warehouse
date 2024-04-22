// ignore_for_file: file_names

import 'dart:convert';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const isLogin = "isLogin"; //true
  static const user = "userData"; //user datas (here only message)
  static const accesstoken = "accesstoken"; //token
  static const isFinishOnBoardingKey = "isFinishOnBoardingKey";
  static const languageCodeKey = "languageCodeKey";
  static const userId = "userId";
  static const paymentSetting = "paymentSetting";
  static const currency = "currency";
  static const admincommission = "adminCommission";
  static late SharedPreferences pref;

  static initPref() async {
    pref = await SharedPreferences.getInstance();
  }

  static bool getBoolean(String key) {
    return
        //  true;

        pref.getBool(key) ?? false;
  }

  static Future<void> setBoolean(String key, bool value) async {
    await pref.setBool(key, value);
  }

  static Future<String> getString(String key) async {
    return pref.getString(key) ?? "";
  }

  static Future<void> setString(String key, String value) async {
    await pref.setString(key, value);
  }

  static int getInt(String key) {
    return pref.getInt(key) ?? 0;
  }

  static Future<void> setInt(String key, int value) async {
    await pref.setInt(key, value);
  }

  static Future<void> clearSharPreference() async {
    await pref.clear();
  }

  static Future<void> clearKeyData(String key) async {
    await pref.remove(key);
  }

//End of inbuilt functions.
//json.encode()     json to String
//json.decode()     String to json

  static read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return json.decode(prefs.getString(key)!);
  }

  static save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(value));
  }

  static remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }

  static loadSharedPrefs() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (prefs.containsKey('userdata')) {
        User user = User.fromJson(await Preferences.read("userdata"));
        if (user.id == null) return null;

        return user;
      } else {
        // _navigationService.navigateTo(routes.MobileRegRoute);
      }
    } catch (Excepetion) {}
  }
}
