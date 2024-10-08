import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/controllers/analysis_form.dart';
import 'package:gymvita_connect/utils/colors.dart';

class AnalysisForm extends StatelessWidget {

  final MonthlyAnalysisController analysisController = Get.put(MonthlyAnalysisController());
  final _formKey = GlobalKey<FormState>();

  AnalysisForm({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Monthly Analysis Form', style: GoogleFonts.poppins(fontSize: 16.sp)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildInputField(theme, analysisController.weightController, 'Weight (Kg)', 'Enter your weight'),
              _buildInputField(theme, analysisController.heightController, 'Height (cm)', 'Enter your height'),
              _buildInputField(theme, analysisController.bicepController, 'Bicep (cm)', 'Enter your bicep size'),
              _buildInputField(theme, analysisController.hipsController, 'Hips (cm)', 'Enter your hip size'),
              _buildInputField(theme, analysisController.thighsController, 'Thighs (cm)', 'Enter your thigh size'),
              _buildInputField(theme, analysisController.waistController, 'Waist (cm)', 'Enter your waist size'),
              _buildInputField(theme, analysisController.chestController, 'Chest (cm)', 'Enter your chest size'),
              _buildInputField(theme, analysisController.tricepController, 'Tricep (cm)', 'Enter your tricep size'),

              const SizedBox(height: 20),

              // Submit button and status message
              Obx(() {
                return analysisController.canSubmit.value
                    ? SizedBox(
                        height: 55.h,
                        width: double.infinity,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: accent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          onPressed: _submitForm,
                          child: Text(
                            "Save",
                            style: TextStyle(
                              color: black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : const Text('Data submitted for this month.');
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create form fields
  Widget _buildInputField(TextTheme theme, TextEditingController controller, String label, String hint) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 1.2.h, color: secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: secondary),
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: label,
          hintText: hint,
          hintStyle: theme.labelLarge?.copyWith(color: const Color.fromARGB(255, 179, 179, 179)),
        ),
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $label';
          }
          return null;
        },
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      analysisController.submitAnalysis(
        weight: double.parse(analysisController.weightController.text),
        height: double.parse(analysisController.heightController.text),
        bicep: double.parse(analysisController.bicepController.text),
        hips: double.parse(analysisController.hipsController.text),
        thighs: double.parse(analysisController.thighsController.text),
        waist: double.parse(analysisController.waistController.text),
        chest: double.parse(analysisController.chestController.text),
        tricep: double.parse(analysisController.tricepController.text),
      );
    }
  }
}
