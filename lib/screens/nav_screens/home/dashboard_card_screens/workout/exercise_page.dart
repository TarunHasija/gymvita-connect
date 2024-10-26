import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gymvita_connect/widgets/components/appbar.dart';
import 'package:gymvita_connect/widgets/home/dashboard/exercise_tile.dart';

class ExercisePage extends StatelessWidget {
  final String bodyPart;
  final List<dynamic> exercises; // The list of exercises for that specific day

  const ExercisePage({super.key, required this.bodyPart, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: bodyPart,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: ListView.builder(
          itemCount: exercises.length,
          itemBuilder: (context, index) {
            var exerciseData = exercises[index]; // Get exercise details (name and reps)
            var exerciseName = exerciseData['name'];
            var exerciseReps = exerciseData['reps'];

            return ExerciseTile(
              exercise: exerciseName,
              reps: exerciseReps,
            );
          },
        ),
      ),
    );
  }
}
