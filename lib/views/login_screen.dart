import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/auth_controller.dart';
import '../utils/route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;

  // কালারগুলো লোকালি ডিফাইন করা হচ্ছে কারণ গ্লোবাল কনস্ট্যান্ট ব্যবহার করা হচ্ছে না
  final Color _backgroundColor = Color(0xFF121212);
  final Color _primaryColor = Color(0xFFFDB813);
  final Color _textColor = Colors.white;
  final Color _hintTextColor = Colors.grey;
  final Color _textFieldFillColor = Color(0xFF1E1E1E);

  final SignupController signupController = Get.put(SignupController());
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
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
                    'Welcome Back!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28.sp,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'Login to your account',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: _hintTextColor,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins'),
                  ),
                  SizedBox(height: 40.h),
                  TextFormField(
                    controller: emailController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _textFieldFillColor,
                      hintText: 'Email',
                      hintStyle: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins'),
                      prefixIcon: Icon(Icons.email_outlined, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: BorderSide(color: _primaryColor, width: 1.5.w),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.0.w),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0.r),
                        borderSide: BorderSide(color: Colors.redAccent, width: 1.5.w),
                      ),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your email';
                      if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: passwordController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: _textFieldFillColor,
                      hintText: 'Password',
                      hintStyle: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins'),
                      prefixIcon: Icon(Icons.lock_outline, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                          color: _hintTextColor.withOpacity(0.7), size: 22.sp,
                        ),
                        onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                      ),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: _primaryColor, width: 1.5.w)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: Colors.redAccent, width: 1.0.w)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0.r), borderSide: BorderSide(color: Colors.redAccent, width: 1.5.w)),
                      contentPadding: EdgeInsets.symmetric(vertical: 16.0.h, horizontal: 16.0.w),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your password';
                      return null;
                    },
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: _primaryColor,
                        textStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14.sp),
                      ),
                      onPressed: () => Get.offAllNamed(AppRoutes.forgotPassword),
                      child: Text('Forgot Password?'),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Obx(() => ElevatedButton(
                    onPressed: signupController.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        signupController.loginUser(
                            emailController,
                            passwordController
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
                      'Login',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  )),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Don't have an account?", style: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins')),
                      SizedBox(width: 4.w),
                      TextButton(
                        style: TextButton.styleFrom(
                          foregroundColor: _primaryColor,
                          textStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14.sp),
                        ),
                        onPressed: () => Get.offAllNamed(AppRoutes.signup),
                        child: Text('Sign Up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}