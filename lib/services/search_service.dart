import 'dart:convert';

import 'package:flutter/material.dart';
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
      String? zipCode,
      String? vetName,
      String? clinicName,
      String? specialty,
      String? address,
      String? country,
      String? token) async {
    try {
      String url = "$baseUrl/advancedSearch?";
      if (city != '') {
        url = "${url}city=$city&";
      }
      if (zipCode != '') {
        url = "${url}zip_code=$zipCode&";
      }
      if (vetName != '') {
        url = "${url}vet_name=$vetName&";
      }
      if (clinicName != '') {
        url = "${url}clinic_name=$clinicName&";
      }
      if (specialty != '') {
        url = "${url}specialty=$specialty&";
      }
      if (address != '') {
        url = "${url}address=$address&";
      }
      if (country != '') {
        url = "${url}country=$country";
      }
      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return SearchModel.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      print(e.toString());
    rethrow;
    }
  }

  Future<Veterinaire?> getVet(
      String? vetId, String? userId, String? token) async {
    try {
      String url = "$baseUrl/vet/$vetId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "logged_in_id": userId!,
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      debugPrint(response.body);

      if (response.statusCode == 200) {
        return Veterinaire.fromJson(result['vetProfile']);
      } else {
       // throw Failure.createFailure(response.statusCode, result);
      }
      return null;
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Veterinaire>> getClinicVet(
      String? clinicId, String? userId, String? token) async {
    try {
      String url = "$baseUrl/clinic/$clinicId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "logged_in_id": userId!,
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<Veterinaire>.from(result['clinic']['vets']
                ?.map((record) => Veterinaire.fromJson(record['vet'])) ??
            []);
      } else {
       // throw Failure.createFailure(response.statusCode, result);
      }
      return [];
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<String>> getAvailableAppointments(
      String? vetId, String? userId, String? date, String? token) async {
    try {
      String url = "$baseUrl/vetAvailableAppointments/$vetId";

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "logged_in_id": userId!,
          "date": date!,
          'Authorization': 'Bearer $token',
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return List<String>.from(result?.map((x) => x) ?? []);
      } else {
      //  throw Failure.createFailure(response.statusCode, result);
      }
      return [];
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> addAppointment(
    String? date,
    String? time,
    String? petId,
    String? vetId,
    String? userId,
    String? clinicId,
    String? token,
  ) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/appointment"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "date": date,
            "time": time,
            "pet_id": petId,
            "vet_id": vetId,
            "user_id": userId,
            "clinic_id": clinicId,
          }));
      final result = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return result['id'];
      }
      return null;
    } on Failure {
      rethrow;

    } catch (e) {
      rethrow;
    }
  }

  Future<bool> addVetComment(
    String? text,
    String? vetId,
    String? rating,
    String? userId,
    String? appointment_id,
    String? token,
  ) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/commentVet"),
          headers: {
            "Content-Type": "application/json",
            "logged_in_id": "$userId",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "text": text,
            "vet_id": vetId,
            "appointment_id": appointment_id,
            "rating": rating,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateAppointment(
    Appointment? appointment,
    String? token,
  ) async {
    try {

      final response =
          await http.put(Uri.parse("$baseUrl/appointment/${appointment?.id}"),
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
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }

  Future cancelAppointment(
    String? appointmentId,
    String? userId,
    String? token,
  ) async {
    try {
    await http.delete(
        Uri.parse("$baseUrl/appointment/$appointmentId"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          'user_id': userId!,
        },
      );
    } on Failure {
      rethrow;
    } catch (e) {
      rethrow;
    }
  }
}
