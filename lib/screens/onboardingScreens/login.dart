import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/widgets/text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthController authController = Get.find<AuthController>();
  final UserDataController userController = Get.find<UserDataController>();

  bool _showPassword = false;

  void _togglePasswordVisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 100.h),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 70.h,
                        child: Image.asset('assets/images/loginlogo.png'),
                      ),
                      SizedBox(width: 15.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("GymVita Connect", style: theme.headlineSmall),
                          Text("Let's get started", style: theme.titleSmall),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 550.h,
              decoration: const BoxDecoration(
                color: white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      'Log In',
                      style: theme.headlineSmall?.copyWith(
                        color: Colors.black,
                        fontSize: 20.sp,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    TextFieldInput(
                      textEditingController: authController.emailController,
                      hintText: 'Enter your email',
                      togglePasswordVisibility: () {},
                    ),
                    SizedBox(height: 30.h),
                    TextFieldInput(
                      textEditingController: authController.passwordController,
                      hintText: 'Enter your password',
                      showPassword: _showPassword,
                      isPassword: true,
                      togglePasswordVisibility: _togglePasswordVisibility,
                    ),
                    SizedBox(height: 10.h),
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          'Forgot Password?',
                          style: theme.displaySmall,
                        ),
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Obx(() => InkWell(
                          onTap: () {
                            authController.handleLogin(
                              context,
                              authController.emailController,
                              authController.passwordController,
                            );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10.h),
                            decoration: BoxDecoration(
                              color: primary,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: authController.isLoading.value
                                ? Container(
                                    padding: EdgeInsets.all(3.h),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                : IntrinsicWidth(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Login"),
                                        SizedBox(width: 10.w),
                                        Icon(Icons.arrow_forward_ios_rounded, size: 16.h),
                                      ],
                                    ),
                                  ),
                          ),
                        )),
                    Flexible(flex: 1, child: Container()),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Powered By Avyukt Solutions",
                        style: theme.displaySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
