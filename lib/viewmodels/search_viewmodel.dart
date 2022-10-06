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
      String? zipCode,
      String? vetName,
      String? clinicName,
      String? specialty,
      String? address,
      String? country,
      String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      searchResult = await searchService.search(city, zipCode, vetName,
          clinicName, specialty, address, country, token);
      loading = false;
      notifyListeners();
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
      rethrow;
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<Veterinaire?> getVet(
      String? vetId, String? userId, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      Veterinaire? vet = await searchService.getVet(vetId, userId, token);

      loading = false;
      notifyListeners();
      return vet;
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
      rethrow;
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<Veterinaire>?> getClinicVets(
      String? clinicId, String? userId, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      List<Veterinaire>? vets =
          await searchService.getClinicVet(clinicId, userId, token);

      loading = false;
      notifyListeners();
      return vets;
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
      rethrow;
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }

  Future<List<String>?> getAvailableAppointments(
      String? vetId, String? userId, String? date, String? token) async {
    try {
      final SearchService searchService = SearchService();
      loading = true;
      notifyListeners();
      List<String> vet = await searchService.getAvailableAppointments(
          vetId, userId, date, token);

      loading = false;
      notifyListeners();
      return vet;
    } on Failure catch (f) {
      loading = false;
      errorMessage = f.message;
      notifyListeners();
      rethrow;
    } catch (e) {
      loading = false;
      notifyListeners();
      rethrow;
    }
  }
}
