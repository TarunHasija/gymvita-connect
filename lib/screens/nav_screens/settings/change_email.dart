import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/profile.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class ChangeEmailPage extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _newEmailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final RxBool _isOTPSent = false.obs; 

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
        child: Column(
          children: [
            TextfieldHeading(theme: theme, title: 'Current email'),
            ProfileTextFieldInput(
              readonly: true,
              textEditingController: TextEditingController(
                text: userController.userDocument.value?['email'],
              ),
              hintText: 'current email',
            ),
            TextfieldHeading(theme: theme, title: 'Enter new email'),
            ProfileTextFieldInput(
              readonly: false,
              textEditingController: _newEmailController,
              hintText: 'Enter new email',
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
                  String newEmail = _newEmailController.text.trim();
                  if (newEmail.isNotEmpty) {
                    // Send OTP
                    await _sendOTP(newEmail);
                    // Show OTP bottom sheet
                    _showOTPSheet(context, userController, newEmail);
                  } else {
                    Get.snackbar('Error', 'Please enter a valid email');
                  }
                },
                child: Text(
                  "Submit",
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
    );
  }

Future<void> _sendOTP(String currentEmail) async {
  ActionCodeSettings actionCodeSettings = ActionCodeSettings(
    url: 'https://your-app-link.com',
    handleCodeInApp: true, // This will open the OTP in the app
    iOSBundleId: 'com.example.ios',
    androidPackageName: 'com.example.android',
    androidInstallApp: true,
    androidMinimumVersion: '12',
  );

  try {
    // Send OTP to the current email
    await _auth.sendSignInLinkToEmail(
      email: currentEmail,
      actionCodeSettings: actionCodeSettings,
    );
    Get.snackbar('OTP Sent', 'An OTP has been sent to your email');
    _isOTPSent.value = true;
  } catch (e) {
    Get.snackbar('Error', 'Failed to send OTP');
  }
}

  void _showOTPSheet(BuildContext context, UserDataController userController, String newEmail) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
          height: 250.h,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter OTP',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 20.h),
              ProfileTextFieldInput(
                readonly: false,
                textEditingController: _otpController,
                hintText: 'Enter OTP',
              ),
              SizedBox(height: 20.h),
              Container(
                width: double.infinity,
                height: 50.h,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: accent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () async {
                    await _verifyOTP(userController, newEmail);
                  },
                  child: const Text(
                    'Verify OTP',
                    style: TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _verifyOTP(UserDataController userController, String newEmail) async {
    String otp = _otpController.text.trim();
    try {
      // Verify OTP
      final credential = EmailAuthProvider.credential(
        email: _auth.currentUser!.email!,
        password: otp,
      );
      await _auth.currentUser!.reauthenticateWithCredential(credential);

      // Update user's email in Firestore
      await updateUserData(userController, newEmail);
      Get.back(); // Close the bottom sheet
      Get.snackbar('Success', 'Email updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP or email verification failed');
    }
  }

  Future<void> updateUserData(UserDataController userController, String newEmail) async {
    final uid = userController.userDocument.value?['uid'];
    final gymCode = userController.userDocument.value?['gymCode'];

    if (uid != null && gymCode != null) {
      CollectionReference gymColRef = FirebaseFirestore.instance
          .collection(gymCode)
          .doc('clients')
          .collection('clients');
      DocumentReference clientDocRef = gymColRef.doc(uid);

      try {
        await clientDocRef.update({
          'email': newEmail,
        });
        DocumentSnapshot updatedDoc = await clientDocRef.get();
        userController.userDocument.value = updatedDoc;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update email');
      }
    }
  }
}
