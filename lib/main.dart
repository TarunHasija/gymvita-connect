import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/analysis_form_controller.dart';
import 'package:gymvita_connect/controllers/analysis_graph_controller.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:gymvita_connect/controllers/featured_content_controller.dart';
import 'package:gymvita_connect/controllers/gyminfo_controller.dart';
import 'package:gymvita_connect/controllers/home_graph_controller.dart';
import 'package:gymvita_connect/controllers/nutrition_plan_controller.dart';
import 'package:gymvita_connect/controllers/profile_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/controllers/workout_plan_controller.dart';
import 'package:gymvita_connect/firebase_options.dart';
import 'package:gymvita_connect/screens/onboardingScreens/splash_screen.dart';
import 'package:gymvita_connect/services/notification_service.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // NotificationService().initNotification();
  tz.initializeTimeZones();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.put(UserController());
  Get.put(WorkoutPlanController());
  Get.put(NutritionPlanController());
  Get.put(GymInfoController());
  Get.put(ProfileController());
  Get.put(MonthlyAnalysisController());
  Get.put(AnalysisGraphController());
  Get.put(HomeGraphController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primary,
            primarySwatch: Colors.grey,
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: primary,
                elevation: 1,
                selectedItemColor: Colors.white,
                unselectedItemColor: grey,
                unselectedLabelStyle:
                    TextStyle(fontSize: 8.sp, fontWeight: FontWeight.w300),
                selectedLabelStyle: TextStyle(
                  fontSize: 10.sp,
                  fontFamily: 'Product-Sans',
                )),
            appBarTheme: const AppBarTheme(color: primary),
            textTheme: TextTheme(
                headlineLarge: TextStyle(
                  fontSize: 36.sp,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Product-Sans',
                ),
                headlineMedium: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Product-Sans',
                ),
                headlineSmall: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Product-Sans',
                ),
                titleMedium: TextStyle(
                  fontSize: 20.sp,
                  color: Colors.black,
                  fontFamily: 'Product-Sans',
                ),
                titleSmall: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  fontFamily: 'Product-Sans',
                ),
                titleLarge: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 24.sp,
                  fontFamily: 'Product-Sans',
                ),
                bodyLarge: const TextStyle(),
                bodyMedium: TextStyle(
                  fontSize: 16.sp,
                  fontFamily: 'Product-Sans',
                ),
                bodySmall: TextStyle(
                  color: white,
                  fontSize: 12.sp,
                  fontFamily: 'Product-Sans',
                ),
                labelLarge: const TextStyle(
                  color: white,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'Product-Sans',
                ),
                labelMedium: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: white,
                  fontFamily: 'Product-Sans',
                ),
                labelSmall: TextStyle(
                  fontSize: 10.sp,
                  color: white,
                  fontFamily: 'Product-Sans',
                ),
                displaySmall: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.black,
                  fontFamily: 'Product-Sans',
                ),
                displayMedium: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Product-Sans',
                ),
                displayLarge: const TextStyle()),
            brightness: Brightness.dark,
            scaffoldBackgroundColor: primary,
          ),
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
