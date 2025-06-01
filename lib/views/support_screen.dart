import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/url_launcher_controller.dart';
import '../utils/route.dart';

class SupportScreen extends StatelessWidget {
  SupportScreen({super.key});

  final UrlLauncherController urlLauncherController = Get.put(UrlLauncherController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.offAllNamed(AppRoutes.account),
        ),
        title: Text(
          'Support',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 15.h),
            Text(
              'If you need help or have any questions, feel free to reach out to our support team. We are here to assist you!',
              style: TextStyle(fontSize: 14.sp, color: Colors.grey[300], height: 1.5),
            ),
            SizedBox(height: 25.h),
            _buildSupportOption(
              icon: Icons.email_outlined,
              title: 'Email Support',
              subtitle: 'support@barberconnect.app', // Example email
              onTap: () {
                urlLauncherController.launchGmail();
              },
            ),
            _buildSupportOption(
              icon: Icons.phone_outlined,
              title: 'Call Us (Mon-Fri, 9am-5pm)',
              subtitle: '+1-800-BARBERS (227-2377)', // Example number
              onTap: () {
                urlLauncherController.launchPhone();
              },
            ),
            _buildSupportOption(
              icon: Icons.online_prediction,
              title: 'WhatsApp Support',
              subtitle: 'Find answers to common questions',
              onTap: () {
                urlLauncherController.launchWhatsApp();
              },
            ),
            SizedBox(height: 30.h),
            Center(
              child: Text(
                'We typically respond within 24-48 business hours.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13.sp, color: Colors.grey[400]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSupportOption({required IconData icon, required String title, required String subtitle, VoidCallback? onTap}) {
    return Card(
      color: Colors.grey[850],
      margin: EdgeInsets.only(bottom: 12.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent[100], size: 24.sp), // Explicit accent color
        title: Text(title, style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w500)),
        subtitle: Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 13.sp)),
        trailing: onTap != null ? Icon(Icons.arrow_forward_ios, color: Colors.grey[600], size: 16.sp) : null,
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      ),
    );
  }
}