import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class OrderController extends GetxController{

  final RxList<dynamic> orderList = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  final supabase = Supabase.instance.client;

  Future<void> fetchOrders() async {
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

  Future<void> addOrders(
      String serviceName,
      String providerName,
      String userName,
      String amount,
      String payAmount,
      String trxId,
      String duration,
      String startDate,
      String endDate,
      ) async {
    try {
      isLoading.value = true;

      await supabase.from('orders').insert({
        'service': serviceName,
        'provider_name': providerName,
        'username': userName,
        'amount': amount,
        'pay_amount': payAmount,
        'trx_id': trxId,
        'duration': duration,
        'start_date': startDate,
        'end_date': endDate,
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

  Future<void> deleteOrder(int id) async {
    try {
      isLoading.value = true;

      await supabase.from('orders').delete().match({'id': id});

      orderList.removeWhere((order) => order['id'] == id);

      Get.snackbar(
        'Success',
        'Order deleted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to delete order',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchOrders(); // ✅ fetch from Supabase
    super.onInit();
  }
}