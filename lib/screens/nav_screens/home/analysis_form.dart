import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/analysis_form.dart';

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

  final MonthlyAnalysisController analysisController =
      Get.put(MonthlyAnalysisController(userId: 'USER_ID')); // Replace with actual user ID

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monthly Analysis Form'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Form fields for input
              _buildInputField(weightController, 'Weight (Kg)', 'Enter your weight'),
              _buildInputField(heightController, 'Height (cm)', 'Enter your height'),
              _buildInputField(bicepController, 'Bicep (cm)', 'Enter your bicep size'),
              _buildInputField(hipsController, 'Hips (cm)', 'Enter your hip size'),
              _buildInputField(thighsController, 'Thighs (cm)', 'Enter your thigh size'),
              _buildInputField(waistController, 'Waist (cm)', 'Enter your waist size'),
              _buildInputField(chestController, 'Chest (cm)', 'Enter your chest size'),
              _buildInputField(tricepController, 'Tricep (cm)', 'Enter your tricep size'),
              
              const SizedBox(height: 20),

              // Submit button and status message
              Obx(() {
                return analysisController.canSubmit.value
                    ? ElevatedButton(
                        onPressed: _submitForm,
                        child: const Text('Submit Analysis'),
                      )
                    : const Text('You have already submitted for this month.');
              }),
            ],
          ),
        ),
      ),
    );
  }

  // Helper function to create form fields
  Widget _buildInputField(TextEditingController controller, String label, String hint) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          border: const OutlineInputBorder(),
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

  // Submit form data to Firestore
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      analysisController.submitAnalysis(
        weight: double.parse(weightController.text),
        height: double.parse(heightController.text),
        bicep: double.parse(bicepController.text),
        hips: double.parse(hipsController.text),
        thighs: double.parse(thighsController.text),
        waist: double.parse(waistController.text),
        chest: double.parse(chestController.text),
        tricep: double.parse(tricepController.text),
      );
    }
  }
}
