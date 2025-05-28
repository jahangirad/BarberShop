import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      children: <Widget>[
        _buildSupportItem(
          context: context,
          icon: Icons.quiz_outlined,
          title: 'FAQ',
          subtitle: 'Find answers to common questions',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('FAQ page (Not Implemented)')));
          },
        ),
        _buildSupportItem(
          context: context,
          icon: Icons.contact_support_outlined,
          title: 'Contact Us',
          subtitle: 'Get in touch with our support team',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Contact Us (Not Implemented)')));
          },
        ),
        _buildSupportItem(
          context: context,
          icon: Icons.article_outlined, // For 'Submit a Ticket'
          title: 'Submit a Ticket',
          subtitle: 'Report an issue or request assistance',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Submit Ticket (Not Implemented)')));
          },
        ),
        _buildSupportItem(
          context: context,
          icon: Icons.policy_outlined,
          title: 'Terms & Conditions',
          subtitle: 'Read our terms of service',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Terms & Conditions (Not Implemented)')));
          },
        ),
        _buildSupportItem(
          context: context,
          icon: Icons.privacy_tip_outlined,
          title: 'Privacy Policy',
          subtitle: 'Understand how we handle your data',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Privacy Policy (Not Implemented)')));
          },
        ),
      ],
    );
  }

  Widget _buildSupportItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
      child: ListTile( // Uses ListTileTheme from main.dart
        leading: Icon(icon, size: 24.sp),
        title: Text(
          title,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 13.sp, color: Colors.white.withOpacity(0.7)),
        ),
        trailing: Icon(Icons.chevron_right_rounded, color: Colors.white.withOpacity(0.5), size: 24.sp),
        onTap: onTap,
        contentPadding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 16.w),
      ),
    );
  }
}