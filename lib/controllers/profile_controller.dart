import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/onboardingScreens/login.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class ProfileController extends GetxController {
  final TextEditingController resetPasEmailController = TextEditingController();
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
    print("previous user image" + userController.userImg.value);
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
          .collection(authController.storedGymCode.value)
          .doc('clients')
          .collection('clients')
          .doc(authController.storedUid.value)
          .set({
        'imageUrl': downloadUrl,
      }, SetOptions(merge: true));

      Get.snackbar("Success", "Image updated successfully");

      fetchImage(
          authController.storedGymCode.value, authController.storedUid.value);
      print("user image updated");

      print(
          "Image uploaded successfully to ${authController.storedGymCode}/clients/");
    } catch (e) {
      print("Error uploading image: $e");
    }
  }

  fetchImage(String gymCode, String uid) async {
    print(gymCode);
    print(uid);
    print("image");
    CollectionReference userCollection = FirebaseFirestore.instance
        .collection(gymCode)
        .doc('clients')
        .collection('clients');
    DocumentReference clientDocRef = userCollection.doc(uid);

    try {
      clientDocRef.snapshots().listen((DocumentSnapshot docSnapshot) {
        if (docSnapshot.exists) {
          print(docSnapshot['email'] ?? '');
          userController.userImg.value = docSnapshot['details']['image'];
          print("new user image :${userController.userImg.value}");
          print("snapshot image" + docSnapshot['details']['image']);

          print('Document exists and updated in real-time');
        } else {
          throw Exception("Document not found");
        }
      });
    } catch (error) {
      print("Error fetching user data: ${error.toString()}");
    }
  }

  sendOtpForPassword(String email) async {
    final url = Uri.parse('https://ses-server.onrender.com/api/v1/sendOtp');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode({
      "email": email,
      "subject": "Password Reset OTP from GymVita Connect",
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

  void resetPassword(
      String email, String newPassword, String confirmPassword) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Please fill in all fields.');
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar('Error', 'Passwords do not match.');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(
            "https://us-central1-gymvita-connect-88697.cloudfunctions.net/JWTToken/generate"),
        headers: {
          "Content-Type": "application/json",
          "alg": "HS256",
          "typ": "JWT",
        },
        body: jsonEncode({
          "email": email,
          "password": newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final token = jsonDecode(response.body)['token'];

        final usersRef =
            FirebaseFirestore.instance.collection('GymsCommonCollection');
        final userSnapshot =
            await usersRef.where('email', isEqualTo: email).get();

        if (userSnapshot.docs.isNotEmpty) {
          await usersRef.doc(userSnapshot.docs[0].id).update({
            'jwtToken': token,
          });

          Get.snackbar('Success', 'Password updated successfully.');

          Get.offAll(() => const LoginScreen());
        } else {
          Get.snackbar('Error', 'User not found in the database.');
        }
      } else {
        Get.snackbar(
            'Error', 'Failed to generate JWT token: ${response.reasonPhrase}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to update password: $e');
    }
  }

  checkUserExists(String email) async {
    CollectionReference userRef =
        FirebaseFirestore.instance.collection('GymsCommonCollection');

    QuerySnapshot querySnapshot =
        await userRef.where('email', isEqualTo: email).get();

    print(querySnapshot.docs);
    return querySnapshot.docs.isNotEmpty;
  }
}
