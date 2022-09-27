import 'package:flutter/material.dart';

import '../models/failure_model.dart';
import '../models/search_model.dart';
import '../models/vet_model.dart';
import '../services/search_service.dart';

class SearchViewModel with ChangeNotifier {
  bool loading = false;

  SearchModel? searchResult;
  double? rating;

  String? errorMessage;

  void clearError() {
    errorMessage = null;
    notifyListeners();
  }

  void setRating(double newRating) {
    rating = newRating;
    notifyListeners();
  }

  Future search(
      String? city,
      String? zip_code,
      String? vet_name,
      String? clinic_name,
      String? specialty,
      String? address,
      String? country,
      String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      searchResult = await searchService.search(city, zip_code, vet_name,
          clinic_name, specialty, address, country, token);
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

  Future<Veterinaire?> getVet(
      String? vetId, String? user_id, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      Veterinaire vet = await searchService.getVet(vetId, user_id, token);

      loading = false;
      notifyListeners();
      return vet;
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

  Future<List<Veterinaire>?> getClinicVets(
      String? clinicId, String? user_id, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      List<Veterinaire>? vets =
          await searchService.getClinicVet(clinicId, user_id, token);

      loading = false;
      notifyListeners();
      return vets;
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

  Future<List<String>?> getAvailableAppointments(
      String? vetId, String? user_id, String? date, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      List<String> vet = await searchService.getAvailableAppointments(
          vetId, user_id, date, token);

      loading = false;
      notifyListeners();
      return vet;
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
}
