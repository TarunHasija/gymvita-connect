import 'package:flutter/material.dart';
import 'package:gymvita_connect/utils/colors.dart';

class CustomTextButton extends StatelessWidget {
  final String buttonText;
  final double height;
  final Color bgColor;
  final Color? textColor;

  final VoidCallback btnOnTap;

  const CustomTextButton({
    super.key,
    required this.height,
    required this.bgColor,
    required this.btnOnTap,
    this.textColor, required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: double.infinity,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: bgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () async {
           btnOnTap();
        },
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor ?? black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
