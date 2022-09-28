import 'dart:convert';

import 'package:tonveto/models/appointment_model.dart';
import 'package:tonveto/models/clinique_model.dart';
import 'package:tonveto/models/pet_model.dart';

import 'package:http/http.dart' as http;

import '../config/consts.dart';
import '../models/failure_model.dart';

class PetService {
  Future<Pet?> addPet(Pet? pet, String? token) async {
    try {
      Map<String, dynamic>? body = pet?.toJson();

      final response = await http.post(Uri.parse("$baseUrl/pet"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode(body));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return Pet.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future updatePet(Pet? pet, String? token) async {
    try {
      Map<String, dynamic>? body = pet?.toJson();

      final response = await http.put(Uri.parse("$baseUrl/pet/${pet?.id}"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode(body));
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return Pet.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future deletePet(String? userID, String? petID, String? token) async {
    try {
      final response = await http.delete(
        Uri.parse("$baseUrl/pet/$petID"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "owner_id": "$userID"
        },
      );
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

  Future getPetAppointments(
      String? petID, String? token, String? userID) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/pet/$petID"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "logged_in_id": "$userID"
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        List<Appointment> appointments = [];
        for (Map<String, dynamic> appointment in result["appointments"]) {
          appointments.add(Appointment.fromJson(appointment));
        }
        return appointments;
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future getPet(String? petID, String? token, String? userID) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/pet/$petID"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "logged_in_id": "$userID"
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return Pet.fromJson(result);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }

  Future getClinic(String? clinicID, String? token, String? userID) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/clinic/$clinicID"),
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token',
          "logged_in_id": "$userID"
        },
      );
      final result = json.decode(response.body);
      if (response.statusCode == 200) {
        return Clinique.fromJson(result["clinic"]);
      } else {
        throw Failure.createFailure(response.statusCode, result);
      }
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }
}
