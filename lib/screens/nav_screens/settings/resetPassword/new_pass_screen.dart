import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/custom_txt_button.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class NewPasswordScreen extends StatelessWidget {
  final ProfileController controller;

  const NewPasswordScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();

    // Password validation pattern
    String passwordPattern = r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(passwordPattern);

    return Column(
      children: [
        CustomTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password.';
            } else if (!regex.hasMatch(value)) {
              return 'Password must contain uppercase, lowercase, numbers, and special characters.';
            }
            return null; // Valid input
          },
          textEditingController: newPasswordController,
          hintText: 'Enter new password',
        ),
        Gap(30.h),
        CustomTextField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password.';
            } else if (value != newPasswordController.text) {
              return 'Passwords do not match.';
            }
            return null; // Valid input
          },
          textEditingController: confirmPasswordController,
          hintText: 'Confirm password',
        ),
        Gap(30.h),
        CustomTextButton(
          height: 50.h,
          bgColor: accent,
          btnOnTap: () {
            // Validate and call the reset password function
            if (newPasswordController.text == confirmPasswordController.text) {
              controller.resetPassword(newPasswordController.text, confirmPasswordController.text);
              Get.snackbar('Success', 'Password reset successfully.');
            } else {
              Get.snackbar('Error', 'Passwords do not match.');
            }
          },
          buttonText: "Reset password",
        )
      ],
    );
  }
}
