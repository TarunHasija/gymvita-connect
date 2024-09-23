import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';

class GymInfoController extends GetxController {
  final AuthController authController = Get.find();
  final gymData = Rx<Map<String, dynamic>?>(null);

  @override
  void onInit() {
    super.onInit();
    
    // Listen for changes in storedGymCode
    ever(authController.storedGymCode, (_) {
      if (authController.storedGymCode.value.isNotEmpty) {
        getGymInfo();
      }
    });

    // Check if storedGymCode already has a value
    if (authController.storedGymCode.value.isNotEmpty) {
      getGymInfo();
    }
  }

  Future<Map<String, dynamic>?> getGymInfo() async {
    try {
      DocumentReference gymInfoDocRef = FirebaseFirestore.instance
          .collection(authController.storedGymCode.value)
          .doc('gymPersonalInfo');

      DocumentSnapshot gymInfoSnapshot = await gymInfoDocRef.get();

      if (gymInfoSnapshot.exists) {
        gymData.value = gymInfoSnapshot.data() as Map<String, dynamic>?;

        print("Fetched gym data: ${gymData.value}");

        return gymData.value;
      } else {
        print("No gym data found for the given gym code.");
        return null;
      }
    } catch (e) {
      print("Error fetching gym info: $e");
      return null;
    }
  }
}
