import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSearchBar() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.grey[850],
      borderRadius: BorderRadius.circular(12.0.r),
    ),
    child: TextField(
      style: TextStyle(color: Colors.white, fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: 'Search...',
        hintStyle: TextStyle(color: Colors.white54, fontSize: 14.sp),
        prefixIcon: Icon(Icons.search, color: Colors.amber[600], size: 22.r),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 14.0.h),
      ),
    ),
  );
}