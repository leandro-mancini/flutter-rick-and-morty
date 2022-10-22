import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  static void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  static Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  static void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  static Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  static void setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }
}

// import 'dart:convert';

// import 'package:flutter_api/flutter_api.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPref {
//   read(String key) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();

//     Map<String, dynamic> json = prefs.getString(key);
//     var user = Character.fromJson(json);

//     // Map json = jsonDecode(prefs.getString(key));

//     print(user);

//     // jsonDecode(prefs.getString(key))

//     // json.decode();

//     return prefs.getString(key);
//   }

//   save(String key, value) async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
    
//     prefs.setString(key, json.encode(value));  
//   }

//   remove(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove(key);
//   }
// }