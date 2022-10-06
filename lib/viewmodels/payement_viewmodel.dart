
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../config/consts.dart';
import '../models/failure_model.dart';

class PayementViewModel extends ChangeNotifier  {
Map<String, dynamic>? paymentIntentData;

String? payementId;

Future<bool> makePayment(
    {required String amount, required String currency}) async {
  try {
    paymentIntentData = await createPaymentIntent(amount, currency);
    if (paymentIntentData != null) {
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            googlePay: const  PaymentSheetGooglePay(
              merchantCountryCode: 'US',
              testEnv: true,
            ),
            merchantDisplayName: 'Prospects',
            customerId: paymentIntentData!['customer'],
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
          ));
      bool res = await displayPaymentSheet();
      payementId = paymentIntentData!['id'];
      notifyListeners();
      return res;
    }
    return false;
  } catch (e) {
    rethrow;
  }
}

Future<bool> displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    return true;
 /*   Get.snackbar('Payment', 'Payment Successful',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 2));*/
  } on Exception catch (e) {
    if (e is StripeException) {
    } else {
    }
    return false;
  } catch (e) {
    return false;
  }
}

//  Future<Map<String, dynamic>>
createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card'
    };
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer $stripeSecretKey',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    return jsonDecode(response.body);
  } catch (err) {
  }
}

calculateAmount(String amount) {
  final a = (int.parse(amount)) * 100;
  return a.toString();
}

  Future<bool> addPayement(
      String? amount,
      String? vetId,
      String? appointmentId,
      String? userId,

      String? token,
      ) async {
    try {
      final response = await http.post(Uri.parse("$baseUrl/payment"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "amount": amount,
            "vet_id": vetId,
            "appointment_id": appointmentId,
            "user_id": userId,
            "payment_id": payementId,
          }));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } on Failure {
      rethrow;
    } catch (e) {
      throw Failure();
    }
  }
}