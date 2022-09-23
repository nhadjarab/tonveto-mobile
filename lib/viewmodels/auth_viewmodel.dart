import 'package:flutter/material.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/pet_model.dart';
import 'package:tonveto/services/pet_service.dart';

import '../models/failure_model.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../services/localstorage_service.dart';

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

  Future getUserData() async {
    try {
      final AuthService authService = AuthService();
      loading = true;
      notifyListeners();
      final userData = await authService.getUserData(user?.id, token);
      user = userData;
      loading = false;
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

  Future updateUserData(String? firstName, String? lastName, String? phone,
      DateTime? birthday, String? email) async {
    final AuthService authService = AuthService();
    try {
      loading = true;
      notifyListeners();
      // register user info
      await authService.updateUserData(
          user?.id, token, firstName, lastName, phone, birthday, email);
      loading = false;

      user?.last_name = lastName;
      user?.first_name = firstName;
      user?.phone_number = phone;
      user?.birth_date = birthday;
      user?.email = email;

      notifyListeners();
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
      notifyListeners();

      return false;
    } else {
      isAuth = true;
      token = userData["token"];
      user = User(id: userData["user"]);
      notifyListeners();

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

  // pets manipulation -----------------------------------------
  Future<bool> addPet(Pet? pet) async {
    try {
      final PetService petService = PetService();
      pet!.ownerId = user!.id;

      loading = true;
      notifyListeners();

      final newPet = await petService.addPet(pet, token);
      user?.addPet(newPet!);

      loading = false;
      notifyListeners();
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

  Future<bool> editPet(Pet? pet) async {
    try {
      final PetService petService = PetService();
      pet!.ownerId = user!.id;

      loading = true;
      notifyListeners();

      final updatedPet = await petService.updatePet(pet, token);
      int index =
          user?.pets?.indexWhere((pet) => pet.id == updatedPet.id) ?? -1;
      if (index == -1) {
        loading = false;
        notifyListeners();
        return false;
      }

      user?.pets?[index] = updatedPet;
      loading = false;
      notifyListeners();
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

  Future<bool> deletePet(String? petID) async {
    try {
      final PetService petService = PetService();
      loading = true;
      notifyListeners();

      await petService.deletePet(user?.id, petID, token);
      user?.pets?.removeWhere((pet) => pet.id == petID);
      loading = false;
      notifyListeners();
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

  Future getPetAppointments(String? petID) async {
    try {
      final PetService petService = PetService();
      loading = true;
      notifyListeners();

      int? petIndex = user?.pets?.indexWhere((pet) => pet.id == petID);
      if (petIndex != null && petIndex != -1) {
        user?.pets?[petIndex].clearAppointments();
      }

      List<Appointment> appointments =
          await petService.getPetAppointments(petID, token, user?.id);
      print(appointments.length);

      if (petIndex != null && petIndex != -1) {
        user?.pets?[petIndex].addAppointments(appointments);
      }
      loading = false;
      notifyListeners();
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
}
