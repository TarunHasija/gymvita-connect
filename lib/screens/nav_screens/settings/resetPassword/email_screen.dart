import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/components/custom_txt_button.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class EmailScreen extends StatelessWidget {
  final ProfileController controller;

  const EmailScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(
          textEditingController: controller.resetPasEmailController,
          hintText: 'Enter your email',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an email';
            }
            String emailPattern =
                r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,})+$';
            RegExp regex = RegExp(emailPattern);

            if (!regex.hasMatch(value)) {
              return 'Please enter a valid email';
            }
            return null; // Valid input
          },
        ),
        Gap(30.h),
        CustomTextButton(
          height: 50.h,
          bgColor: accent,
          btnOnTap: () async {
            if (controller.resetPasEmailController.text.isNotEmpty &&
                RegExp(r'^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(\.[a-zA-Z]{2,})+$')
                    .hasMatch(controller.resetPasEmailController.text)) {
              // Await the result of checkUserExists
              bool userExists = await controller
                  .checkUserExists(controller.resetPasEmailController.text);

              if (userExists) {
                await controller.sendOtpForPassword(
                    controller.resetPasEmailController.text);

                controller.pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                Get.snackbar("User Not Found",
                    "User for this email doesn't exist, please contact the gym owner");
              }
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Please enter a valid email',
                    style: TextStyle(fontSize: 16.sp, color: white),
                  ),
                  backgroundColor: secondary,
                ),
              );
            }
          },
          buttonText: 'SEND OTP',
        ),
      ],
    );
  }
}
