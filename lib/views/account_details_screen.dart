import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_fetch_controller.dart'; // Adjust path as needed
import '../utils/route.dart'; // Adjust path as needed

class AccountDetailsScreen extends StatelessWidget {
  AccountDetailsScreen({super.key});

  final UserService userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    String name = userService.userData['name'] ?? 'N/A';
    String email = userService.userData['email'] ?? 'N/A';
    String? avatarUrl = userService.userData['avatar'];
    String phoneNumber = userService.userData['phone'] ?? 'Not Provided';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.offAllNamed(AppRoutes.account),
        ),
        title: Text(
          'Account Details',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // No explicit background color, will use AppBarTheme from main theme
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60.r,
              backgroundColor: Colors.grey[800],
              backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? NetworkImage(avatarUrl)
                  : null,
              child: (avatarUrl == null || avatarUrl.isEmpty)
                  ? Icon(Icons.person, size: 50.r, color: Colors.white70)
                  : null,
            ),
            SizedBox(height: 20.h),
            _buildDetailItem(icon: Icons.person_outline, title: 'Name', value: name),
            _buildDetailItem(icon: Icons.email_outlined, title: 'Email', value: email),
            _buildDetailItem(icon: Icons.phone_outlined, title: 'Phone Number', value: phoneNumber),
            SizedBox(height: 30.h),
            Text(
              'To change your account information, please contact our support team and provide the necessary information. Thank you.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[300],
                height: 1.5, // Line height factor, unitless
              ),
            ),
            SizedBox(height: 30.h),
            ElevatedButton.icon(
              onPressed: () {
                Get.toNamed(AppRoutes.support);
              },
              icon: Icon(Icons.headset_mic_outlined, size: 20.sp, color: Colors.white),
              label: Text(
                'Contact Support',
                style: TextStyle(fontSize: 16.sp, color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFFDB813),
                foregroundColor: Colors.black,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 12.h),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem({required IconData icon, required String title, required String value}) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.grey[900]?.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white70, size: 22.sp),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: Colors.grey[400],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}