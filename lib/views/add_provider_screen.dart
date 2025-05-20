import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controllers/provider_service_controller.dart';

class AddProviderScreen extends StatefulWidget {
  const AddProviderScreen({super.key});

  @override
  State<AddProviderScreen> createState() => _AddProviderScreenState();
}

class _AddProviderScreenState extends State<AddProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  final Color _primaryColor = Color(0xFFFDB813);
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ProviderServiceController providerServiceController = Get.put(ProviderServiceController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Provider Name',
                prefixIcon: Icon(Icons.design_services_outlined, size: 20.sp),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              keyboardType: TextInputType.text,
              maxLines: 1,
              validator: (value){
                if(value == null || value.isEmpty ){
                  return 'Please enter provider name';
                }
              },
            ),
            SizedBox(height: 16.h),
            TextFormField(
              controller: phoneController,
              decoration: InputDecoration(
                labelText: 'Provider Number',
                prefixIcon: Icon(Icons.phone, size: 20.sp),
              ),
              style: TextStyle(color: Colors.white, fontSize: 16.sp),
              keyboardType: TextInputType.text,
              maxLines: 1,
              validator: (value){
                if(value == null || value.isEmpty ){
                  return 'Please enter provider number';
                }
              },
            ),
            SizedBox(height: 24.h),
            Obx(() => ElevatedButton(
              onPressed: providerServiceController.isLoading.value
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  providerServiceController.addProvider(
                      nameController,
                      phoneController
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
              child: providerServiceController.isLoading.value
                  ? CircularProgressIndicator(color: Colors.black)
                  : Text(
                'Login',
                style: TextStyle(color: Colors.black, fontSize: 16.sp, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
