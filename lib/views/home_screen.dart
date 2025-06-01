import 'package:barber_shop/widgets/categorylist_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_fetch_controller.dart';
import '../controllers/category_controller.dart';
import '../controllers/provider_service_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/offercard_widget.dart';
import '../widgets/searchbar_widget.dart';
import '../widgets/sectionheader_widget.dart';
import 'booking_screen.dart';
import 'category_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final ProviderServiceController providerServiceController = Get.put(ProviderServiceController());
  final UserService userService = Get.put(UserService());
  final CategoryController categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        welcomeMessage: 'Welcome',
        username: userService.userData['name'].toString(),
        avatarUrl: userService.userData['avatar'].toString(),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSearchBarWidget(providerServiceController),
            SizedBox(height: 24.0.h),
            buildSectionHeader("Best Category", () {}),
            SizedBox(height: 16.0.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Horizontal scroll enable
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      Get.to(() => CategoryScreen(category: 'HairCut'));
                    },
                      child: buildCategoryList(Icons.cut_outlined, 'HairCut')
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                      onTap: (){
                        Get.to(() => CategoryScreen(category: 'Makeup'));
                      },
                      child: buildCategoryList(Icons.brush_outlined, 'Makeup')
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                      onTap: (){
                        Get.to(() => CategoryScreen(category: 'Barber'));
                      },
                      child: buildCategoryList(Icons.content_cut_outlined, 'Barber')
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                      onTap: (){
                        Get.to(() => CategoryScreen(category: 'Nail Salon'));
                      },
                      child: buildCategoryList(Icons.handyman_outlined, 'Nail Salon')
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                      onTap: (){
                        Get.to(() => CategoryScreen(category: 'Massage'));
                      },
                      child: buildCategoryList(Icons.spa_outlined, 'Massage')
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0.h),
            buildSectionHeader("Special Offers", () {}),
            SizedBox(height: 16.0.h),
            Obx(() {
              if (providerServiceController.service.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox(
                height: 300.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: providerServiceController.service.length,
                  itemBuilder: (context, index) {
                    final service = providerServiceController.service[index];
                    return Padding(
                      padding: EdgeInsets.only(
                        right: index == providerServiceController.service.length - 1 ? 0 : 10.w,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => BookingScreen(servicedetails: service),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 250.w,
                          child: buildOfferCard(
                            service['img'].toString(),
                            service['rating'].toString(),
                            service['ser_name'].toString(),
                            service['subtitle'].toString(),
                            service['price'].toString(),
                            service['com_price'].toString(),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}