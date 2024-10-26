import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gymvita_connect/controllers/analysis_form_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/screens/onboardingscreens/login.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController {
  final RxString storedUid = ''.obs;
  final RxString storedGymCode = ''.obs;
  final RxBool isUserLoggedIn = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> handleLogin(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    isLoading.value = true;
    print('Login started');

    final UserController userController = Get.find<UserController>();


    try {
    final userEmail = emailController.text.trim();
    userController.userEmail.value= userEmail;
    final password = passwordController.text.trim();
      print('Sending login request with email: $userEmail');

      final response = await http.post(
        Uri.parse(
            "https://us-central1-firestore-141df.cloudfunctions.net/JWTToken/generate"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({'email': userEmail, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final tokenFromServer = responseData['token'];
        print('Received token from server: $tokenFromServer');

        final result = await authUser(userEmail);
        print("---------------user email value ----------------" + userEmail);


        if (result == null) {
          print('User does not exist');
          _showAlertDialog(context, "User does not exist");
        } else if (result['jwtToken'] != tokenFromServer) {
          print('Invalid credentials');
          _showAlertDialog(context, "Invalid credentials");
        } else if (result['status'] != 'Active') {
          // Status inactive
          print('Account is inactive');
          _showAlertDialog(context, "Account is inactive");
        } else {
          print('Token validation successful');
          storedUid.value = result['uid'];
          storedGymCode.value = result['gymCode'];

          final clientResponse = await clientDetails(result['uid']);
          if (clientResponse == 0) {
            throw Exception("Client not found");
          }

          //! shared preference

          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('email', userEmail);
          await prefs.setString('password', password);

          MonthlyAnalysisController monthlyAnalysisController =
              Get.put(MonthlyAnalysisController());
          await monthlyAnalysisController.loadAnalysisData();
          Get.offAll(() => NavbarScreen());
        }
      } else {
        print('Login request failed with status: ${response.statusCode}');
        _showAlertDialog(context, "Invalid credentials");
      }
    } catch (error) {
      print('Login error: ${error.toString()}');
      _showAlertDialog(context, "Error: ${error.toString()}");
    } finally {
      isLoading.value = false;
      print('Login process completed');
    }
  }

  Future<Map<String, dynamic>?> authUser(String email) async {
    print('Fetching user data for email: $email');
    try {
      print("-------------Testing-------------------");
      CollectionReference gymsCollection =
          FirebaseFirestore.instance.collection('GymsCommonCollection');

      QuerySnapshot querySnapshot =
          await gymsCollection.where('email', isEqualTo: email).get();

      if (querySnapshot.docs.isEmpty) {
        print('No user found for email: $email');
        return null;
      }

      var userDocRef = querySnapshot.docs.first;

      print(
          'User data fetched: ${userDocRef.id}, ${userDocRef['gymCode']}, ${userDocRef['jwtToken']}');
      return {
        'status': userDocRef['status'],
        'uid': userDocRef.id,
        'gymCode': userDocRef['gymCode'],
        'jwtToken': userDocRef['jwtToken'],
      };
    } catch (error) {
      print('Error fetching user data: ${error.toString()}');
      return null;
    }
  }

  Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.clear();
    await prefs.remove('email');
    await prefs.remove('password');
    emailController.clear();
    passwordController.clear();

    Get.offAll(() => const LoginScreen());
  }

  Future<dynamic> clientDetails(String uid) async {
    print('Fetching client details for uid: $uid');
    await Future.delayed(const Duration(seconds: 1));
    return {};
  }

  void _showAlertDialog(BuildContext context, String message) {
    print('Showing alert dialog with message: $message');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text(
                'OK',
                style: TextStyle(color: white),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
