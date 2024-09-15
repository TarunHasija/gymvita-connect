import 'package:flutter/material.dart';

class ExerciseDetailPage extends StatelessWidget {
  final String day;
  final List exercises;

  const ExerciseDetailPage({super.key, required this.day, required this.exercises});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$day Workout'),
      ),
      body: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          String exerciseName = exercises[index]['name'];
          String reps = exercises[index]['reps'];

          return ListTile(
            title: Text(exerciseName), // Heading
            subtitle: Text(reps),      // Subheading
          );
        },
      ),
    );
  }
}
