import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildLoadingIndicator() {
  return Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: const CircularProgressIndicator(color: Colors.amber),
    ),
  );
}