// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gymvita_connect/utils/colors.dart';

class ProfileTextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool? readonly;
  final VoidCallback onComplete;
  final FormFieldValidator<String>? validator;

  const ProfileTextFieldInput({
    super.key,
    required this.textEditingController,
    required this.hintText,
    this.readonly = false,
    required this.onComplete,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return SizedBox(
      height: 56.h,
      child: TextFormField(
        readOnly: readonly!,
        onFieldSubmitted: (value) => onComplete(),
        controller: textEditingController,
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
