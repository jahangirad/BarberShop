import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/route.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  final Color _backgroundColor = Color(0xFF121212);
  final Color _primaryColor = Color(0xFFFDB813);
  final Color _textColor = Colors.white;
  final Color _hintTextColor = Colors.grey;
  final Color _textFieldFillColor = Color(0xFF1E1E1E);

  final SignupController signupController = Get.put(SignupController());
  final TextEditingController emailController = TextEditingController();

  InputDecoration _textFieldDecoration({required String hintText, IconData? prefixIconData}) {
    return InputDecoration(
      filled: true,
      fillColor: _textFieldFillColor,
      hintText: hintText,
      hintStyle: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins'),
      prefixIcon: prefixIconData != null ? Icon(prefixIconData, color: _hintTextColor.withOpacity(0.7), size: 22.sp) : null,
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
        title: Text('Forgot Password', style: TextStyle(color: _textColor, fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back_rounded), onPressed: () => Get.offAllNamed(AppRoutes.login)),
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
                    'Enter the email address associated with your account. We will send you a link to reset your password.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _hintTextColor, fontSize: 14.sp, height: 1.5.h, fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(hintText: 'Email', prefixIconData: Icons.email_outlined),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  Obx(() => ElevatedButton(
                    onPressed: signupController.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        signupController.sendPasswordResetEmail(
                          emailController.text
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
                      'Sent Reset Link',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  )),
                  SizedBox(height: 25.h),
                  TextButton(
                    style: TextButton.styleFrom(foregroundColor: _primaryColor, textStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14.sp)),
                    onPressed: () => Get.offAllNamed(AppRoutes.login),
                    child: Text('Back to Login'),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}