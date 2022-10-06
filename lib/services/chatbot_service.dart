import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/consts.dart';

class ChatbotService {
  Future getSymptoms(String species) async {
    try {
      final response = await http.get(
        Uri.parse("$aiUrl/symptoms/$species"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final result = json.decode(response.body);
      return result["result"];
    } catch (e) {
      rethrow;

    }
  }

  Future predictDisease(String species, List symptoms) async {
    try {
      final response = await http.post(Uri.parse("$aiUrl/predict"),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"species": species, "symptoms": symptoms}));
      final result = json.decode(response.body);
      return result["result"];
    } catch (e) {
      rethrow;

    }
  }
}
