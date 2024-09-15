import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

Future<void> handleLogin(
    BuildContext context,
    TextEditingController emailController,
    TextEditingController passwordController) async {
  // ignore: unused_local_variable
  bool isLoading = true;

  final email = emailController.text.trim();
  final password = passwordController.text.trim();

  try {
    // Call your authentication function
    final result = await authUser(email);
    print(result);

    if (result != null) {
      final response = await http.post(
        Uri.parse(
            "https://us-central1-firestore-141df.cloudfunctions.net/JWTToken/generate"),
        headers: {
          "Content-Type": "application/json",
          "alg": "HS256",
          "typ": "JWT",
        },
        body: jsonEncode({'email': email, 'password': password}),
      );

      print(response);
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Fetch the JWT token from Firebase

        // Compare JWT tokens
        if (result['jwtToken'] == null) {
          print('Jwt token missing');
        }
        else{

        print(result['jwtToken']);
        }

        if (result['jwtToken'] != null &&
            result['jwtToken'] == responseData['token'].toString()) {
          await _storage.write(key: "uid", value: result['uid']);

          final clientResponse = await clientDetails(result['uid']);
          if (clientResponse == 0) {
            throw Exception("Client not found");
          }

          updateClient(clientResponse);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NavbarScreen()));
        } else {
          _showAlertDialog(context, "Invalid credentials");
          throw Exception("Invalid credentials");
        }
      } else {
        _showAlertDialog(context, "Invalid credentials");
        throw Exception("Invalid credentials");
      }
    } else {
      _showAlertDialog(context, "Invalid credentials");
      throw Exception("Invalid credentials");
    }
  } catch (error) {
    _showAlertDialog(context, error.toString());
  } finally {
    isLoading = false;
  }
}

Future<Map<String, dynamic>?> authUser(String email) async {
  try {
    // Reference to the Firestore collection
    CollectionReference gymsCollection =
        FirebaseFirestore.instance.collection('GymsCommonCollection');

    // Query Firestore to find documents where the email field matches the input email
    QuerySnapshot querySnapshot =
        await gymsCollection.where('email', isEqualTo: email).get();

    if (querySnapshot.docs.isEmpty) {
      // No documents found
      return null;
    }

    if (querySnapshot.docs.length > 1) {
      // More than one document found
      throw Exception("Multiple users found");
    }

    // Access the first document's data
    var userDoc = querySnapshot.docs.first;

    if (userDoc['status'] != 'Active') {
      // User status is not active
      throw Exception("Not able to sign in");
    }

    // Return user data as a map
    return {
      'uid': userDoc.id,
      'jwtToken': userDoc['jwtToken'],
    };
  } catch (error) {
    // Error handling
    print('Error in authUser: $error');
    return null;
  }
}

Future<dynamic> clientDetails(String uid) async {
  // Simulate fetching client details
  await Future.delayed(const Duration(seconds: 1));
  return {}; // Replace with actual client details or 0 if not found
}

void updateClient(dynamic response) {
  // Implement the client update logic here
}

void _showAlertDialog(BuildContext context, String message) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
