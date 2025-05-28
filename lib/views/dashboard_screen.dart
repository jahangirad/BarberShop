import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_provider_screen.dart';
import 'add_service_screen.dart';
import 'client_orders_screen.dart';
import 'support_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.menu_rounded, size: 24.sp),
          onPressed: () {
            // Implement drawer or menu action
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_none_outlined, size: 24.sp),
            onPressed: () {
              // Handle notifications
            },
          ),
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: CircleAvatar(
              radius: 18.r,
              backgroundImage: NetworkImage('https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'), // Placeholder avatar
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Client Orders'),
            Tab(text: 'Provider'),
            Tab(text: 'Service'),
            Tab(text: 'Support'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClientOrdersTab(),
          AddProviderScreen(),
          AddServiceTab(),
          SupportTab(),
        ],
      ),
    );
  }
}