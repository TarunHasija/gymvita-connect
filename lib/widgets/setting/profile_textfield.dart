import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class ProfileTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;

  const ProfileTextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        controller: textEditingController,
        cursorColor: white,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(color: secondary),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: BorderSide(width: 1.2.h, color: secondary),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: secondary),
            borderRadius: BorderRadius.circular(10.r),
          ),
          labelText: hintText,
          labelStyle: theme.labelLarge?.copyWith(color: Color.fromARGB(255, 179, 179, 179)),
          // Optional: Add internal padding to the input field
          // contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
        ),
      ),
    );
  }
}
