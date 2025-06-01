import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../controllers/auth_fetch_controller.dart';
import '../utils/route.dart';

// Stateful widget e convert korle initState e fetch kora subidha
class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  // Access the UserService instance
  final UserService userService = Get.put(UserService());
  final SignupController signupController = Get.put(SignupController());

  @override
  void initState() {
    super.initState();
    // Fetch user data when the screen initializes if it's not already loaded
    // You might add a check inside fetchCurrentUser or here to avoid redundant calls
    userService.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white, size: 24.sp),
          onPressed: () {
            Get.offAllNamed(AppRoutes.home);
          },
        ),
        title: Text(
          'Account',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // --- Profile Section (Reactive) ---
            Obx(() { // Wrap the part that depends on userData with Obx
              // Check if data is available
              if (userService.userData.isEmpty) {
                // Show loading state or default placeholder
                return Column(
                  children: [
                    CircleAvatar(
                      radius: 45.r,
                      backgroundColor: Colors.grey[800],
                      child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                    ),
                    SizedBox(height: 12.h),
                    Text('Loading...', style: TextStyle(fontSize: 18.sp, color: Colors.white)),
                    SizedBox(height: 4.h),
                    Text('...', style: TextStyle(fontSize: 14.sp, color: Colors.grey[400])),
                  ],
                );
              } else {
                // Data is available, display it
                // IMPORTANT: Replace 'full_name', 'email', 'avatar_url' with your actual column names from Supabase 'userprofile' table
                String name = userService.userData['name'] ?? 'N/A'; // Use your actual name column
                String email = userService.userData['email'] ?? 'N/A'; // Use your actual email column
                String? avatarUrl = userService.userData['avatar']; // Use your actual avatar column (nullable)

                return Column(
                  children: [
                    CircleAvatar(
                      radius: 45.r,
                      backgroundColor: Colors.grey[800], // Fallback background
                      backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                          ? NetworkImage(avatarUrl)
                          : null, // Load network image if URL exists
                      child: (avatarUrl == null || avatarUrl.isEmpty)
                          ? Icon(Icons.person, size: 40.r, color: Colors.white70) // Show icon if no avatar
                          : null,
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[400],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                );
              }
            }),
            SizedBox(height: 35.h), // Section spacing

            // --- Account Setting Section Title ---
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Account Setting',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[300],
                ),
              ),
            ),
            SizedBox(height: 15.h),

            // --- Settings List ---
            // ... (Rest of your _buildSettingsItem calls remain the same) ...
            _buildSettingsItem(
              context: context,
              icon: Icons.brightness_6_outlined,
              title: 'Themes',
              subtitle: 'Dark & Light',
              onTap: () => _showThemeDialog(context),
            ),
            _buildSettingsItem(
              context: context,
              icon: Icons.person_outline,
              title: 'Account Details',
              onTap: () {
                Get.offAllNamed(AppRoutes.accountdetails);
              },
            ),
            _buildSettingsItem(
              context: context,
              icon: Icons.call_outlined,
              title: 'Support',
              onTap: () {
                Get.offAllNamed(AppRoutes.support);
              },
            ),
            _buildSettingsItem(
              context: context,
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              onTap: () {
                Get.offAllNamed(AppRoutes.privacy);
              },
            ),
            _buildSettingsItem(
              context: context,
              icon: Icons.info_outline,
              title: 'About',
              onTap: () {
                Get.offAllNamed(AppRoutes.about);
              },
            ),


            SizedBox(height: 30.h),

            // --- Logout Button ---
            ElevatedButton.icon(
              onPressed: () {
                signupController.logoutUser();
              },
              icon: Icon(Icons.logout, size: 20.sp, color: Colors.redAccent),
              label: Text(
                'Logout',
                style: TextStyle(fontSize: 16.sp, color: Colors.redAccent),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[900]?.withOpacity(0.8),
                foregroundColor: Colors.redAccent,
                minimumSize: Size(double.infinity, 50.h),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(color: Colors.grey[800]!, width: 1.w)
                ),
                elevation: 0,
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // --- Helper Widgets (_buildSettingsItem, _showThemeDialog, _showLogoutConfirmationDialog) ---
  // ... Keep these helper functions as they were ...
  // Helper widget function for creating setting list items consistently
  Widget _buildSettingsItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    String? subtitle, // Optional subtitle
    required VoidCallback onTap,
  }) {
    return InkWell( // Make the row tappable
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r), // Match shape for ripple effect
      child: Container(
        margin: EdgeInsets.only(bottom: 12.h), // Space between items
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.grey[900]?.withOpacity(0.8), // Dark background for item
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white70, size: 22.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null) ...[ // Conditionally add subtitle
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[400],
                      ),
                    ),
                  ]
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios, // Chevron icon
              color: Colors.grey[600],
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }

  // Example: Show Theme Selection Dialog
  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Select Theme", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.brightness_5, color: Colors.white70, size: 22.sp),
                title: Text("Light Mode", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                onTap: () {
                  // TODO: Implement Light Theme logic
                  print("Light theme selected");
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: Icon(Icons.brightness_2, color: Colors.white70, size: 22.sp),
                title: Text("Dark Mode", style: TextStyle(color: Colors.white, fontSize: 15.sp)),
                onTap: () {
                  // TODO: Implement Dark Theme logic (already dark, maybe confirmation)
                  print("Dark theme selected");
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Example: Show Logout Confirmation Dialog
  void _showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: Text("Confirm Logout", style: TextStyle(color: Colors.white, fontSize: 18.sp)),
          content: Text("Are you sure you want to log out?", style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel", style: TextStyle(color: Colors.grey[400])),
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
            ),
            TextButton(
              child: const Text("Logout", style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                // TODO: Perform actual logout action
                print("Performing logout...");
                // Example: Call a logout method from your UserService or Auth service
                // Get.find<AuthService>().logout();
                Navigator.of(context).pop(); // Close dialog
              },
            ),
          ],
        );
      },
    );
  }

} // End of _AccountScreenState