import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/auth_fetch_controller.dart';
import '../controllers/category_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/offercard_widget.dart';
import '../widgets/searchbar_widget.dart';

class CategoryScreen extends StatelessWidget {
  final String category;

  CategoryScreen({super.key, required this.category});

  final CategoryController categoryController = Get.put(CategoryController());
  final UserService userService = Get.put(UserService());

  @override
  Widget build(BuildContext context) {
    // ✅ Fetch when screen opens
    categoryController.fetchServicesByCategory(category);

    return Scaffold(
      appBar: CustomAppBar(
        welcomeMessage: 'Welcome',
        username: userService.userData['name'].toString(),
        avatarUrl: userService.userData['avatar'].toString(),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryController.serviceList.isEmpty) {
          return Center(child: Text("No services found in $category"));
        }

        return ListView.builder(
          padding: EdgeInsets.all(16.0.w),
          itemCount: categoryController.serviceList.length,
          itemBuilder: (context, index) {
            final service = categoryController.serviceList[index];
            return buildOfferCard(
              service['img'],
              service['rating'].toString(),
              service['ser_name'],
              service['subtitle'],
              service['price'].toString(),
              service['com_price'].toString(),
            );
          },
        );
      }),
    );
  }
}

