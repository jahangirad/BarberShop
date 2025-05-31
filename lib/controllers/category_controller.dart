import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CategoryController extends GetxController {
  final supabase = Supabase.instance.client;

  var serviceList = <Map<String, dynamic>>[].obs; // ✅ eta add korte hobe
  var isLoading = false.obs;

  Future<void> fetchServicesByCategory(String category) async {
    try {
      isLoading.value = true;
      final response = await supabase
          .from('service')
          .select()
          .eq('ser_name', category);

      serviceList.value = List<Map<String, dynamic>>.from(response);
    } catch (e) {
      print('Fetch error: $e');
      serviceList.clear();
    } finally {
      isLoading.value = false;
    }
  }
}

