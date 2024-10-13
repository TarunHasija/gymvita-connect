import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final bool isPassword;
  final String hintText;
  final bool showPassword;
  final VoidCallback? togglePasswordVisibility;

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPassword = false,
    required this.hintText,
    this.showPassword = false,
    this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(6),
      borderSide: Divider.createBorderSide(context),
    );

    return TextFormField(
      controller: textEditingController,
      style: const TextStyle(color: Colors.black),
      cursorColor: primary,
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
          width: 1.2.h,
        )),
        enabledBorder: inputBorder,
        labelText: hintText,
        labelStyle: const TextStyle(color: Colors.black),
        filled: true,
        fillColor: white,
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  showPassword ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
                onPressed: togglePasswordVisibility,
              )
            : null,
      ),
      obscureText: isPassword && !showPassword,
      onChanged: (value) {
        // Check if the field is not a password field, and convert to lowercase
        if (!isPassword) {
          textEditingController.text = value.toLowerCase();
          textEditingController.selection = TextSelection.fromPosition(
            TextPosition(offset: textEditingController.text.length),
          );
        }
      },
    );
  }
}
