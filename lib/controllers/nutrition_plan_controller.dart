import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';
import 'package:intl/intl.dart';

class NutritionPlanController extends GetxController {
  @override
  void onInit() {
    fetchNutritionPlan();
    super.onInit();
  }

  var isRemindMe = false.obs;

  void toggleReminder() {
    isRemindMe.value = !isRemindMe.value;
  }

  final AuthController authController = Get.find<AuthController>();

  final nutritionSnapshot = Rx<DocumentSnapshot?>(null);

  final nutritionDetails = Rx<List<dynamic>?>(null);
  RxList<String> timeList = <String>[].obs;

  RxMap<String, String> timeMealMap = <String, String>{}.obs;

  Future<void> fetchNutritionPlan() async {
    if (authController.storedGymCode.value.isEmpty) {
      print("storedGymCode is not set. Cannot fetch nutrition plan.");
      return;
    }

    if (authController.storedUid.value.isEmpty) {
      print("storedUid is not set. Cannot fetch nutrition plan.");
      return;
    }

    try {
      DocumentReference nutritionDocRef = FirebaseFirestore.instance
          .collection(authController.storedGymCode.value)
          .doc('clients')
          .collection('clients')
          .doc(authController.storedUid.value);

      DocumentSnapshot documentSnapshot = await nutritionDocRef.get();

      nutritionSnapshot.value = documentSnapshot;

      if (documentSnapshot.exists) {
        nutritionDetails.value =
            documentSnapshot['NutritionPlan'][0]['details'];

        print(nutritionDetails.value);

        for (var item in nutritionDetails.value!) {
  // Extract the 'time' as a String
  String? timeStr = item['time'];
  String? meal = item['meal'];

  if (timeStr != null && meal != null) {
    try {
      // Parse the time string "HH:mm" into a DateTime object
      DateTime parsedTime = DateFormat("HH:mm").parse(timeStr);
      
      // Create a new DateTime by combining the current date and parsed time
      DateTime now = DateTime.now();
      DateTime scheduledTime = DateTime(now.year, now.month, now.day, parsedTime.hour, parsedTime.minute);

      // Add the formatted time and meal to the map
      timeMealMap[DateFormat.jm().format(scheduledTime)] = meal;
    } catch (e) {
      print("Error parsing time: $e");
    }
  }
}
      }
    } catch (e) {
      print("Error fetching nutrition plan: $e");
    }
  }

  setReminder() {}
}
