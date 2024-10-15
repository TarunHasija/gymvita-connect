import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/screens/nav_screens/analysis/analysis_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/home/home_page.dart';
import 'package:gymvita_connect/screens/nav_screens/payment/payment_screen.dart';
import 'package:gymvita_connect/screens/nav_screens/settings/settings_screen.dart';
import 'package:gymvita_connect/utils/colors.dart';
import 'package:gymvita_connect/controllers/navbar_controller.dart'; // Import your NavbarController

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  // Initialize NavbarController
  final NavbarController navbarController = Get.put(NavbarController());

  final List<Widget> screenList = [
    const HomePage(),
    const AnalysisScreen(),
    const PaymentScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent, // Remove splash effect
          highlightColor: Colors.transparent, // Remove highlight effect
        ),
        child: Obx(
          () => BottomNavigationBar(
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
            currentIndex: navbarController.selectedIndex.value,
            onTap: navbarController.updateIndex,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          ),
        ),
      ),
      body: Obx(
        () => screenList[navbarController.selectedIndex.value],
      ),
    );
  }
}
