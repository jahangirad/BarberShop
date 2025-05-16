import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildCategoryList(IconData icon, String name) {
  return SizedBox(
    height: 110.h, // Increased height slightly for better spacing
    child: Padding(
      padding: EdgeInsets.only(right: 16.0.w),
      child: Column(
        children: [
          Container(
            width: 60.r, // Make it square
            height: 60.r,
            padding: EdgeInsets.all(12.0.r), // Adjusted padding
            decoration: BoxDecoration(
              color: Colors.grey[850],
              borderRadius: BorderRadius.circular(12.0.r),
            ),
            child: Icon(icon, size: 28.r, color: Colors.white70),
          ),
          SizedBox(height: 8.0.h),
          Text(name, style: TextStyle(color: Colors.white70, fontSize: 12.sp)),
        ],
      ),
    )
  );
}