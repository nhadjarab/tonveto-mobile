
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

import '../config/consts.dart';
import '../models/failure_model.dart';

class PayementViewModel extends ChangeNotifier  {
Map<String, dynamic>? paymentIntentData;

String? payement_id;

Future<bool> makePayment(
    {required String amount, required String currency}) async {
  try {
    paymentIntentData = await createPaymentIntent(amount, currency);
    print(paymentIntentData);
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
      payement_id = paymentIntentData!['id'];
      notifyListeners();
      return res;
    }
    return false;
  } catch (e, s) {
    print('exception:$e$s');
    return false;
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
      print("Error from Stripe: ${e.error.localizedMessage}");
    } else {
      print("Unforeseen error: ${e}");
    }
    return false;
  } catch (e) {
    print("exception:$e");
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
          'Authorization': 'Bearer $STRIPE_SECRET_KEY',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    return jsonDecode(response.body);
  } catch (err) {
    print('err charging user: ${err.toString()}');
  }
}

calculateAmount(String amount) {
  final a = (int.parse(amount)) * 100;
  return a.toString();
}

  Future<bool> addPayement(
      String? amount,
      String? vet_id,
      String? appointment_id,
      String? user_id,

      String? token,
      ) async {
    try {
      final response = await http.post(Uri.parse("$BASE_URL/payment"),
          headers: {
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token',
          },
          body: json.encode({
            "amount": amount,
            "vet_id": vet_id,
            "appointment_id": appointment_id,
            "user_id": user_id,
            "payment_id": payement_id,
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
}