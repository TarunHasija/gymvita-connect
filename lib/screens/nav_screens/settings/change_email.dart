import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';
import 'package:gymvita_connect/widgets/setting/text_heading.dart';

//! _______Change email page rightnow not implemented_________

class ChangeEmailPage extends StatelessWidget {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final RxBool isOTPSent = false.obs;
  final ProfileController profileController = Get.find<ProfileController>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>(); // Add Form key

  ChangeEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDataController userController = Get.find<UserDataController>();
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
          'Change email',
          style: GoogleFonts.righteous(
            textStyle: theme.titleLarge?.copyWith(fontSize: 24.sp),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: Form(
          key: _formKey, // Add Form
          child: Column(
            children: [
              TextfieldHeading(theme: theme, title: 'Current email'),
              CustomTextField(
                readonly: true,
                textEditingController: TextEditingController(
                  text: userController.userDocSnap.value?['email'],
                ),
                hintText: 'current email',
              ),
              TextfieldHeading(theme: theme, title: 'Enter new email'),
              Expanded(
                child: CustomTextField(
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
                    return null;
                  },
                  readonly: false,
                  textEditingController: newEmailController,
                  hintText: 'Enter new email',
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40.h),
                height: 55.h,
                width: double.infinity,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () async {
                    // if (_formKey.currentState!.validate()) {
                    //   String newEmail = newEmailController.text.trim();
                    //   await profileController
                    //       .sendOTP(userController.userDocSnap.value?['email']);

                    //   profileController.showOTPSheet(
                    //       context, userController, theme, newEmail);
                    // }
                  },
                  child: Text(
                    "Send OTP",
                    style: TextStyle(
                      color: black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
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
