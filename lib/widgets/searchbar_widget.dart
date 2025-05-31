import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/provider_service_controller.dart';
import '../views/booking_screen.dart';

Widget buildSearchBarWidget(ProviderServiceController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      TextField(
        onChanged: controller.searchService,
        decoration: InputDecoration(
          hintText: 'Search service...',
          prefixIcon: Icon(Icons.search, color: Colors.amber),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.amber),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: BorderSide(color: Colors.amber, width: 2.w),
          ),
        ),
      ),
      Obx(() {
        if (controller.searchResults.isEmpty) return SizedBox();
        return ListView.builder(
          shrinkWrap: true,
          itemCount: controller.searchResults.length,
          itemBuilder: (context, index) {
            final result = controller.searchResults[index];
            return ListTile(
              title: Text(result['ser_name']),
              subtitle: Text(result['subtitle']),
              onTap: () {
                Get.to(() => BookingScreen(servicedetails: result));
                controller.searchResults.clear();
              },
            );
          },
        );
      }),
    ],
  );
}
