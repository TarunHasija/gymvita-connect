import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';

class WorkoutPlanController extends GetxController {
  var isRemindMe = false.obs();

  void toggleReminder() {
    isRemindMe != isRemindMe;
  }

  final authController = Get.find<AuthController>();

  // Store the DocumentSnapshot separately
  final workoutSnapshot = Rx<DocumentSnapshot?>(null);

  // Store the list of details separately
  final workoutDetails = Rx<List<dynamic>?>(null);

Future<List<dynamic>> fetchWorkoutPlan() async {
  // Create a reference to the document
  DocumentReference nutritionDocRef = FirebaseFirestore.instance
      .collection(authController.storedGymCode.value)
      .doc('clients')
      .collection('clients')
      .doc(authController.storedUid.value);

  // Get the document snapshot
  DocumentSnapshot documentSnapshot = await nutritionDocRef.get();

  // Check if the document exists
  if (documentSnapshot.exists) {
    // Extract the details array from the document
    List<dynamic> workoutDetails = documentSnapshot['WorkoutPlan'][0]['details'] ?? [];
    print(workoutDetails);
    return workoutDetails;
  } else {
    // Return an empty list if the document does not exist
    return [];
  }
}

}
