import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/home_graph_controller.dart';
import 'package:gymvita_connect/utils/colors.dart';

class HomegraphCard extends StatelessWidget {
  final String title;
  final TextTheme theme;
  final VoidCallback onTap;

  const HomegraphCard({super.key, 
    required this.title,
    required this.theme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final HomeGraphController bodyPartController = Get.find<HomeGraphController>();

    return Obx(() {
      bool isSelected = bodyPartController.selectedBodyPart.value == title.toLowerCase();
      
      return GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
          margin: EdgeInsets.only(right: 10.w),
          decoration: BoxDecoration(
            color: isSelected ? accent : secondary, // Change background color if selected
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: Text(
              title,
              style: theme.bodySmall?.copyWith(color: white),
            ),
          ),
        ),
      );
    });
  }
}
