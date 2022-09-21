import 'dart:convert';

import 'package:vet/models/search_model.dart';
import 'package:http/http.dart' as http;

import '../config/consts.dart';
import '../models/failure_model.dart';

class SearchService {
  Future<SearchModel?> search(
      String? city,
      String? zip_code,
      String? vet_name,
      String? clinic_name,
      String? specialty,
      String? address,
      String? country,
      String? token) async {
    try {
      String url = "$BASE_URL/advancedSearch?";
      if (city != '') {
        url = url + "city=$city&";
      }
      if (zip_code != '') {
        url = url + "zip_code=$zip_code&";
      }
      if (vet_name != '') {
        url = url + "vet_name=$vet_name&";
      }
      if (clinic_name != '') {
        url = url + "clinic_name=$clinic_name&";
      }
      if (specialty != '') {
        url = url + "speciality=$specialty&";
      }
      if (address != '') {
        url = url + "address=$address&";
      }
      if (country != '') {
        url = url + "country=$country";
      }
      print(url);
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        return SearchModel.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      print(e);
      throw Failure();
    }
  }
}
