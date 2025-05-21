import 'package:barber_shop/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/auth_fetch_controller.dart';
import 'booking_calender_screen.dart';

class BookingScreen extends StatefulWidget {
  final dynamic servicedetails;
  const BookingScreen({super.key, required this.servicedetails});

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  final UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    // Mock data - replace with your actual data source
    const String shopName = "Star Quality Cutz";
    const String shopDescription = "Experience precision, style, and with";
    const String shopPrice = "\$50.00";
    const String shopDiscount = "SAVE UP TO 20%";
    const double shopRating = 5.2; // This is unusual, ratings are usually 1-5. Using it as is.

    const String serviceName = "Haircut";
    const String serviceDescription = "Fresh cuts, style tailored for you";
    const String servicePrice = "\$50.00";
    const String serviceDiscount = "SAVE UP TO 20%";

    return Scaffold(
      appBar: CustomAppBar(
          welcomeMessage: 'Welcome',
          username: 'Booking',
          avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg'
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Top Image - Replace with your actual image
            SizedBox(
              height: 250.h,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0), // Radius সেট করুন
                child: Image.network(
                  widget.servicedetails['img'].toString(),
                  fit: BoxFit.cover,
                  loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Container(
                      color: Colors.grey[700],
                      child: Icon(Icons.broken_image, size: 50.sp, color: Colors.white54),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          widget.servicedetails['ser_name'].toString(),
                          style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(Icons.star, color: Colors.yellow, size: 18.sp),
                            SizedBox(width: 4.w),
                            Text(
                              widget.servicedetails['rating'].toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    widget.servicedetails['subtitle'].toString(),
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            '\$${widget.servicedetails['price'].toString()}',
                            style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold, color: Colors.tealAccent),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            shopDiscount,
                            style: TextStyle(fontSize: 12.sp, color: Colors.tealAccent.withOpacity(0.8), fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      Icon(Icons.location_pin, size: 28.sp, color: Colors.grey[400]),
                    ],
                  ),
                ],
              ),
            ),

            // Removed the "Services, Reviews, Portfolio, Gift Card" row as requested

            SizedBox(height: 16.h),

            // Service Item Card
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Card(
                // Card styling is handled by CardTheme in ThemeData
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Shop Address',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Sundarganj, Gaibandha',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Card(
                // Card styling is handled by CardTheme in ThemeData
                child: Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Contact Info',
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Mail: ${userService.userData['email'].toString()}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Mail: ${userService.userData['phone'].toString()}',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // You can add more service cards here if needed, following the same pattern

            SizedBox(height: 24.h),

            // Date Selection
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select Date:",
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
                  ),
                  SizedBox(height: 8.h),
                  InkWell(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BookingCalendarDemoApp()),
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(color: Colors.grey[700]!),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tap to choose a date',
                            style: TextStyle(fontSize: 16.sp, color: Colors.white),
                          ),
                          Icon(Icons.calendar_today, color: Colors.grey[400], size: 20.sp),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // Pay Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              // child: ElevatedButton(
              //   onPressed: () {
              //     if (_selectedDate == null) {
              //       ScaffoldMessenger.of(context).showSnackBar(
              //         SnackBar(content: Text('Please select a date first!')),
              //       );
              //       return;
              //     }
              //     // Implement payment logic here
              //     print('Proceeding to pay for booking on: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}');
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       SnackBar(content: Text('Pay button pressed for ${_selectedDate!.toIso8601String().substring(0,10)}')),
              //     );
              //   },
              //   // Style is handled by ElevatedButtonTheme in ThemeData
              //   child: Text('Pay Now'),
              // ),
            ),
            SizedBox(height: 30.h), // Some bottom padding
          ],
        ),
      ),
    );
  }
}
