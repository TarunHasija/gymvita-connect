import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback ?onTap;

  const CustomAppBar({
    super.key,
    required this.title, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back_ios),
      ),

      
      actions: [
       Padding(
         padding: const EdgeInsets.only(right:10.0),
         child: GestureDetector(
          onTap: onTap,
           child: Text(
            title,
            style: GoogleFonts.righteous(
              textStyle: theme.displayMedium?.copyWith(fontSize: 24.sp), // Use a headline or another style from the theme
            ),),
         ),
       )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
