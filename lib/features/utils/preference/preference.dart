import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static final Pref singleton = Pref._internal();
  static SharedPreferences? sharedPref;

  factory Pref() {
    return singleton;
  }

  Pref._internal() {
    SharedPreferences.getInstance().then((pref) => sharedPref = pref);
  }

  // get string
  static String getString(String key, {String defValue = ''}) {
    return sharedPref!.getString(key) ?? defValue;
  }

  // put string
  static Future<bool> putString(String key, String value) {
    return sharedPref!.setString(key, value);
  }

  static Future<bool> putInt(String key, int? value) {
    return sharedPref!.setInt(key, value!);
  }

  // get bool
  static bool getBool(String key, {bool defValue = false}) {
    return sharedPref!.getBool(key) ?? defValue;
  }

  // put bool
  static Future<bool> putBool(String key, bool value) {
    return sharedPref!.setBool(key, value);
  }

  // get int
  static int getInt(String key, {int defValue = 0}) {
    return sharedPref!.getInt(key) ?? defValue;
  }

  // put int.
  // static Future<bool> putInt(String key, int value) {
  //   return sharedPref!.setInt(key, value);
  // }

  // get double
  static double getDouble(String key, {double defValue = 0.0}) {
    return sharedPref!.getDouble(key) ?? defValue;
  }

  // put double
  static Future<bool> putDouble(String key, double value) {
    return sharedPref!.setDouble(key, value);
  }

  // get string list
  static List<String> getStringList(
    String key, {
    List<String> defValue = const [],
  }) {
    return sharedPref!.getStringList(key) ?? defValue;
  }

  // put string list
  static Future<bool> putStringList(String key, List<String> value) {
    return sharedPref!.setStringList(key, value);
  }

  // have key
  static bool haveKey(String key) {
    return sharedPref!.getKeys().contains(key);
  }

  // get keys
  static Set<String> getKeys() {
    return sharedPref!.getKeys();
  }

  // remove
  static Future<bool> remove(String key) {
    return sharedPref!.remove(key);
  }

  // clear
  static Future<bool> clear() {
    return sharedPref!.clear();
  }
}
