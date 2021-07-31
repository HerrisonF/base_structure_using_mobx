import 'package:base_structure_using_mobx/app/data/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _PREFS_USER_KEY = "USER_KEY";

class PreferencesApiClient {

  Future<bool> saveUserPreferences(User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return await prefs.setString(_PREFS_USER_KEY, user.toJsonString());
    } catch (e) {
      print("ERROR SAVING USER PREF $e");
      return false;
    }
  }

  Future<User> getUserPreferences() async {
    User user = User();
    try{
      final prefs = await SharedPreferences.getInstance();
      if (prefs.getString(_PREFS_USER_KEY) != null) {
        user = user.fromJsonString(
          prefs.getString(_PREFS_USER_KEY).toString(),
        );
        return user;
      }
      return user;
    }catch(e){
      print("ERROR GETTING USER PREF $e");
      return user;
    }
  }
}