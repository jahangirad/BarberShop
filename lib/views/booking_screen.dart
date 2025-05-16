import 'package:barber_shop/widgets/appbar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  DateTime? _selectedDate;

  Future<void> _presentDatePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(), // User can't select past dates
      lastDate: DateTime(DateTime.now().year + 1), // Allow selection for up to one year
      builder: (context, child) {
        // Theme the date picker to match the dark theme
        return Theme(
          data: ThemeData.dark().copyWith(
            colorScheme: ColorScheme.dark(
              primary: Colors.tealAccent, // header background color
              onPrimary: Colors.black, // header text color
              onSurface: Colors.white, // body text color
            ),
            dialogBackgroundColor: Colors.grey[900],
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.tealAccent, // button text color
              ),
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

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
                  'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGJhcmJlcnNob3B8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
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
                          shopName,
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
                              shopRating.toString(),
                              style: TextStyle(fontSize: 14.sp, color: Colors.white, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Text(
                    shopDescription,
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
                            shopPrice,
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
                        'Mail: jahangirad14@gmail.com',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[400]),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        'Phone: 01796-196500',
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
                    onTap: _presentDatePicker,
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
                            _selectedDate == null
                                ? 'Tap to choose a date'
                                : DateFormat('EEE, MMM d, yyyy').format(_selectedDate!), // e.g., Mon, Jul 29, 2024
                            style: TextStyle(fontSize: 16.sp, color: _selectedDate == null ? Colors.grey[500] : Colors.white),
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
              child: ElevatedButton(
                onPressed: () {
                  if (_selectedDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Please select a date first!')),
                    );
                    return;
                  }
                  // Implement payment logic here
                  print('Proceeding to pay for booking on: ${DateFormat('yyyy-MM-dd').format(_selectedDate!)}');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Pay button pressed for ${_selectedDate!.toIso8601String().substring(0,10)}')),
                  );
                },
                // Style is handled by ElevatedButtonTheme in ThemeData
                child: Text('Pay Now'),
              ),
            ),
            SizedBox(height: 30.h), // Some bottom padding
          ],
        ),
      ),
    );
  }
}