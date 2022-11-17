import 'package:shared_preferences/shared_preferences.dart';

abstract class ISharedPref {
  Future<bool> getBool(String key);
  Future<int> getInt(String key);
  Future<String> getString(String key);

  void setBool(String key, bool b);
  void setInt(String key, int i);
  void setString(String key, String s);
}

class SharedPref implements ISharedPref {
  @override
  Future<bool> getBool(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getBool(key) ?? false;
  }

  @override
  Future<int> getInt(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getInt(key) ?? 0;
  }

  @override
  Future<String> getString(String key) async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(key) ?? "";
  }

  @override
  void setBool(String key, bool b) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setBool(key, b);
  }

  @override
  void setInt(String key, int i) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setInt(key, i);
  }

  @override
  void setString(String key, String s) async {
    var prefs = await SharedPreferences.getInstance();

    prefs.setString(key, s);
  }

}