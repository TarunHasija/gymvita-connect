import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/workout_plan_controller.dart';
import 'package:gymvita_connect/screens/nav_screens/home/dashboard_card_screens/workout/exercise_page.dart';
import 'package:gymvita_connect/utils/navigation.dart';
import 'package:gymvita_connect/widgets/appbar.dart';
import 'package:gymvita_connect/widgets/home/dashboard/workout_plan_tile.dart';

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
      appBar: const CustomAppBar(title: 'Workout Plan'),
      body: Padding(
        padding: EdgeInsets.all(20.h),
        child: FutureBuilder<List<dynamic>>(
          future: workoutPlanController.fetchWorkoutPlan(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No workout plans available right now'));
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            var details = snapshot.data!;

            return ListView.builder(
              itemCount: details.length,
              itemBuilder: (context, index) {
                var item = details[index] as Map<String, dynamic>;
                var day = item.keys.first;
                var bodyPart = item[day]['part'];
                var exercises = item[day]['exercise']; // Get the exercises for this day

                return WorkoutPlanTile(
                  ontap: () {
                    // Pass both bodyPart and exercises to the ExercisePage
                    navigateWithAnimation(
                      context,
                      ExercisePage(bodyPart: bodyPart, exercises: exercises),
                    );
                  },
                  day: day,
                  bodyPart: bodyPart,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
