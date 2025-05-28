import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../controllers/provider_service_controller.dart';

class AddServiceTab extends StatelessWidget {
  final controller = Get.put(ProviderServiceController());

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final subtitleController = TextEditingController();
  final descriptionController = TextEditingController();
  final ratingController = TextEditingController();
  final priceController = TextEditingController();
  final comparePriceController = TextEditingController();
  final durationController = TextEditingController();

  final selectedProviderUid = ''.obs;

  final Color _primaryColor = const Color(0xFFFDB813); // Glamii Red

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Image Picker
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  children: [
                    Obx(() => controller.selectedImage.value != null
                        ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.file(
                        controller.selectedImage.value!,
                        height: 180.h,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                        : SizedBox(
                      height: 180.h,
                      child: Center(
                        child: Text(
                          'No image selected',
                          style: TextStyle(
                              color: Colors.grey, fontSize: 14.sp),
                        ),
                      ),
                    )),
                    SizedBox(height: 10.h),
                    ElevatedButton.icon(
                      onPressed: controller.pickImage,
                      icon: const Icon(Icons.image),
                      label: const Text("Pick Service Image"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(
                            vertical: 12.h, horizontal: 16.w),
                        textStyle: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        minimumSize: Size(double.infinity, 45.h),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20.h),
              _buildTextField(nameController, "Service Name"),
              _buildTextField(subtitleController, "Subtitle"),
              _buildTextField(ratingController, "Rating", isNumber: true),
              _buildTextField(priceController, "Price", isNumber: true),
              _buildTextField(comparePriceController, "Compare Price",
                  isNumber: true),
              _buildTextField(durationController, "Duration (minutes)",
                  isNumber: true),

              const SizedBox(height: 16),

              // Provider Dropdown
              Obx(() => DropdownButtonFormField<String>(
                value: selectedProviderUid.value.isEmpty
                    ? null
                    : selectedProviderUid.value,
                hint: const Text("Select Provider"),
                items: controller.provider
                    .map((prov) => DropdownMenuItem<String>(
                  value: prov['uid'],
                  child: Text(prov['name']),
                ))
                    .toList(),
                onChanged: (val) => selectedProviderUid.value = val!,
                validator: (val) =>
                val == null ? 'Please select provider' : null,
                decoration:
                const InputDecoration(border: OutlineInputBorder()),
              )),

              SizedBox(height: 24.h),

              // Submit Button
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value
                    ? null
                    : () {
                  if (_formKey.currentState!.validate() &&
                      controller.selectedImage.value != null) {
                    controller.addService(
                      name: nameController.text,
                      subtitle: subtitleController.text,
                      rating: ratingController.text,
                      price: priceController.text,
                      comparePrice:
                      comparePriceController.text,
                      duration: durationController.text,
                      providerUid: selectedProviderUid.value,
                      image: controller.selectedImage.value!,
                    );
                  } else {
                    Get.snackbar("Missing Info",
                        "Please fill all fields and select an image");
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _primaryColor,
                  foregroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  textStyle: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                  minimumSize: Size(double.infinity, 50.h),
                ),
                child: controller.isLoading.value
                    ? const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.black,
                    strokeWidth: 2.5,
                  ),
                )
                    : Text(
                  "Submit Service",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isNumber = false}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
            labelText: label, border: const OutlineInputBorder()),
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        validator: (val) =>
        val == null || val.isEmpty ? 'Required field' : null,
      ),
    );
  }
}
