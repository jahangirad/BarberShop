import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/offercard_widget.dart';
import '../widgets/searchbar_widget.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        welcomeMessage: 'Welcome',
        username: 'Hay, Kelly',
        avatarUrl: 'https://randomuser.me/api/portraits/men/32.jpg',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            buildSearchBar(),
            SizedBox(height: 24.0.h),
            buildOfferCard(
                'https://images.unsplash.com/photo-1521590832167-7bcbfaa6381f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fGJhcmJlcnNob3B8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60',
                '5',
                'Razor Work Fred',
                'QualityTrusted Services.',
                '100',
                '120'
            ),
          ],
        ),
      ),
    );
  }
}
