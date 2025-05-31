import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_fetch_controller.dart';
import '../controllers/pdf_invoice_controller.dart';
import '../widgets/appbar_widget.dart';

class OrderCompletePage extends StatelessWidget {
  final dynamic serviceName;
  final dynamic providerName;
  final dynamic price;
  final dynamic duration;
  OrderCompletePage({super.key, required this.serviceName, required this.providerName, required this.price, required this.duration});

  final UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        welcomeMessage: 'Welcome',
        username: userService.userData['name'].toString(),
        avatarUrl: userService.userData['avatar'].toString(),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80.sp),
              SizedBox(height: 20.h),
              Text(
                'The order has been completed!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15.h),
              Text(
                'Your order has been successfully completed. You can now download the invoice. You need to keep the invoice with you.',
                style: TextStyle(fontSize: 16.sp),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              ElevatedButton.icon(
                onPressed: () {
                  generateAndDownloadInvoice(
                      serviceName: serviceName,
                      providerName: providerName,
                      price: price,
                      duration: duration
                  );
                },
                icon: Icon(Icons.download),
                label: Text('Download Invoice'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
