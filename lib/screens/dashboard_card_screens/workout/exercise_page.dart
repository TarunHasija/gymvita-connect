import 'package:flutter/material.dart';
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
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.bodyPart,
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(20),
        
        child: Column(
          
          children: [
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
            ExerciseTile(exercise: 'Bench Press', reps: '12x4'),
          ],
        ),
      ),
    );
  }
}
