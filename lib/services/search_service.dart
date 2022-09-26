import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/vet_model.dart';

import '../config/consts.dart';
import '../models/failure_model.dart';
import '../models/search_model.dart';

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
        url = url + "specialty=$specialty&";
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

  Future<Veterinaire> getVet(
      String? vetId, String? user_id, String? token) async {
    try {
      String url = "$BASE_URL/vet/$vetId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "logged_in_id": user_id!,
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200) {
        print(Veterinaire.fromJson(result['vetProfile']).id);
        return Veterinaire.fromJson(result['vetProfile']);
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

  Future<List<String>> getAvailableAppointments(
      String? vetId, String? user_id, String? date, String? token) async {
    try {
      String url = "$BASE_URL/vetAvailableAppointments/$vetId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "logged_in_id": user_id!,
          "date": date!,
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<String>.from(result?.map((x) => x) ?? []);
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

  Future<bool> addAppointment(
    String? date,
    String? time,
    String? pet_id,
    String? vet_id,
    String? user_id,
    String? clinic_id,
    String? token,
  ) async {
    try {
      print(date);
      final response = await http.post(Uri.parse("$BASE_URL/appointment"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "date": date,
            "time": time,
            "pet_id": pet_id,
            "vet_id": vet_id,
            "user_id": user_id,
            "clinic_id": clinic_id,
          }));
      final result = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      print(e);
      throw Failure();
    }
  }

  Future<bool> updateAppointment(
    Appointment? appointment,
    String? token,
  ) async {
    try {
      print(appointment?.id);
      print(DateFormat('yyyy-MM-dd')
          .format(appointment?.date ?? DateTime.now()));
      print(appointment?.time);
      print(appointment?.petId);
      print(appointment?.vetId);
      print(appointment?.userId);
      print(appointment?.clinicId);
      final response =
          await http.put(Uri.parse("$BASE_URL/appointment/${appointment?.id}"),
              headers: {
                "Content-Type": "application/json",
                'Authorization': 'Bearer $token',
              },
              body: json.encode({
                "date": DateFormat('yyyy-MM-dd')
                    .format(appointment?.date ?? DateTime.now()),
                "time": appointment?.time,
                "pet_id": appointment?.petId,
                "vet_id": appointment?.vetId,
                "user_id": appointment?.userId,
                "clinic_id": appointment?.clinicId,
              }));
      final result = json.decode(response.body);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      print(e);
      throw Failure();
    }
  }

  Future cancelAppointment(
    String? appointment_id,
    String? user_id,
    String? token,
  ) async {
    try {
      final response = await http.delete(
        Uri.parse("$BASE_URL/appointment/$appointment_id"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          'user_id': user_id!,
        },
      );
      final result = json.decode(response.body);
      print(response.body);
    } on Failure {
      rethrow;
    } catch (e) {
      print(e);
      throw Failure();
    }
  }
}
