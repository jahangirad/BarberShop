import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import 'add_provider_screen.dart';
import 'add_service_screen.dart';
import 'client_orders_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> with SingleTickerProviderStateMixin {

  final SignupController signupController = Get.put(SignupController());
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
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
        actions: [
          IconButton(
            icon: Icon(Icons.logout, size: 24.sp),
            onPressed: () {
              signupController.logoutUser();
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Client Orders'),
            Tab(text: 'Provider'),
            Tab(text: 'Service'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          ClientOrdersTab(),
          AddProviderScreen(),
          AddServiceTab(),
        ],
      ),
    );
  }
}