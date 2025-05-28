import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Order {
  final String id;
  final String clientName;
  final String serviceName;
  final String dateTime;
  final String status;
  final double price;
  final String? clientImage;

  Order({
    required this.id,
    required this.clientName,
    required this.serviceName,
    required this.dateTime,
    required this.status,
    required this.price,
    this.clientImage,
  });
}

class ClientOrdersTab extends StatelessWidget {
  final List<Order> orders = [
    Order(id: '1', clientName: 'Kelly Avenger', serviceName: 'Premium Haircut & Style', dateTime: 'Aug 05, 2024 10:00 AM', status: 'Confirmed', price: 75.0, clientImage: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    Order(id: '2', clientName: 'John Doe', serviceName: 'Beard Trim', dateTime: 'Aug 05, 2024 02:00 PM', status: 'Pending', price: 40.0, clientImage: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    Order(id: '3', clientName: 'Jane Smith', serviceName: 'Full Color', dateTime: 'Aug 06, 2024 11:00 AM', status: 'Completed', price: 150.0, clientImage: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'),
    Order(id: '4', clientName: 'Mike Brown', serviceName: 'Manicure', dateTime: 'Aug 06, 2024 03:00 PM', status: 'Cancelled', price: 30.0),
  ];

  Color _getStatusColor(BuildContext context, String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Colors.greenAccent.shade400;
      case 'pending':
        return Colors.orangeAccent.shade400;
      case 'completed':
        return Theme.of(context).hintColor;
      case 'cancelled':
        return Colors.redAccent.shade400;
      default:
        return Colors.grey.shade600;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'confirmed':
        return Icons.check_circle_outline_rounded;
      case 'pending':
        return Icons.hourglass_empty_rounded;
      case 'completed':
        return Icons.task_alt_rounded;
      case 'cancelled':
        return Icons.cancel_outlined;
      default:
        return Icons.info_outline_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          'No client orders yet.',
          style: TextStyle(fontSize: 16.sp, color: Colors.white70),
        ),
      );
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 8.w),
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        final statusColor = _getStatusColor(context, order.status);
        final statusIcon = _getStatusIcon(order.status);

        return Card(
          margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.grey.shade700,
                      backgroundImage: order.clientImage != null ? NetworkImage(order.clientImage!) : null,
                      child: order.clientImage == null ? Icon(Icons.person_outline_rounded, size: 22.r, color: Colors.white70) : null,
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        order.clientName,
                        style: TextStyle(fontSize: 17.sp, fontWeight: FontWeight.bold, color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(statusIcon, color: statusColor, size: 15.sp),
                          SizedBox(width: 5.w),
                          Text(
                            order.status,
                            style: TextStyle(fontSize: 12.sp, color: statusColor, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Text(
                  order.serviceName,
                  style: TextStyle(fontSize: 15.sp, color: Colors.white.withOpacity(0.9)),
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today_outlined, size: 14.sp, color: Colors.white70),
                    SizedBox(width: 6.w),
                    Text(
                      order.dateTime,
                      style: TextStyle(fontSize: 13.sp, color: Colors.white70),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${order.price.toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: Theme.of(context).hintColor),
                    ),
                    Row(
                      children: [
                        if (order.status.toLowerCase() == 'pending')
                          _actionButton(context, 'Accept', Icons.check_rounded, () {/* Accept order */}),
                        SizedBox(width: 8.w),
                        _actionButton(context, 'Details', Icons.visibility_outlined, () {/* View details */}),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _actionButton(BuildContext context, String label, IconData icon, VoidCallback onPressed) {
    return TextButton.icon(
      icon: Icon(icon, size: 16.sp, color: Theme.of(context).hintColor),
      label: Text(label, style: TextStyle(fontSize: 13.sp, color: Theme.of(context).hintColor, fontWeight: FontWeight.w500)),
      style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          backgroundColor: Theme.of(context).hintColor.withOpacity(0.1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),
              side: BorderSide(color: Theme.of(context).hintColor.withOpacity(0.3))
          )
      ),
      onPressed: onPressed,
    );
  }
}