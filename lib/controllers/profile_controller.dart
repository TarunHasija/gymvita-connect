import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final RxBool _isOTPSent = false.obs;

  final UserDataController userController = Get.find<UserDataController>();

  Future<void> sendOTP(String currentEmail) async {
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

  void showOTPSheet(BuildContext context, UserDataController userController,
      String newEmail) {
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
                    await verifyOTP(userController, newEmail);
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

  Future<void> verifyOTP(
      UserDataController userController, String newEmail) async {
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

  Future<void> updateUserData(
      UserDataController userController, String newEmail) async {
    final uid = userController.userDocSnap.value?['uid'];
    final gymCode = userController.userDocSnap.value?['gymCode'];

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
        userController.userDocSnap.value = updatedDoc;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update email');
      }
    }
  }

  Future selectFile() async {}
}
