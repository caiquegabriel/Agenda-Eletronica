import 'package:shared_preferences/shared_preferences.dart';


class Local {

  setString(String key, String value) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(key, value); 
    } catch(e) {
      SharedPreferences.setMockInitialValues({});
    } 
  }

  Future<String> getString(String key) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      return prefs.getString(key) ?? "";
    } catch(e) {
      SharedPreferences.setMockInitialValues({});
      return "";
    }
  }
}