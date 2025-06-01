import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/route.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () => Get.offAllNamed(AppRoutes.account),
        ),
        title: Text(
          'Privacy Policy',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Barber Shop Booking Policy:'),
            _buildPolicyPoint(
                'Priority for Online Bookings: Customers who book their appointments online will be given priority.'),
            _buildPolicyPoint(
                'Advance Payment: An advance payment of \$5 (or local currency equivalent) is required to secure your booking. This amount will be deducted from your total bill.'),
            _buildPolicyPoint(
                'Punctuality: Please ensure you arrive on time for your scheduled appointment. Late arrivals may result in a shortened service or rescheduling, subject to availability.'),
            _buildPolicyPoint(
                'Cancellation Policy: If you need to cancel your appointment, please do so at least [e.g., 24 hours] in advance. For cancellations made after placing an order or within the [e.g., 24 hours] window, you must provide a valid reason. Our support team will review your request and inform you of the decision. If cancellation is not possible under the circumstances, you will be notified. The advance payment may be non-refundable for late cancellations or no-shows without valid justification.'),
            _buildPolicyPoint(
                'Service Adjustments: If any adjustments are needed to your service, please discuss with your barber before or during the service.'),
            SizedBox(height: 20.h),

            _buildSectionTitle('General Data Privacy:'),
            _buildPolicyPoint(
                'Information Collection: We collect personal information such as your name, email address, phone number, and booking history to provide and improve our services.'),
            _buildPolicyPoint(
                'Use of Information: Your information is used to manage appointments, communicate with you about your bookings, personalize your experience, and for internal service improvements.'),
            _buildPolicyPoint(
                'Data Security: We implement reasonable security measures to protect your personal information from unauthorized access, use, or disclosure.'),
            _buildPolicyPoint(
                'Third-Party Services: We may use third-party services for payment processing or analytics. These services have their own privacy policies, and we encourage you to review them.'),
            _buildPolicyPoint(
                'Cookies and Tracking: Our app may use cookies or similar technologies to enhance user experience and analyze usage patterns.'),
            _buildPolicyPoint(
                'Your Rights: You may have the right to access, correct, or delete your personal information. Please contact our support team for such requests.'),
            _buildPolicyPoint(
                'Policy Updates: We may update this privacy policy from time to time. We will notify you of any significant changes by posting the new policy within the app or via email.'),

            SizedBox(height: 25.h),
            Text(
              'Thank you for being with us and trusting our services!',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h, top: 10.h),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 17.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildPolicyPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 8.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('•  ', style: TextStyle(color: Colors.grey[300], fontSize: 14.sp)), // Height is inherent here
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[300],
                height: 1.4, // Line height factor
              ),
            ),
          ),
        ],
      ),
    );
  }
}