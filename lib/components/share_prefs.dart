import "package:shared_preferences/shared_preferences.dart";

class SharePrefs {
  static void storePrefs(String key, dynamic value, String type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (type == "int") {
      await sp.setInt(key, value);
    } else if (type == "string") {
      await sp.setString(key, value);
    } else if (type == "bool") {
      await sp.setBool(key, value);
    }
  }

  static dynamic readPrefs(String key, String type) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    dynamic value;
    if (type == "int") {
      value = await sp.getInt(key);
    } else if (type == "string") {
      value = await sp.getString(key);
    } else if (type == "bool") {
      value = await sp.getBool(key);
    }

    return value;
  }

  static Future<bool> clearPrefs() async{
     SharedPreferences sp = await SharedPreferences.getInstance();
     bool isclear = await sp.clear();
    return isclear;
  }
}
