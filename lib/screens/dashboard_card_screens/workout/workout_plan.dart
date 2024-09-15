import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/workout_plan_controller.dart';
import 'package:gymvita_connect/screens/dashboard_card_screens/workout/exercise_detail_page.dart';

class WorkOutPlanPage extends StatefulWidget {
  const WorkOutPlanPage({super.key});

  @override
  State<WorkOutPlanPage> createState() => _WorkOutPlanPageState();
}

class _WorkOutPlanPageState extends State<WorkOutPlanPage> {
  @override
  Widget build(BuildContext context) {
    final WorkoutPlanController workoutPlanController = Get.find<WorkoutPlanController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Workout Plan')),
      body: FutureBuilder<List<dynamic>>(
        future: workoutPlanController.fetchWorkoutPlan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            List<dynamic> workoutPlans = snapshot.data!;

            return Expanded(
              child: ListView.builder(
                itemCount: workoutPlans.length,
                itemBuilder: (context, index) {
                  String day = workoutPlans[index].keys.first;
                  String part = workoutPlans[index][day]['part'];

                  return ListTile(
                    title: Text(day),
                    subtitle: Text(part),
                    onTap: () {
                      List exercises = workoutPlans[index][day]['exercise'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ExerciseDetailPage(
                            day: day,
                            exercises: exercises,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            );
          } else {
            return const Center(child: Text('No data found'));
          }
        },
      ),
    );
  }
}
