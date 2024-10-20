import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/profile.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final RxBool _isOTPSent = false.obs;
  final RxBool _isResendAllowed = false.obs;
  final RxInt _resendTimer = 30.obs;
  RxString fetchOtp = ''.obs;



  Timer? _timer;
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
    _otpController.clear();
  }

  final UserDataController userController = Get.find<UserDataController>();
  final AuthController authController = Get.find<AuthController>();

  // Send OTP and handle failure or success
  Future<void> sendOTP(String currentEmail) async {
    final url = Uri.parse('https://ses-server.onrender.com/api/v1/sendOtp');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": currentEmail,
      "subject": "OTP for email change",
      "length": "6"
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        fetchOtp.value = responseData['otp'];
        print("_otp value is :$fetchOtp");
        _isOTPSent.value = true;
        Get.snackbar(
          'OTP Send',
          'Otp send to $currentEmail',
        );
        startResendTimer();
      } else {
        Get.snackbar(
          'Error',
          'Failed to send OTP. Please try again.',
          backgroundColor: secondary,
        );
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
      );
    }
  }

  // Show OTP sheet only when OTP is sent successfully
  void showOTPSheet(BuildContext context, UserDataController userController,TextTheme theme,
      String newEmail) {
    if (_isOTPSent.value) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              // height: 250.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      'Enter OTP',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  ProfileTextFieldInput(
                    readonly: false,
                    textEditingController: _otpController,
                    hintText: 'enter otp',
                  ),
                  SizedBox(height: 20.h),
                  SizedBox(
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
                      child:  Text(
                        'Verify OTP',
                        style: theme.bodySmall
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Obx(() => _isResendAllowed.value
                        ? TextButton(
                            onPressed: () async {
                              _isOTPSent.value = false; // Reset OTP sent state
                              await sendOTP(newEmail);
                            },
                            child: Text(
                              'Resend OTP',
                              style: theme
                                  .bodySmall
                                  ?.copyWith(color: white),
                            ))
                        : Text(
                            'Resend available in $_resendTimer seconds',
                            style: theme
                                .bodySmall
                                ?.copyWith(color: white),
                          )),
                  ),
                ],
              ),
            ),
          );
        },
      ).whenComplete(() {
        _otpController.clear();
      });
    }
  }

  // Verify OTP
  Future<void> verifyOTP(
      UserDataController userController, String newEmail) async {
    String otp = _otpController.text.trim();
    try {
      print(fetchOtp.value);
      print(otp);

      if (fetchOtp.value == otp.toString()) {
        Get.snackbar('Success', 'Email updated successfully');
      }
      Future.delayed(Duration(seconds: 2), () {
        Get.off(() => Profile());
      });
      // Close the bottom sheet
    } catch (e) {
      Get.snackbar('Error', 'Invalid OTP or email verification failed');
    }
  }

  // Update User Data in Firestore
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
        await clientDocRef.update({'email': newEmail});
        DocumentSnapshot updatedDoc = await clientDocRef.get();
        userController.userDocSnap.value = updatedDoc;
      } catch (e) {
        Get.snackbar('Error', 'Failed to update email');
      }
    }
  }

  // Start resend timer for 30 seconds
  void startResendTimer() {
    _isResendAllowed.value = false;
    _resendTimer.value = 30;

    _timer?.cancel(); // Cancel any existing timers

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_resendTimer.value > 0) {
        _resendTimer.value--;
      } else {
        _isResendAllowed.value = true;
        _timer?.cancel();
      }
    });
  }

  // Handle file selection for image uploading
  selectFile() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(
        "${authController.storedGymCode}/clients/${authController.storedUid}");
    final imageBytes = await image.readAsBytes();
    await imageRef.putData(imageBytes);

    print(
        "Image uploaded successfully to ${authController.storedGymCode}/clients/");
  }
}
