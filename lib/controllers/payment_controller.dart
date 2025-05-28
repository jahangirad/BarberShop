import 'dart:convert';
import 'dart:developer';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntent;
  final isProcessing = false.obs;

  // ✅ স্ট্যাটিক এমাউন্ট ও কারেন্সি
  final String _staticAmount = "5"; // ডলার
  final String _staticCurrency = "USD";

  // ✅ পেমেন্ট প্রসেস ফাংশন (স্ট্যাটিক এমাউন্ট ব্যবহার করে)
  Future<bool> makePayment() async {
    isProcessing.value = true;
    try {
      paymentIntent = await createPaymentIntent(_staticAmount, _staticCurrency);
      if (paymentIntent == null) {
        log("❌ PaymentIntent creation failed.");
        isProcessing.value = false;
        return false;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          customFlow: true,
          merchantDisplayName: 'Body By Doctor',
          paymentIntentClientSecret: paymentIntent!['client_secret'],
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'US',
            currencyCode: 'USD',
            testEnv: true,
          ),
        ),
      );

      final result = await displayPaymentSheet();
      isProcessing.value = false;
      return result;
    } catch (e) {
      log("❌ Error in makePayment: ${e.toString()}");
      isProcessing.value = false;
      return false;
    }
  }

  // ✅ Stripe PaymentIntent তৈরি করা (amount ও currency স্ট্যাটিকভাবে দেওয়া হচ্ছে)
  Future<Map<String, dynamic>?> createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'currency': currency,
        'amount': (double.parse(amount) * 100).toInt().toString(), // ✅ USD → cents
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ${dotenv.env['secret_key']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      log("❌ Error creating payment intent: ${e.toString()}");
      return null;
    }
  }

  // ✅ পেমেন্ট শিট দেখানো এবং পেমেন্ট কনফার্ম করা
  Future<bool> displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((_) async {
        await Stripe.instance.confirmPaymentSheetPayment();

        var paymentIntentData = await fetchPaymentIntentDetails(paymentIntent!['id']);

        log("✅ Transaction ID: ${paymentIntentData['id']}");
        log("💰 Amount Received: ${(paymentIntentData['amount_received'] / 100).toStringAsFixed(2)} USD");

        paymentIntent = paymentIntentData;
      });

      return true;
    } on StripeException catch (e) {
      log("❌ Stripe Error: ${e.toString()}");
      return false;
    } catch (e) {
      log("❌ Error: ${e.toString()}");
      return false;
    }
  }

  // ✅ পেমেন্টIntent বিস্তারিত আনা
  Future<Map<String, dynamic>> fetchPaymentIntentDetails(String paymentIntentId) async {
    try {
      var response = await http.get(
        Uri.parse('https://api.stripe.com/v1/payment_intents/$paymentIntentId'),
        headers: {
          'Authorization': 'Bearer ${dotenv.env['secret_key']}',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );

      return jsonDecode(response.body);
    } catch (e) {
      log("❌ Error fetching payment intent: ${e.toString()}");
      return {};
    }
  }
}
