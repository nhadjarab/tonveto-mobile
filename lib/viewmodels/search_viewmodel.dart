import 'package:flutter/material.dart';

import '../models/failure_model.dart';
import '../models/search_model.dart';
import '../services/search_service.dart';


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
