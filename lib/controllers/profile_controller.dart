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
import 'package:gymvita_connect/screens/onboardingScreens/login.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/setting/profile_textfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final TextEditingController resetPasEmailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final RxBool isOTPSent = false.obs;
  final RxBool isResendAllowed = false.obs;
  final RxInt resendTimer = 30.obs;
  RxString fetchOtp = ''.obs;
  Timer? timer;

  late PageController pageController;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController(initialPage: 0);
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
    otpController.clear();
  }

  final UserController userController = Get.find<UserController>();
  final AuthController authController = Get.find<AuthController>();

  Future<void> updateUserData(
      UserController userController, String newEmail) async {
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
    isResendAllowed.value = false;
    resendTimer.value = 30;

    timer?.cancel(); // Cancel any existing timers

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (resendTimer.value > 0) {
        resendTimer.value--;
      } else {
        isResendAllowed.value = true;
        timer.cancel();
      }
    });
  }

  selectFile(BuildContext context) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final storageRef = FirebaseStorage.instance.ref();
      final imageRef = storageRef.child(
          "${authController.storedGymCode}/clients/${authController.storedUid}");
      final imageBytes = await image.readAsBytes();

      // Upload the image
      TaskSnapshot uploadTask = await imageRef.putData(imageBytes);

      String downloadUrl = await uploadTask.ref.getDownloadURL();

      await FirebaseFirestore.instance
          .collection('clients')
          .doc(authController.storedUid.value)
          .update({
        'imageUrl': downloadUrl,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: secondary,
          content: Text(
            "Image updated",
            style: TextStyle(color: white),
          ),
          duration: Duration(seconds: 2),
        ),
      );

      // Optionally, you can call getUserData to refresh the user's data
      userController.getUserData(
          authController.storedUid.value, authController.storedGymCode.value);

      print(
          "Image uploaded successfully to ${authController.storedGymCode}/clients/");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  sendOtpForPassword(String email) async {
    final url = Uri.parse('https://ses-server.onrender.com/api/v1/sendOtp');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "subject": "Password Reset OTP",
      "length": 6,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('OTP sent successfully: $responseData');
        fetchOtp.value = responseData['otp'];
        print('fetched otp : ${fetchOtp.value}');
        print(hashToOtp(fetchOtp.value));
        // print('fetched otp : ');

        isOTPSent.value = true;
        startResendTimer();
      } else {
        Get.snackbar('Error', 'Failed to send OTP. Please try again');
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again later.',
      );
    }
  }

  String hashToOtp(String str) {
    int hash = 0;

    for (int i = 0; i < str.length; i++) {
      int charCode = str.codeUnitAt(i);
      hash = ((hash << 5) - hash + charCode) & 0xFFFFFFFF;
    }
    return hash.toRadixString(16);
  }

  Future<void> verifyOtpToResetPassword(String otp) async {
    String userEnteredOtp = otp;

    print("hashed userentered otp${hashToOtp(userEnteredOtp)}");
    try {
      if (fetchOtp.value == hashToOtp(userEnteredOtp)) {
        Future.delayed(const Duration(seconds: 2), () {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        });
      } else {
        print("otp dont match");
        Get.snackbar('Error', 'Invalid OTP or email verification failed');
      }
    } catch (e) {
      print(e);
    }
  }

  void resetPassword(String newPassword, String confirmPassword) {
    // Check if the new password and confirm password match
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    // Here you can add your logic to update the password
    // For example, you could call an API to update the password

    try {
      Get.to(() => const LoginScreen());
      Get.snackbar('Success', 'Password updated successfully.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update password: $e');
    }
  }
}
