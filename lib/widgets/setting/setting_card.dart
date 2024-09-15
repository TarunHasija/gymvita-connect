import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class SettingCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final VoidCallback ontap;
  const SettingCard({super.key, required this.icon, required this.title, required this.ontap});

  @override
  State<SettingCard> createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  @override
  Widget build(BuildContext context) {
       TextTheme theme = Theme.of(context).textTheme;

    return InkWell(
      onTap: widget.ontap,
      child: Container(
        // color: Colors.red,
        padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 5.h),
        // margin: const EdgeInsets.all(1),
        child: Row(
          children: [
            Row(
              children: [Icon(widget.icon,color: accent,size: 25,),
              SizedBox(width: 10.w,),
              Text(widget.title,style: theme.bodySmall,),
              ],
            ),
            Flexible(flex: 1,child: Container(),),
            Icon(Icons.arrow_forward_ios_rounded,size: 18.h,)
          ],
        ),
      ),
    );
  }
}
