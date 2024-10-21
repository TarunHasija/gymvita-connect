import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/custom_txt_button.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class OTPScreen extends StatelessWidget {
  final ProfileController controller;

  const OTPScreen(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        CustomTextField(
          textEditingController: controller.otpController,
          hintText: 'Enter Otp',
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter an OTP';
            }
            String otpPattern = r'^\d{6}$';
            RegExp otpRegex = RegExp(otpPattern);

            if (!otpRegex.hasMatch(value)) {
              return 'Please enter a valid OTP';
            }
            return null;
          },
        ),
        Gap(30.h),
        CustomTextButton(
            height: 50.h,
            bgColor: accent,
            btnOnTap: () async {
              await controller
                  .verifyOtpToResetPassword(controller.otpController.text);
              
            },
            buttonText: "Verify otp"),
        Gap(30.h),
        Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: controller.isResendAllowed.value
                      ? () async {
                          controller.sendOtpForPassword(
                              controller.resetPasEmailController.text);
                        }
                      : null,
                  child: Text(
                    'Resend OTP',
                    style: textTheme.bodySmall?.copyWith(color: accent),
                  ),
                ),
                Text(
                  controller.isResendAllowed.value
                      ? ''
                      : ' in ${controller.resendTimer.value} seconds',
                  style: textTheme.bodySmall,
                ),
              ],
            )),
      ],
    );
  }
}
