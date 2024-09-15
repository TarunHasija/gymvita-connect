import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/widgets/appbar.dart';
import 'package:gymvita_connect/widgets/home/dashboard/exercise_tile.dart';

class ExercisePage extends StatefulWidget {
  final String bodyPart;
  const ExercisePage({super.key, required this.bodyPart});

  @override
  State<ExercisePage> createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> {
  @override
  Widget build(BuildContext context) {
    
    final exercises = [
      {'exercise': 'Bench Press', 'reps': '12x4'},
      {'exercise': 'Squats', 'reps': '10x3'},
      {'exercise': 'Deadlift', 'reps': '8x3'},
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: widget.bodyPart,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            var exercise = exercises[index];
            return ExerciseTile(
              exercise: exercise['exercise']!,
              reps: exercise['reps']!,
            );
          },
        ),
      ),
    );
  }
}
