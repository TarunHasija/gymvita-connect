import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/gyminfo_controller.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
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
    final UserDataController userController = Get.find();
    final GymInfoController gymInfoController = Get.find();
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        print(gymInfoController.gymData);
        print("user Document ${userController.userDocRef}");
        print("user snapshot ${userController.userDocSnap}");
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
