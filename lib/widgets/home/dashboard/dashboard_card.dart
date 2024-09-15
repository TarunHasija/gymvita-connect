import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../utils/colors.dart';

Widget dashBoardCard(
     String text, TextTheme theme, IconData icon,VoidCallback ontap) {
  return GestureDetector(
    onTap: ontap,
    child: Card(
      color: secondary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // elevation: 4.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60.h,
            height: 60.h,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: accent,
            ),
            child: Center(
                child: Icon(
              icon,
              color: Colors.black,
            )),
          ),
          SizedBox(height: 10.h),
          Text(
            text,
            style: theme.labelSmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    ),
  );
}
