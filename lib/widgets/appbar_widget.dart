import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../utils/route.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String welcomeMessage;
  final String username;
  final String avatarUrl;

  CustomAppBar({
    required this.welcomeMessage,
    required this.username,
    required this.avatarUrl,
  });

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.black87,
      leadingWidth: 65.w,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w, top: 8.h, bottom: 8.h),
        child: GestureDetector(
          onTap: (){
            Get.offAllNamed(AppRoutes.account);
          },
          child: CircleAvatar(
            radius: 22.r,
            backgroundImage: avatarUrl.isNotEmpty
                ? NetworkImage(avatarUrl)
                : NetworkImage('https://cdn.pixabay.com/photo/2025/04/03/04/41/ai-generated-9510467_960_720.jpg'),
          ),
        ),
      ),
      title: GestureDetector(
        onTap: (){
          Get.offAllNamed(AppRoutes.account);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              welcomeMessage,
              style: TextStyle(fontSize: 12.sp, color: Colors.white70),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  username,
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}