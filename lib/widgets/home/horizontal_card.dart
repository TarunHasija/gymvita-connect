import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';


// used in analysis graph page 


class HorizontalCard extends StatelessWidget {
  final Color? color;
  final String title;
  final VoidCallback? onTapp;

  const HorizontalCard({
    super.key,
    this.onTapp,
    required this.title,
    required this.theme,
    this.color,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 10.w),
      child: InkWell(
        onTap: onTapp, // Corrected to trigger the callback
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: accent, width: 1.2.h),
            color: color,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Text(title,
                  style: theme.bodySmall?.copyWith(fontSize: 10.sp)),
            ),
          ),
        ),
      ),
    );
  }
}