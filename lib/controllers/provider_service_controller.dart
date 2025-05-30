import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProviderServiceController extends GetxController {
  final RxList<dynamic> provider = <dynamic>[].obs;
  final RxList<dynamic> service = <dynamic>[].obs;
  final RxBool isLoading = false.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  final supabase = Supabase.instance.client;

  Future<void> fetchProvider() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('serviceprovider').select();
      provider.assignAll(response);
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

      final response = await supabase.from('serviceprovider').insert({
        'name': name.text,
        'phone': phone.text,
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

  Future<String?> uploadImage(File file) async {
    try {
      final fileExt = file.path.split('.').last;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}.$fileExt'; // অথবা Random নাম
      final filePath = 'userimages/$fileName';

      final bytes = await file.readAsBytes();

      await supabase.storage
          .from('userimages')
          .uploadBinary(filePath, bytes, fileOptions: const FileOptions(upsert: true));

      final publicURL = supabase.storage.from('userimages').getPublicUrl(filePath);
      return publicURL;
    } catch (e) {
      Get.snackbar('Error', 'Image upload failed: $e');
      return null;
    }
  }

  Future<void> addService({
    required String name,
    required String subtitle,
    required String rating,
    required String price,
    required String comparePrice,
    required String duration,
    required String providerUid,
    required File image,
  }) async {
    try {
      isLoading.value = true;
      final imageUrl = await uploadImage(image);
      if (imageUrl == null) return;

      await supabase.from('service').insert({
        'ser_name': name,
        'subtitle': subtitle,
        'rating': rating,
        'price': price,
        'com_price': comparePrice,
        'duration': duration,
        'providername': providerUid,
        'img': imageUrl,
      });

      Get.snackbar('Success', 'Service added successfully', backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar('Error', 'Failed to add service', backgroundColor: Colors.red, colorText: Colors.white);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      selectedImage.value = File(picked.path);
    }
  }

  Future<void> fetchService() async {
    try {
      isLoading.value = true;
      final response = await supabase.from('service').select();
      service.assignAll(response);
    } catch (e) {
      throw Exception(e);
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    fetchProvider();
    fetchService();
    super.onInit();
  }
}
