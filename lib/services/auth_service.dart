import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/consts.dart';
import '../models/failure_model.dart';
import '../models/user_model.dart';

class AuthService {
  Future login(String? email, String? password) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/login"),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            "email": email,
            "password": password,
          }));
      final result = json.decode(response.body);
      print(result);
      if (response.statusCode == 200) {
        Map<String, dynamic> userInfo = {
          "userProfile": User.fromJson(result["userProfile"]),
          "jwtToken": result["jwtToken"]
        };

        return userInfo;
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      print(e.toString());
      throw Failure();
    }
  }

  Future<bool> register(String? email, String? password) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/register"),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({
            "email": email,
            "password": password,
          }));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future<String?> registerInfo(
    String? firstName,
    String? lastName,
    String? phone,
    DateTime? birthday,
    String? email,
    String? password,
    bool? isSubscribed,
  ) async {
    String? token;
    User? user;
    try {
      final data = await login(email, password);
      user = data["userProfile"];
      token = data["jwtToken"];
    } catch (e) {

    }
    try {
      final response = await http.put(Uri.parse("$baseUrl/user/${user?.id}"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "birth_date": birthday.toString(),
            "phone_number": phone,
            "is_subscribed": isSubscribed
          }));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return user?.id;
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future<User?> getUserData(String? userID, String? token) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/user/$userID"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "logged_in_id": "$userID"
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return User.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future updateUserData(
      String? userID,
      String? token,
      String? firstName,
      String? lastName,
      String? phone,
      DateTime? birthday,
      String? email) async {
    try {
      final response = await http.put(Uri.parse("$baseUrl/user/$userID"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "first_name": firstName,
            "last_name": lastName,
            "email": email,
            "birth_date": birthday.toString(),
            "phone_number": phone,
            "is_subscribed": true
          }));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Failure.createFailure(response.statusCode, result.toString());
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }
}
