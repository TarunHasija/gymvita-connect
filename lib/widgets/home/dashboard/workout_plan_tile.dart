// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:gymvita_connect/utils/colors.dart';

class WorkoutPlanTile extends StatelessWidget {
  final VoidCallback ontap;
  final String day;
  final String bodyPart;
  const WorkoutPlanTile({
    super.key,
    required this.ontap,
    required this.day,
    required this.bodyPart,
  });

  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
      padding:  EdgeInsets.only(bottom: 15.h),
      child: GestureDetector(
        onTap: ontap,
        child: ListTile(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          tileColor: secondary,
          title: Text(
            day,
            style: theme.headlineSmall?.copyWith(color: accent),
          ),
          subtitle: Text(
            bodyPart,
            style: theme.bodySmall,
          ),
          trailing: const Icon(Icons.arrow_forward_ios_rounded),
        ),
      ),
    );
  }
}
