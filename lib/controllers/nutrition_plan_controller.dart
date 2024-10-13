import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
class NutritionPlanController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    fetchNutritionPlan();
  }

  var isRemindMe = false.obs;

  void toggleReminder() {
    isRemindMe.value = !isRemindMe.value;
  }

  final authController = Get.find<AuthController>();

  // Store the DocumentSnapshot separately
  final nutritionSnapshot = Rx<DocumentSnapshot?>(null);

  // Store the list of details separately
  final nutritionDetails = Rx<List<dynamic>?>(null);

  Future<void> fetchNutritionPlan() async {
    // Check if storedGymCode is available
    if (authController.storedGymCode.value == null ||
        authController.storedGymCode.value.isEmpty) {
      print("storedGymCode is not set. Cannot fetch nutrition plan.");
      return; // Exit the function early
    }

    // Ensure that storedUid is also available before proceeding
    if (authController.storedUid.value == null ||
        authController.storedUid.value.isEmpty) {
      print("storedUid is not set. Cannot fetch nutrition plan.");
      return; // Exit the function early
    }

    try {
      // Proceed with Firestore query if both storedGymCode and storedUid are set
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
        nutritionDetails.value =
            documentSnapshot['NutritionPlan'][0]['details'];
      } else {
        nutritionDetails.value = [];
      }
    } catch (e) {
      print("Error fetching nutrition plan: $e");
    }
  }
}
