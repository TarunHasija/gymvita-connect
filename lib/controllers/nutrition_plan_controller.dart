import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';

class NutritionPlanController extends GetxController {
  var isRemindMe = false.obs();

  void toggleReminder() {
    isRemindMe != isRemindMe;
  }

  final authController = Get.find<AuthController>();

  // Store the DocumentSnapshot separately
  final nutritionSnapshot = Rx<DocumentSnapshot?>(null);

  // Store the list of details separately
  final nutritionDetails = Rx<List<dynamic>?>(null);

  Future<void> fetchNutritionPlan() async {
    DocumentReference nutritionDocRef = FirebaseFirestore.instance
        .collection(authController.storedGymCode.value)
        .doc('clients')
        .collection('clients')
        .doc(authController.storedUid.value);

    DocumentSnapshot documentSnapshot = await nutritionDocRef.get();

    // Assign the documentSnapshot to nutritionSnapshot
    nutritionSnapshot.value = documentSnapshot;

    // Extract the details array from the document and assign it
    if (documentSnapshot.exists) {
      nutritionDetails.value = documentSnapshot['NutritionPlan'][0]['details'];
    } else {
      nutritionDetails.value = [];
    }
  }
}
