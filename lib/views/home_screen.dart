import 'package:barber_shop/utils/route.dart';
import 'package:barber_shop/widgets/categorylist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/offercard_widget.dart';
import '../widgets/searchbar_widget.dart';
import '../widgets/sectionheader_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        welcomeMessage: 'Welcome',
        username: 'Hay, Kelly',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBar(),
            SizedBox(height: 24.0.h),
            buildSectionHeader("Best Category", () {}),
            SizedBox(height: 16.0.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Horizontal scroll enable
              child: Row(
                children: [
                  buildCategoryList(Icons.cut_outlined, 'Hair Salon'),
                  SizedBox(width: 12.w),
                  buildCategoryList(Icons.brush_outlined, 'Makeup'),
                  SizedBox(width: 12.w),
                  buildCategoryList(Icons.content_cut_outlined, 'Barber'),
                  SizedBox(width: 12.w),
                  buildCategoryList(Icons.handyman_outlined, 'Nail Salon'),
                  SizedBox(width: 12.w),
                  buildCategoryList(Icons.spa_outlined, 'Massage'),
                ],
              ),
            ),
            SizedBox(height: 16.0.h),
            buildSectionHeader("Special Offers", () {}),
            SizedBox(height: 16.0.h),
            GestureDetector(
              onTap: (){
                Get.offAllNamed(AppRoutes.booking);
              },
              child: SizedBox(
                height: 300.h,
                width: 250.w,
                child: buildOfferCard(
                    'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGJhcmJlcnNob3B8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                    '5',
                    'Razor Work Fred',
                    'QualityTrusted Services.',
                    '100',
                    '120'
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}