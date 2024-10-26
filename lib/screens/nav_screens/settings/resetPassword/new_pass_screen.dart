import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/components/custom_txt_button.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class NewPasswordScreen extends StatelessWidget {
  final ProfileController controller;

  const NewPasswordScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController =
        TextEditingController();
    final UserController userController = Get.find<UserController>();

    // Password validation pattern
    String passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    RegExp regex = RegExp(passwordPattern);

    return Column(
      children: [
        CustomTextField(
          readonly: false,
          textEditingController: newPasswordController,
          hintText: 'Enter new password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password.';
            } else if (!regex.hasMatch(value)) {
              return 'Password must contain uppercase, lowercase, numbers, and special characters.';
            }
            return null; // Valid input
          },
        ),
        Gap(30.h),
        CustomTextField(
          readonly: false,
          textEditingController: confirmPasswordController,
          hintText: 'Confirm password',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password.';
            } else if (value != newPasswordController.text) {
              return 'Passwords do not match.';
            }
            return null; // Valid input
          },
        ),
        Gap(30.h),
        CustomTextButton(
          height: 50.h,
          bgColor: accent,
          btnOnTap: () {
            // Validate the fields
            final newPasswordError = newPasswordController.text.isEmpty || !regex.hasMatch(newPasswordController.text);
            final confirmPasswordError = confirmPasswordController.text.isEmpty || confirmPasswordController.text != newPasswordController.text;

            if (newPasswordError) {
              Get.snackbar('Error', 'Please enter a valid password.');
            } else if (confirmPasswordError) {
              Get.snackbar('Error', 'Passwords do not match.');
            } else {
              // Proceed to reset the password
              controller.resetPassword(
                userController.userDocSnap.value?['email'],
                newPasswordController.text,
                confirmPasswordController.text,
              );
              Get.snackbar('Success', 'Password reset successfully.');
            }
          },
          buttonText: "Reset password",
        ),
      ],
    );
  }
}
