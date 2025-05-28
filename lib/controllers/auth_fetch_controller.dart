import 'package:barber_shop/utils/route.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// services/user_service.dart
class UserService extends GetxService {
  final userData = {}.obs;
  final String adminEmail = 'jahangirad14@gmail.com';

  Future<void> fetchCurrentUser() async {
    // ... (আগের fetchCurrentUser কোড) ...
    // নিশ্চিত করুন এটি currentUser null হলে বা প্রোফাইল না পেলে userData ক্লিয়ার করে
    try {
      final currentUser = Supabase.instance.client.auth.currentUser;
      if (currentUser != null) {
        userData.value = {'id': currentUser.id, 'email': currentUser.email};
        print('👤 Current user basic info: ${userData.value}');

        final response = await Supabase.instance.client
            .from('userprofile')
            .select()
            .eq('uid', currentUser.id)
            .maybeSingle(); // Use maybeSingle for safety

        if (response != null) {
          userData.value = {...userData.value, ...response};
          print('✅ User profile data fetched and merged: $userData');
        } else {
          print('ℹ️ No user profile found for uid: ${currentUser.id}. Using basic info.');
        }
      } else {
        userData.value = {};
        print('ℹ️ No current user. User data cleared.');
      }
    } catch (e) {
      print('❌ Failed to fetch user data: $e');
      userData.value = {}; // ত্রুটি ঘটলে ক্লিয়ার করা ভালো
    }
  }

  Future<void> checkUserSessionAndNavigate() async {
    await fetchCurrentUser(); // প্রথমে ব্যবহারকারীর ডেটা আনুন

    // fetchCurrentUser() এর পরে userData.value তে ইমেইল থাকবে যদি ব্যবহারকারী লগইন করা থাকে
    final currentEmail = userData.value['email'];

    if (currentEmail != null) {
      if (currentEmail == adminEmail) {
        print('🚀 Admin user ($currentEmail) detected. Navigating to Dashboard.');
        Get.offAllNamed(AppRoutes.dashboard);
      } else {
        print('🏠 Regular user ($currentEmail) detected. Navigating to Home.');
        Get.offAllNamed(AppRoutes.home);
      }
    } else {
      // fetchCurrentUser() সফলভাবে ডেটা আনতে পারেনি অথবা ব্যবহারকারী লগইন করা নেই
      print('🚪 No active user session or failed to fetch data. Navigating to login.');
      Get.offAllNamed(AppRoutes.login);
    }
  }
}
