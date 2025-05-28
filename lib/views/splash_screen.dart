// screens/splash_screen.dart
import 'dart:async';
import 'package:barber_shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../controllers/auth_fetch_controller.dart';
import '../controllers/provider_service_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {



  @override
  void initState() {
    super.initState();
    _checkSessionAndNavigate();
  }

  Future<void> _checkSessionAndNavigate() async {
    // একটি ন্যূনতম সময় স্প্ল্যাশ স্ক্রিন দেখানোর জন্য (ঐচ্ছিক, UX এর জন্য)
    await Future.delayed(const Duration(seconds: 2)); // যেমন ২ সেকেন্ড

    try {
      // SignupController এর ডিপলিঙ্ক কনফিগ (যদি প্রয়োজন হয়)
      // এটি context এর উপর নির্ভরশীল হলে WidgetsBinding.instance.addPostFrameCallback ব্যবহার করতে পারেন,
      // অথবা Get.find<SignupController>().diplinkConfig(); যদি context না লাগে।

      final userService = Get.put(UserService());

      // Supabase ক্লায়েন্ট ইনিশিয়ালাইজড কিনা নিশ্চিত করুন (সাধারণত main এ হয়)
      final currentUser = Supabase.instance.client.auth.currentUser;

      if (currentUser != null) {
        print("👤 User session found (${currentUser.email}). Navigating via UserService.");
        // UserService ব্যবহারকারীর ডেটা ফেচ করবে এবং সঠিক পেইজে নেভিগেট করবে
        // (হোম বা ড্যাশবোর্ড, তার ইমেইল অনুযায়ী)
        await userService.checkUserSessionAndNavigate();
      } else {
        print("🚪 No user session. Navigating to Login.");
        Get.offAllNamed(AppRoutes.login);
      }
    } catch (e) {
      print("❌ Error during splash screen session check: $e");
      // কোনো ত্রুটি হলে একটি ফলব্যাক পেইজে পাঠান, যেমন লগইন পেইজ
      Get.offAllNamed(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    // একটি সুন্দর স্প্ল্যাশ স্ক্রিন UI তৈরি করুন
    return Scaffold(
      backgroundColor: Colors.black, // আপনার অ্যাপের প্রধান ব্যাকগ্রাউন্ড কালার
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // আপনার অ্যাপের লোগো এখানে যোগ করতে পারেন
            // উদাহরণস্বরূপ:
            // Image.asset('assets/images/app_logo.png', width: 150.w, height: 150.h),
            FlutterLogo(size: 100.r), // একটি সাধারণ ফ্লাটার লোগো
            SizedBox(height: 20.h),
            Text(
              'Barber Shop', // আপনার অ্যাপের নাম
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 40.h),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white70),
            ),
            SizedBox(height: 10.h),
            Text(
              'Loading...',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}