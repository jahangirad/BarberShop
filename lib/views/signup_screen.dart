import 'dart:io';
import 'package:barber_shop/utils/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../controllers/auth_controller.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _fullName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final SignupController signupController = Get.put(SignupController());

  // লোকাল কালার
  final Color _backgroundColor = Color(0xFF121212);
  final Color _primaryColor = Color(0xFFFDB813);
  final Color _textColor = Colors.white;
  final Color _hintTextColor = Colors.grey;
  final Color _textFieldFillColor = Color(0xFF1E1E1E);

  @override
  void dispose() {
    _passwordController.dispose();
    _phoneController.dispose();
    _fullName.dispose();
    _emailController.dispose();
    super.dispose();
  }

  // Profile image
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
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
        backgroundColor: _backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: _textColor, size: 24.sp),
        title: Text('Create Account', style: TextStyle(color: _textColor, fontSize: 20.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins')),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
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
                    'Join Us Today!',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins'),
                  ),

                  SizedBox(height: 30.h),
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60.r,
                      backgroundColor: _textFieldFillColor,
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? Icon(Icons.camera_alt_outlined, color: _hintTextColor, size: 40.sp)
                          : null,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _fullName,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(hintText: 'Full Name', prefixIconData: Icons.person_outline),
                    validator: (value) => (value == null || value.isEmpty) ? 'Please enter your full name' : null,
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _emailController,
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
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _phoneController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(hintText: 'Phone Number', prefixIconData: Icons.phone_outlined),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter your phone number';
                      if (!RegExp(r"^\+?[0-9]{10,15}$").hasMatch(value)) {
                        return 'Please enter a valid phone number';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    controller: _passwordController,
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(
                      hintText: 'Password',
                      prefixIconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(_passwordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                        onPressed: () => setState(() => _passwordVisible = !_passwordVisible),
                      ),
                    ),
                    obscureText: !_passwordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter a password';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  SizedBox(height: 20.h),
                  TextFormField(
                    style: TextStyle(color: _textColor, fontSize: 16.sp, fontFamily: 'Poppins'),
                    decoration: _textFieldDecoration(
                      hintText: 'Confirm Password',
                      prefixIconData: Icons.lock_outline,
                      suffixIcon: IconButton(
                        icon: Icon(_confirmPasswordVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined, color: _hintTextColor.withOpacity(0.7), size: 22.sp),
                        onPressed: () => setState(() => _confirmPasswordVisible = !_confirmPasswordVisible),
                      ),
                    ),
                    obscureText: !_confirmPasswordVisible,
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please confirm your password';
                      if (value != _passwordController.text) return 'Passwords do not match';
                      return null;
                    },
                  ),
                  SizedBox(height: 40.h),
                  Obx(() => ElevatedButton(
                    onPressed: signupController.isLoading.value
                        ? null
                        : () {
                      if (_formKey.currentState!.validate()) {
                        signupController.signUpUser(
                          _fullName,
                          _emailController,
                          _passwordController,
                          _phoneController,
                          _profileImage
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
                      'Sign Up',
                      style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
                    ),
                  )),
                  SizedBox(height: 25.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Already have an account?", style: TextStyle(color: _hintTextColor, fontSize: 14.sp, fontFamily: 'Poppins')),
                      SizedBox(width: 4.w),
                      TextButton(
                        style: TextButton.styleFrom(foregroundColor: _primaryColor, textStyle: TextStyle(fontWeight: FontWeight.w600, fontFamily: 'Poppins', fontSize: 14.sp)),
                        onPressed: () => Get.offAllNamed(AppRoutes.login),
                        child: Text('Login'),
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