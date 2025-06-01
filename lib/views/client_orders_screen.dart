import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/order_controller.dart';

class ClientOrdersTab extends StatelessWidget {
  final OrderController orderController = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (orderController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      }

      if (orderController.orderList.isEmpty) {
        return Center(
          child: Text(
            'No client orders yet.',
            style: TextStyle(fontSize: 16.sp, color: Colors.white70),
          ),
        );
      }

      return ListView.builder(
        padding: EdgeInsets.all(12.w),
        itemCount: orderController.orderList.length,
        itemBuilder: (context, index) {
          final order = orderController.orderList[index];

          return Card(
            margin: EdgeInsets.symmetric(vertical: 8.h),
            child: Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _infoRow('Client Name', order['username']),
                  _infoRow('Service', order['service']),
                  _infoRow('Provider', order['provider_name']),
                  _infoRow('Amount', '\$${order['amount']}'),
                  _infoRow('Payable', '\$${order['pay_amount']}'),
                  _infoRow('Transaction ID', order['trx_id']),
                  _infoRow('Duration', order['duration']),
                  _infoRow('Start Time', order['start_date']),
                  _infoRow('End Time', order['end_date']),
                  SizedBox(height: 12.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton.icon(
                        icon: Icon(Icons.delete_outline, size: 16.sp),
                        label: Text('Delete', style: TextStyle(fontSize: 13.sp)),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Get.defaultDialog(
                            title: "Confirm Delete",
                            middleText: "Are you sure you want to delete this order?",
                            textCancel: "Cancel",
                            textConfirm: "Delete",
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Get.back();
                              orderController.deleteOrder(order['id']);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
