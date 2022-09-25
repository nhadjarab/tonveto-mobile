import 'dart:convert';

import 'package:http/http.dart' as http;

import '../config/consts.dart';

class ChatbotService {
  Future getSymptoms(String species) async {
    try {
      final response = await http.get(
        Uri.parse("$AI_URL/symptoms/$species"),
        headers: {
          "Content-Type": "application/json",
        },
      );
      final result = json.decode(response.body);
      print(result["result"]);
      return result["result"];
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future predictDisease(String species, List symptoms) async {
    try {
      final response = await http.post(Uri.parse("$AI_URL/predict"),
          headers: {
            "Content-Type": "application/json",
          },
          body: json.encode({"species": species, "symptoms": symptoms}));
      final result = json.decode(response.body);
      print(result["result"]);
      return result["result"];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
