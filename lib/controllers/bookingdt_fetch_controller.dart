import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'auth_fetch_controller.dart';

class BookingDateTime extends GetxController {
  final UserService userService = Get.put(UserService());
  RxList<Map<String, DateTime>> bookingSlots = <Map<String, DateTime>>[].obs;
  RxBool isLoading = false.obs;

  Future<void> getBookingData() async {
    try {
      isLoading.value = true;

      final response = await Supabase.instance.client
          .from('bookingdt')
          .select()
          .eq('userid', userService.userData['uid']);

      bookingSlots.clear();

      for (var booking in response) {
        final start = DateTime.parse(booking['start']);
        final end = DateTime.parse(booking['end']);
        bookingSlots.add({'start': start, 'end': end});
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to load booking data: $e");
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    getBookingData();
    super.onInit();
  }
}
