import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/utils/colors.dart';

class ExerciseTile extends StatefulWidget {
  // final String bodyPart;
  final String exercise;
  final String reps;
  const ExerciseTile({super.key, required this.exercise, required this.reps});

  @override
  State<ExerciseTile> createState() => _ExerciseTileState();
}

class _ExerciseTileState extends State<ExerciseTile> {
  @override
  Widget build(BuildContext context) {
    TextTheme theme = Theme.of(context).textTheme;

    return Padding(
      padding:  EdgeInsets.only(bottom: 15.h),
      child: ListTile( 
        
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        tileColor: secondary,
        title: Text(
          widget.exercise,
          style: theme.bodyMedium?.copyWith(color: accent, ),
        ),
        trailing: Text(
          '${widget.reps} Reps ',
          style: theme.bodySmall,
        ),
      ),
    );
  }
}
