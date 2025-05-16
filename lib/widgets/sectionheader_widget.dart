import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildSectionHeader(String title, VoidCallback onSeeAll) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        title,
        style: TextStyle(color: Colors.white70, fontSize: 20.sp),
      ),
      TextButton(
        onPressed: onSeeAll,
          child: Text(
            'See All',
            style: TextStyle(color: Colors.white70, fontSize: 14.sp),
          )
      ),
    ],
  );
}