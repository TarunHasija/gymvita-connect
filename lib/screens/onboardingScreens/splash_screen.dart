import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart'; // Import your AuthController
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:gymvita_connect/screens/onboardingScreens/onboarding_screen.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AuthController authController =
      Get.put(AuthController()); 

  @override
  void initState() {
    super.initState();
    _navigateBasedOnStatus();
  }

  Future<void> _navigateBasedOnStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString('email');
    final String? storedPassword = prefs.getString('password');

    if (storedEmail != null && storedPassword != null) {
      print("Stored email and password found: Logging in...");
      authController.emailController.text = storedEmail;
      authController.passwordController.text = storedPassword;
      await authController.handleLogin(context, authController.emailController,
          authController.passwordController);
      Get.offAll(()=> NavbarScreen());
    } else {
      print("No stored credentials found, navigating to onboarding screen.");
      Get.offAll(() => const OnboardingScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 120, // Adjust the size as per your image or splash logo
          child: Image.asset(
              'assets/images/splashlogo.png'), // Your splash screen image
        ),
      ),
    );
  }
}
