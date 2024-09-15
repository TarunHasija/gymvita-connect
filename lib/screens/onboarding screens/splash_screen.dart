import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/screens/onboarding%20screens/login.dart';
import 'package:gymvita_connect/screens/onboarding%20screens/onboarding_screen.dart';
import 'package:gymvita_connect/screens/navbar_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const _storage = FlutterSecureStorage();

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateBasedOnStatus();
  }

  Future<void> _navigateBasedOnStatus() async {
    await Future.delayed(const Duration(seconds: 3));

    // Load stored user credentials and onboarding status
    final prefs = await SharedPreferences.getInstance();
    final onboardingComplete = prefs.getBool('onboarding_complete') ?? false;
    final uid = await _storage.read(key: "uid");

    if (uid != null) {
      // User is authenticated
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const NavbarScreen()));
    } else if (onboardingComplete) {
      // Onboarding is complete but not logged in
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    } else {
      // Onboarding not complete
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const OnboardingScreen()));
    }
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 120.h,
          child: Image.asset('assets/images/splashlogo.png'),
        ),
      ),
    );
  }
}
