import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/analysis_graph_controller.dart';
import 'package:gymvita_connect/controllers/gyminfo_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:gymvita_connect/controllers/workout_plan_controller.dart';
import 'package:gymvita_connect/screens/nav_screens/analysis/analysis_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/home/home_page.dart';
import 'package:gymvita_connect/screens/nav_screens/payment/payment_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/settings_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';

class NavbarScreen extends StatefulWidget {
  const NavbarScreen({super.key});

  @override
  State<NavbarScreen> createState() => _NavbarScreenState();
}

class _NavbarScreenState extends State<NavbarScreen> {
  int selectedItem = 0;

  List<Widget> screenList = [
    const HomePage(),
    const AnalysisScreen(),
    const PaymentScreen(),
    const SettingsScreen(),
  ];

  onItemtapp(int index) {
    setState(() {
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final UserDataController userController = Get.find();
    final AnalysisGraphController analysisGraphController = Get.find();
    final WorkoutPlanController workoutPlanController = Get.find();

    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
//TODO: add this to handle login so that when the data loads the graph also loads

        final twelvemonthdata =
            // analysisGraphController.getLastSixMonthsData('weight');
            analysisGraphController.getLastSixMonthsData('chest');
        print(twelvemonthdata);
        final prevsixmonth =
            // analysisGraphController.getLastSixMonthsData('weight');
            analysisGraphController.getPreviousToPreviousSixMonthsData('chest');
        print(prevsixmonth);
        workoutPlanController.fetchWorkoutPlan();
      }),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: primary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics),
            label: 'Analysis',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: selectedItem,
        onTap: onItemtapp,
      ),
      body: screenList[selectedItem],
    );
  }
}
