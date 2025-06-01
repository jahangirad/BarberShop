import 'package:barber_shop/widgets/appbar_widget.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../controllers/auth_fetch_controller.dart';

class BookingCalendarDemoApp extends StatefulWidget {
  final dynamic servicedetails;
  const BookingCalendarDemoApp({super.key, required this.servicedetails});

  @override
  State<BookingCalendarDemoApp> createState() => _BookingCalendarDemoAppState();
}

class _BookingCalendarDemoAppState extends State<BookingCalendarDemoApp> {
  final UserService userService = Get.put(UserService());
  final now = DateTime.now();
  late BookingService mockBookingService;

  List<DateTimeRange> converted = [];

  @override
  void initState() {
    super.initState();
    getBookingData();
    mockBookingService = BookingService(
      serviceName: 'Mock Service',
      serviceDuration: 30,
      bookingEnd: DateTime(now.year, now.month, now.day, 18, 0),
      bookingStart: DateTime(now.year, now.month, now.day, 8, 0),
    );
  }

  Stream<dynamic>? getBookingStreamMock({
    required DateTime end,
    required DateTime start,
  }) {
    return Stream.value([]);
  }

  Future<void> getBookingData() async {
    try {
      final response = await Supabase.instance.client
          .from('bookingdt')
          .select()
          .eq('uid', widget.servicedetails['uid']);

      for (var booking in response) {
        converted.add(DateTimeRange(
          start: DateTime.parse(booking['start']),
          end: DateTime.parse(booking['end']),
        ));
      }

      setState(() {});
    } catch (e) {
      throw Exception('Booking load failed: $e');
    }
  }

  Future<void> uploadBookingMock({
    required BookingService newBooking,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    converted.add(DateTimeRange(
      start: newBooking.bookingStart,
      end: newBooking.bookingEnd,
    ));

    try {
      await Supabase.instance.client.from('bookingdt').insert({
        'uid': widget.servicedetails['uid'].toString(),
        'userid': userService.userData['uid'].toString(),
        'start': newBooking.bookingStart.toString(),
        'end': newBooking.bookingEnd.toString(),
      });
    } catch (e) {
      throw Exception(e);
    }
  }

  List<DateTimeRange> convertStreamResultMock({required dynamic streamResult}) {
    return converted;
  }

  List<DateTimeRange> generatePauseSlots() {
    return [
      DateTimeRange(
        start: DateTime(now.year, now.month, now.day, 12, 0),
        end: DateTime(now.year, now.month, now.day, 13, 0),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: BookingCalendar(
              bookingService: mockBookingService,
              convertStreamResultToDateTimeRanges: convertStreamResultMock,
              getBookingStream: getBookingStreamMock,
              uploadBooking: uploadBookingMock,
              pauseSlots: generatePauseSlots(),
              pauseSlotText: 'LUNCH',
              hideBreakTime: false,
              loadingWidget: Text(
                'Fetching data...',
                style: TextStyle(fontSize: 16.sp),
              ),
              uploadingWidget: SizedBox(
                height: 30.h,
                width: 30.h,
                child: CircularProgressIndicator(strokeWidth: 2.w),
              ),
              locale: 'hu_HU',
              startingDayOfWeek: StartingDayOfWeek.tuesday,
              wholeDayIsBookedWidget: Text(
                'Sorry, for this day everything is booked',
                style: TextStyle(fontSize: 14.sp),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
