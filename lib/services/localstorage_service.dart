import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  /// Save user info in the localstorage of the device
  /// @param token      auth token
  /// @param user     represent the user
  /// returns true if saved else false
  Future<bool> saveUser(String? token, String? userId) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final body = {
        "token": token,
        "user": userId,
      };
      await prefs.setString(
        "vet_user",
        json.encode(body),
      );
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  /// Get user info from the localstorage
  /// return User data from localstorage else null
  static Future<Map<String, dynamic>?> getUser() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      final userAsString = prefs.getString("vet_user");
      if (userAsString == null) return null;
      final userData = json.decode(userAsString);
      return userData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  static clearLocalStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
