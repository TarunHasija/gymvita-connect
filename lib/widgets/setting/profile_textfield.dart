import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool? readonly;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.readonly = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        readOnly: readonly!,
        controller: textEditingController,
        style: theme.bodyMedium?.copyWith(
            fontSize: 14.sp, color: const Color.fromARGB(255, 184, 184, 184)),
        cursorColor: white,
        validator: validator,
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
          hintText: hintText,
          hintStyle: theme.labelLarge
              ?.copyWith(color: Color.fromARGB(255, 179, 179, 179)),
        ),
      ),
    );
  }
}
