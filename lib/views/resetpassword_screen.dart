import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  _ResetPasswordScreenState createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _newPasswordVisible = false;
  bool _confirmNewPasswordVisible = false;
  final TextEditingController _newPasswordController = TextEditingController();
  final SignupController signupController = Get.put(SignupController());

  final Color _backgroundColor = Color(0xFF121212);
  final Color _primaryColor = Color(0xFFFDB813);
  final Color _textColor = Colors.white;
  final Color _hintTextColor = Colors.grey;
  final Color _textFieldFillColor = Color(0xFF1E1E1E);

  @override
  void dispose() {
    _newPasswordController.dispose();
    super.dispose();
  }

  InputDecoration _textFieldDecoration({required String hintText, IconData? prefixIconData, Widget? suffixIcon}) {
    return InputDecoration(
      filled: true,
      fillColor: _textFieldFillColor,
      hintText: hintText,
      hintStyle: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins'),
      prefixIcon: prefixIconData != null ? Icon(prefixIconData, color: _hintTextColor.withOpacity(0.7), size: 22.sp) : null,
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide.none),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: _primaryColor, width: 1.5.w)),
      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: Colors.redAccent, width: 1.0.w)),
      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: Colors.redAccent, width: 1.5.w)),
      contentPadding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        backgroundColor: _backgroundColor, elevation: 0,
        iconTheme: IconThemeData(color: _textColor, size: 24.sp),
        title: Text('Reset Password', style: TextStyle(color: _textColor, fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: () => Navigator.of(context).pop()),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.0.w),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    'Create a new strong password for your account.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _hintTextColor, fontSize: 14.sp, height: 1.5.h, fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    controller: _newPasswordController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(
                      hintText: 'New Password',
                      prefixIconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(_newPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                        onPressed: () => setState(() => _newPasswordVisible = !_newPasswordVisible),
                      ),
                    ),
                    obscureText: !_newPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter a new password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(
                      hintText: 'Confirm New Password',
                      prefixIconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(_confirmNewPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                        onPressed: () => setState(() => _confirmNewPasswordVisible = !_confirmNewPasswordVisible),
                      ),
                    ),
                    obscureText: !_confirmNewPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your new password';
                      if (value != _newPasswordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  Obx(() => ElevatedButton(
                    onPressed: signupController.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        signupController.updatePassword(
                            _newPasswordController.text
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryColor,
                      foregroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 16.0.h),
                      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0.r)),
                      minimumSize: Size(double.infinity, 50.h),
                    ),
                    child: signupController.isLoading.value
                        ? CircularProgressIndicator(color: Colors.black)
                        : Text(
                      'Reset Password',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}