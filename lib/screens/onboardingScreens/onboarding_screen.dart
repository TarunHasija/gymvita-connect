import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/screens/onboardingScreens/login.dart';
import 'package:gymvita_connect/utils/colors.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    Get.put(AuthController());

    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(flex: 1, child: Container()),
                Text(
                  "GymVita\nConnect",
                  style: theme.headlineMedium?.copyWith(height: 1.1.h),
                  textAlign: TextAlign.center,
                ),
                Flexible(flex: 1, child: Container()),
                Container(
                  height: 400.h,
                  decoration: const BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Great to See You!\nLet's Make Today Count!",
                          textAlign: TextAlign.center,
                          style: theme.titleMedium?.copyWith(height: 1.1.h),
                        ),
                        SizedBox(height: 20.h),
                        InkWell(
                          onTap: () {
                            Get.to(() => LoginScreen());
                          },
                          child: Container(
                            width: 150.h,
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const Text("Get Started"),
                                Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 16.h,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          // Center logo
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              height: 120.h,
              child: Image.asset('assets/images/loginlogo.png'),
            ),
          )
        ],
      ),
    );
  }
}
