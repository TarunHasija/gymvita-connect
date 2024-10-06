
// Helper widget for text field headings
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextfieldHeading extends StatelessWidget {
  final String title;
  const TextfieldHeading({
    super.key,
    required this.theme,
    required this.title,
  });

  final TextTheme theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      margin: EdgeInsets.only(bottom: 8.h, left: 8.w, top: 20.h),
      child: Text(
        title,
        style: theme.labelMedium
            ?.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w300),
      ),
    );
  }
}