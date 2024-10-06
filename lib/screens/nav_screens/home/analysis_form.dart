import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gymvita_connect/utils/colors.dart';

class AnalysisForm extends StatefulWidget {
  const AnalysisForm({super.key});

  @override
  State<AnalysisForm> createState() => _AnalysisFormState();
}

class _AnalysisFormState extends State<AnalysisForm> {
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController bicepController = TextEditingController();
  final TextEditingController hipsController = TextEditingController();
  final TextEditingController thighsController = TextEditingController();
  final TextEditingController waistController = TextEditingController();
  final TextEditingController chestController = TextEditingController();
  final TextEditingController tricepController = TextEditingController();

  String weightUnit = 'Kg';
  String heightUnit = 'Inches';
  String bicepUnit = 'Inches';
  String hipsUnit = 'Inches';
  String thighsUnit = 'Inches';
  String waistUnit = 'Inches';
  String chestUnit = 'Inches';
  String tricepUnit = 'Inches';

  final _formKey = GlobalKey<FormState>();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      print('Weight: ${weightController.text} $weightUnit');
      print('Height: ${heightController.text} $heightUnit');
      print('Bicep: ${bicepController.text} $bicepUnit');
      print('Hips: ${hipsController.text} $hipsUnit');
      print('Thighs: ${thighsController.text} $thighsUnit');
      print('Waist: ${waistController.text} $waistUnit');
      print('Chest: ${chestController.text} $chestUnit');
      print('Tricep: ${tricepController.text} $tricepUnit');
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        centerTitle: true,
        title: Text(
          'Profile',
          style: GoogleFonts.righteous(
            textStyle: theme.displayMedium?.copyWith(fontSize: 24.sp),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              AnalysisField(
                hintText: 'Weight (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Height (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Bicep (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Hip (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Thigh (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Waist (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Chest (Required)',
                controller: weightController,
                selectedUnit: 'Kg', 
              ),
              AnalysisField(
                hintText: 'Tricep (Required)',
                controller: weightController,
                selectedUnit: 'Kg',
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    onPressed: submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: accent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Text(
                      'Submit',
                      style: theme.bodyMedium?.copyWith(fontSize: 18.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnalysisField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final String selectedUnit; 
  const AnalysisField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.selectedUnit,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: SizedBox(
              height: 80.h,
              child: TextFormField(
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'This field is required';
                  }
                  final double? number = double.tryParse(value);
                  if (number == null) {
                    return 'Enter a valid number';
                  }
                  return null;
                },
                style: theme.bodyMedium?.copyWith(
                  fontSize: 14.sp,
                  color: const Color.fromARGB(255, 184, 184, 184),
                ),
                cursorColor: white,
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
                  hintText: hintText,
                  hintStyle: theme.labelLarge?.copyWith(
                    color: const Color.fromARGB(255, 179, 179, 179),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            decoration: BoxDecoration(
              border: Border.all(color: secondary),
              color: primary,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              selectedUnit, 
              style: theme.labelLarge?.copyWith(
                color: const Color.fromARGB(255, 179, 179, 179),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
