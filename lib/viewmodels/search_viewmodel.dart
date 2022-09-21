import 'package:flutter/material.dart';
import 'package:vet/models/failure_model.dart';
import 'package:vet/models/search_model.dart';
import 'package:vet/models/user_model.dart';
import 'package:vet/services/auth_service.dart';
import 'package:vet/services/localstorage_service.dart';
import 'package:vet/services/search_service.dart';

class SearchViewModel with ChangeNotifier {
  bool loading = false;

  SearchModel? searchResult;

  String? errorMessage;

  void clearError() {
    errorMessage = null;
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
}
