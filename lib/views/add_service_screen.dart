import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AddServiceTab extends StatefulWidget {
  @override
  _AddServiceTabState createState() => _AddServiceTabState();
}

class _AddServiceTabState extends State<AddServiceTab> {
  final _formKey = GlobalKey<FormState>();
  String? _serviceName;
  String? _description;
  double? _price;
  int? _durationMinutes;
  String? _selectedCategory;

  final List<String> _categories = ['Hair Salon', 'Barbershop', 'Makeup', 'Nail Salon', 'Spa', 'Tattoo'];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Simulating data processing
      print('Service Name: $_serviceName');
      print('Description: $_description');
      print('Price: $_price');
      print('Duration: $_durationMinutes minutes');
      print('Category: $_selectedCategory');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Service "${_serviceName}" added successfully! (Simulated)'),
          backgroundColor: Colors.green.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          margin: EdgeInsets.all(10.w),
        ),
      );
      _formKey.currentState!.reset();
      setState(() {
        _selectedCategory = null;
      });
      // Hide keyboard
      FocusScope.of(context).unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Optional: Add an image picker placeholder like in screenshots
            // GestureDetector(
            //   onTap: () { /* Implement image picker */ },
            //   child: Container(
            //     height: 150.h,
            //     decoration: BoxDecoration(
            //       color: Theme.of(context).cardTheme.color,
            //       borderRadius: BorderRadius.circular(10.r),
            //       // border: Border.all(color: Colors.grey.shade700)
            //     ),
            //     child: Column(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Icon(Icons.add_a_photo_outlined, size: 40.sp, color: Colors.white70),
            //         SizedBox(height: 8.h),
            //         Text('Add Service Image', style: TextStyle(color: Colors.white70, fontSize: 14.sp)),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.h),

            _buildTextFormField(
              label: 'Service Name',
              icon: Icons.design_services_outlined, // Changed icon
              validator: (value) => value == null || value.isEmpty ? 'Please enter service name' : null,
              onSaved: (value) => _serviceName = value,
            ),
            SizedBox(height: 16.h),
            _buildTextFormField(
              label: 'Description',
              icon: Icons.notes_outlined, // Changed icon
              maxLines: 3,
              validator: (value) => value == null || value.isEmpty ? 'Please enter a description' : null,
              onSaved: (value) => _description = value,
            ),
            SizedBox(height: 16.h),
            _buildTextFormField(
              label: 'Price (\$)',
              icon: Icons.attach_money_rounded,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter a price';
                if (double.tryParse(value) == null) return 'Please enter a valid number';
                if (double.parse(value) <= 0) return 'Price must be positive';
                return null;
              },
              onSaved: (value) => _price = double.tryParse(value!),
            ),
            SizedBox(height: 16.h),
            _buildTextFormField(
              label: 'Duration (minutes)',
              icon: Icons.timer_outlined,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) return 'Please enter duration';
                if (int.tryParse(value) == null) return 'Please enter a valid number';
                if (int.parse(value) <= 0) return 'Duration must be positive';
                return null;
              },
              onSaved: (value) => _durationMinutes = int.tryParse(value!),
            ),
            SizedBox(height: 16.h),
            _buildDropdownFormField(),
            SizedBox(height: 24.h),
            ElevatedButton(
              onPressed: _submitForm,
              child: Text('Add Service'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFormField({
    required String label,
    required IconData icon,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    void Function(String?)? onSaved,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20.sp),
      ),
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      onSaved: onSaved,
      cursorColor: Theme.of(context).hintColor,
    );
  }

  Widget _buildDropdownFormField() {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: 'Category',
        prefixIcon: Icon(Icons.category_outlined, size: 20.sp),
      ),
      dropdownColor: Color(0xFF3A3A3A), // Slightly different dark for dropdown menu
      style: TextStyle(color: Colors.white, fontSize: 16.sp),
      icon: Icon(Icons.arrow_drop_down_rounded, color: Colors.white.withOpacity(0.7)),
      value: _selectedCategory,
      items: _categories.map((String category) {
        return DropdownMenuItem<String>(
          value: category,
          child: Text(category),
        );
      }).toList(),
      onChanged: (value) {
        setState(() {
          _selectedCategory = value;
        });
      },
      validator: (value) => value == null ? 'Please select a category' : null,
      onSaved: (value) => _selectedCategory = value,
    );
  }
}