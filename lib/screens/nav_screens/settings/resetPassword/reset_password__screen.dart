import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/resetPassword/email_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/resetPassword/new_pass_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/resetPassword/otp_screen.dart';
import 'package:gymvita_connect/widgets/appbar.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    return Scaffold(
      appBar: CustomAppBar(
        title: "Reset Password",
        onTap: () {
          if (profileController.pageController.page == 0) {
            Get.back();
          } else {
            profileController.pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut);
          }
          Get.back();
        },
      ),
      body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PageView(
            controller: profileController.pageController,
            children: [
              EmailScreen(profileController),
              OTPScreen(profileController),
              NewPasswordScreen(profileController),
            ],
          )),
    );
  }
}
