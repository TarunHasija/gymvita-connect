import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class AuthController extends GetxController {
  final RxString storedUid = ''.obs;
  final RxString storedGymCode = ''.obs;
  final RxBool isUserLoggedIn = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    _loadStoredUser();
  }

  Future<void> _storeUserDetails(String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      print('Stored user details: $email, $password');
    } catch (e) {
      print('Failed to store user details: ${e.toString()}');
    }
  }

  Future<void> _loadStoredUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final email = prefs.getString('email');
      final password = prefs.getString('password');

      if (email != null && password != null) {
        emailController.text = email;
        passwordController.text = password;
        print('Loaded stored user details: $email, $password');
      } else {
        print('No stored user details found');
      }
    } catch (e) {
      print('Failed to load stored user details: ${e.toString()}');
    }
  }

  Future<void> handleLogin(
      BuildContext context,
      TextEditingController emailController,
      TextEditingController passwordController) async {
    isLoading.value = true;
    print('Login started');

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    try {
      print('Sending login request with email: $email');
      final response = await http.post(
        Uri.parse(
            "https://us-central1-firestore-141df.cloudfunctions.net/JWTToken/generate"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final tokenFromServer = responseData['token'];
        print('Received token from server: $tokenFromServer');

        final result = await authUser(email);
        if (result == null) {
          // User doesn't exist
          print('User does not exist');
          _showAlertDialog(context, "User does not exist");
        } else if (result['jwtToken'] != tokenFromServer) {
          // Invalid credentials
          print('Invalid credentials');
          _showAlertDialog(context, "Invalid credentials");
        } else if (result['status'] != 'Active') {
          // Status inactive
          print('Account is inactive');
          _showAlertDialog(context, "Account is inactive");
        } else {
          // Valid credentials and active status
          print('Token validation successful');
          storedUid.value = result['uid'];
          storedGymCode.value = result['gymCode'];
          print("${storedGymCode.value}-------${storedUid.value}");

          final clientResponse = await clientDetails(result['uid']);
          if (clientResponse == 0) {
            throw Exception("Client not found");
          }
          updateClient(clientResponse);
          print('Navigating to NavbarScreen');
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const NavbarScreen()));

          // Store user details for next session
          await _storeUserDetails(email, password);
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

    var userDoc = querySnapshot.docs.first;


    print(
        'User data fetched: ${userDoc.id}, ${userDoc['gymCode']}, ${userDoc['jwtToken']}');
    return {
      'status':userDoc['status'],
      'uid': userDoc.id,
      'gymCode': userDoc['gymCode'],
      'jwtToken': userDoc['jwtToken'],
    };
  } catch (error) {
    print('Error fetching user data: ${error.toString()}');
    return null;
  }
}

Future<dynamic> clientDetails(String uid) async {
  print('Fetching client details for uid: $uid');
  await Future.delayed(const Duration(seconds: 1));
  return {};
}

void updateClient(dynamic response) {
  print('Updating client with response: $response');
  // Implement the client update logic here
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
            
            child: const Text('OK',style: TextStyle(color: white),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
