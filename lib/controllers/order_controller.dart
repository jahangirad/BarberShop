import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController extends GetxController{

  final RxList<dynamic> orderList = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final supabase = Supabase.instance.client;

  Future<void> fetchProvider() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('orders').select();
      orderList.assignAll(response);
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addProvider(
      TextEditingController name,
      TextEditingController phone,
      ) async {
    try {
      isLoading.value = true;

      final response = await supabase.from('orders').insert({
        'service': name.text,
        'provider_name': phone.text,
        'username': phone.text,
        'amount': phone.text,
        'pay_amount': phone.text,
        'total_amount': phone.text,
        'trx_id': phone.text,
        'duration': phone.text,
        'start_date': phone.text,
        'end_date': phone.text,
      });

      // ✅ সফলভাবে ইনসার্ট হলে টোস্ট দেখাও
      Get.snackbar(
        'Success',
        'Provider added successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      // ❌ এরর হলে টোস্ট দেখাও
      Get.snackbar(
        'Error',
        'Failed to add provider',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }
}