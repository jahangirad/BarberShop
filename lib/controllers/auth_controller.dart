import 'dart:io';
import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/route.dart';

class SignupController extends GetxController {
  final isLoading = false.obs;

  final String adminEmail = 'jahangirad14@gmail.com';

  Future<void> signUpUser(
      TextEditingController nameController,
      TextEditingController emailController,
      TextEditingController passwordController,
      TextEditingController phoneController,
      File? profileImage,
      ) async {
    try {
      isLoading.value = true;
      final String userEmail = emailController.text.trim(); // Store email for check

      // Sign up the user
      final response = await Supabase.instance.client.auth.signUp(
        email: userEmail,
        password: passwordController.text.trim(),
      );

      if (response.user != null) {
        String? imageUrl;

        // Upload profile image if available
        if (profileImage != null) {
          // Generate random file name using path package's extension method
          final fileExtension = p.extension(profileImage.path);
          final fileName =
              'userimages/${DateTime.now().millisecondsSinceEpoch}$fileExtension';

          try {
            // Upload the image
            await Supabase.instance.client.storage
                .from('userimages')
                .upload(fileName, profileImage);

            // Get the public URL of the uploaded image
            imageUrl = Supabase.instance.client.storage
                .from('userimages')
                .getPublicUrl(fileName);

            print('✅ Image uploaded successfully: $imageUrl');
          } catch (e) {
            print('❌ Image upload failed: $e');
            // Optionally rethrow or handle more gracefully
            // For now, we'll let it proceed without an image if upload fails,
            // but you might want to stop the signup or inform the user.
          }
        }

        // Insert user data into the 'userprofile' table
        await Supabase.instance.client.from('userprofile').upsert({
          'uid': response.user!.id,
          'name': nameController.text.trim(),
          'email': userEmail, // Use the stored email
          'phone': phoneController.text.trim(),
          'avatar': imageUrl ?? '',
        });

        // Clear text fields
        nameController.clear();
        emailController.clear();
        passwordController.clear();
        phoneController.clear();

        // Conditional navigation
        // response.user!.email could also be used here if preferred
        if (userEmail.toLowerCase() == adminEmail) {
          Get.offAllNamed(AppRoutes.dashboard); // Dashboard-e redirect
          Get.snackbar(
            'Welcome Admin',
            'Successfully signed up and logged in.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.offAllNamed(AppRoutes.home); // Home-e redirect
          Get.snackbar(
            'Success',
            'Successfully signed up and logged in.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle case where response.user is null but no error was thrown (unlikely for signUp)
        Get.snackbar(
          'Error',
          'Sign up failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (e is AuthException) {
        errorMessage = e.message;
      }
      Get.snackbar(
        'Error Signing Up',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      print('❌ SignUp Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Login function
  Future<void> loginUser(
      TextEditingController emailController,
      TextEditingController passwordController) async {
    try {
      isLoading.value = true;
      final String userEmail = emailController.text.trim(); // Store email for check

      final response = await Supabase.instance.client.auth.signInWithPassword(
        email: userEmail,
        password: passwordController.text.trim(),
      );

      if (response.user != null) {
        print('✅ Login successful: ${response.user!.email}');

        // Clear text fields
        emailController.clear();
        passwordController.clear();

        // Conditional navigation
        // response.user!.email could also be used here
        if (userEmail.toLowerCase() == adminEmail) {
          Get.offAllNamed(AppRoutes.dashboard); // Dashboard-e redirect
          Get.snackbar(
            'Welcome Admin',
            'Successfully logged in.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        } else {
          Get.offAllNamed(AppRoutes.home); // Home-e redirect
          Get.snackbar(
            'Success',
            'Successfully logged in.',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
        }
      } else {
        // Handle case where response.user is null but no error was thrown (unlikely for signInWithPassword)
        Get.snackbar(
          'Error',
          'Login failed. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      String errorMessage = e.toString();
      if (e is AuthException) {
        errorMessage = e.message;
      }
      Get.snackbar(
        'Error Logging In',
        errorMessage,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
      print('❌ Login Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Logout function
  Future<void> logoutUser() async {
    try {
      await Supabase.instance.client.auth.signOut();
      Get.offAllNamed(AppRoutes.login);
      print('✅ User logged out successfully');
    } catch (e) {
      print('❌ Logout failed: $e');
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      isLoading.value = true;

      // Send password reset email
      await Supabase.instance.client.auth.resetPasswordForEmail(
        email.trim(),
        redirectTo: 'barbershop://reset-password',
      );

      // Show success message
      Get.snackbar(
        'Success',
        'Password reset link has been sent to your email.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      // Show error message
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    diplinkConfig(Get.context!);
  }

  diplinkConfig(BuildContext context) {
    final applinks = AppLinks();

    applinks.uriLinkStream.listen((uri) {
      if (uri.scheme == 'barbershop' && uri.host == 'reset-password') {
        print('✅ Deep link detected: $uri');
        Get.offAllNamed(AppRoutes.resetPassword);
      } else {
        print('❌ Unsupported deep link: $uri');
      }
    }, onError: (err) {
      print('❌ Error in deep link handling: $err');
    });
  }


  // Update the password
  Future<void> updatePassword(String newPassword) async {
    try {
      isLoading.value = true;

      final response = await Supabase.instance.client.auth.updateUser(
        UserAttributes(password: newPassword.trim()),
      );

      if (response.user != null) {
        Get.snackbar(
          'Success',
          'Password updated successfully.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
        Get.offAllNamed(AppRoutes.login);
      } else {
        throw Exception('Failed to update password');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
