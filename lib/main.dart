import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:booking_calendar/booking_calendar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'controllers/auth_controller.dart';
import 'controllers/auth_fetch_controller.dart';
import 'firebase_options.dart';
import 'utils/route.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Supabase.initialize(
      url: 'https://itjvyjehahgjunwjrmho.supabase.co',
      anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Iml0anZ5amVoYWhnanVud2pybWhvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDY5NTM5MDcsImV4cCI6MjA2MjUyOTkwN30.6fwDcWajochW0qP9Qw_KDKip9RzC92l4ivivEKTZr0Y'
  );
  initializeDateFormatting()
      .then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SignupController().diplinkConfig(context);
    UserService().checkUserSessionAndNavigate();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
    ));


    // Wrap MaterialApp with ScreenUtilInit
    return ScreenUtilInit(
      designSize: const Size(375, 812), // Provide your design screen size
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Your Shop',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            scaffoldBackgroundColor: Colors.black,
            fontFamily: 'Poppins',
            textTheme: TextTheme(
              bodyLarge: TextStyle(color: Colors.white, fontSize: 16.sp),
              bodyMedium: TextStyle(color: Colors.white70, fontSize: 14.sp),
              titleLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22.sp),
              titleMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18.sp),
            ),
            iconTheme: const IconThemeData(color: Colors.white),
            appBarTheme: AppBarTheme(
              backgroundColor: Colors.black,
              elevation: 0,
              iconTheme: const IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
          ), // Pass the child here
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.splash,
          routes: AppRoutes.routes,
        );
      }, // Your initial screen
    );
  }
}