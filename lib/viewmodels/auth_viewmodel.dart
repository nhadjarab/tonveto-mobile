import 'package:flutter/material.dart';
import 'package:vet/models/failure_model.dart';
import 'package:vet/models/user_model.dart';
import 'package:vet/services/auth_service.dart';
import 'package:vet/services/localstorage_service.dart';

class AuthViewModel with ChangeNotifier {
  bool loading = false;

  bool isAuth = false;
  String? token;
  User? user;

  String? errorMessage;
  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  Future<void> login(String? email, String? password) async {
    final AuthService authService = AuthService();

    loading = true;
    notifyListeners();

    try {
      final data = await authService.login(email, password);

      user = data["userProfile"];
      token = data["jwtToken"];
      isAuth = true;

      loading = false;

      // save to localstorage
      final LocalStorageService localStorageService = LocalStorageService();
      localStorageService.saveUser(token, user?.id);
      notifyListeners();
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
    } catch (e) {
      loading = false;
      print(e);
      notifyListeners();
    }
  }

  Future<bool> register(String? email, String? password) async {
    final AuthService authService = AuthService();

    loading = true;
    notifyListeners();

    try {
      await authService.register(email, password);
      loading = false;
      notifyListeners();
      return true;
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
    } catch (e) {
      loading = false;
      print(e);
      notifyListeners();
    }
    return false;
  }

  Future<bool> registerInfo(String? firstName, String? lastName, String? phone,
      DateTime? birthday, String? email, String? password) async {
    final AuthService authService = AuthService();
    try {
      loading = true;
      notifyListeners();
      // register user info
      await authService.registerInfo(
          firstName, lastName, phone, birthday, email, password);
      // login the current user with the email and password
      await login(email, password);
      return true;
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
      return false;
    } catch (e) {
      loading = false;
      print(e);
      notifyListeners();
      return false;
    }
  }

  Future<bool> tryAutoLogin() async {
    final userData = await LocalStorageService.getUser();

    if (userData == null) {
      isAuth = false;
      token = null;
      return false;
    } else {
      isAuth = true;
      token = userData["token"];
      return true;
    }
  }

  Future<void> logout() async {
    isAuth = false;
    user = null;
    token = null;
    await LocalStorageService.clearLocalStorage();
    notifyListeners();
  }
}
