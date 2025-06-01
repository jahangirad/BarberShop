import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/route.dart';
// import 'package:package_info_plus/package_info_plus.dart';

class AboutAppScreen extends StatefulWidget {
  const AboutAppScreen({super.key});

  @override
  State<AboutAppScreen> createState() => _AboutAppScreenState();
}

class _AboutAppScreenState extends State<AboutAppScreen> {
  String _appName = "Barber Connect"; // Example App Name
  String _version = "1.0.0";
  String _buildNumber = "1";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.offAllNamed(AppRoutes.account),
        ),
        title: Text(
          'About App',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.cut_sharp, size: 70.r, color: Colors.blueAccent[100]), // Explicit accent color
            SizedBox(height: 15.h),
            Text(
              _appName,
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 5.h),
            Text(
              'Version $_version ($_buildNumber)',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[400],
              ),
            ),
            SizedBox(height: 30.h),
            Text(
              'Welcome to $_appName! Your premier destination for effortlessly booking appointments with talented barbers near you.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15.sp, color: Colors.grey[200], height: 1.5),
            ),
            SizedBox(height: 15.h),
            Text(
              'Our mission is to provide a seamless and efficient experience for both our valued customers and skilled barbers. With our user-friendly interface, you can easily discover barbers, check their availability and services, book appointments at your convenience, and manage your schedule all in one place.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[300], height: 1.5),
            ),
            SizedBox(height: 15.h),
            Text(
              'For barbers, we offer a robust platform to showcase your skills, manage your bookings effectively, connect with a wider clientele, and grow your business.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[300], height: 1.5),
            ),
            SizedBox(height: 15.h),
            Text(
              'We are committed to continuously improving our platform and adding new features to serve you better. Your feedback is invaluable to us.',
              textAlign: TextAlign.justify,
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[300], height: 1.5),
            ),
            SizedBox(height: 30.h),
            Text(
              'Thank you for choosing $_appName!',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              '© ${DateTime.now().year} Barber Connect Inc. All rights reserved.', // Example Company
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[500],
              ),
            ),
            SizedBox(height: 20.h), // Added some bottom padding
          ],
        ),
      ),
    );
  }
}