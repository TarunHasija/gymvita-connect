import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';

class UserDataController extends GetxController {
  final usergymCode = ''.obs;
  final userName = ''.obs;
  final userUid = ''.obs;
  final email = ''.obs;
  var userDoc = Rx<DocumentReference?>(null);
  final userDocument = Rx<DocumentSnapshot?>(null);
  //!userdata snapshot

  final authController = Get.find<AuthController>();

  @override
  void onInit() {
    super.onInit();
    ever(authController.storedUid, (_) => fetchUserDataIfReady());
    ever(authController.storedGymCode, (_) => fetchUserDataIfReady());
  }

  Future<void> fetchUserDataIfReady() async {
    if (authController.storedUid.value.isNotEmpty &&
        authController.storedGymCode.value.isNotEmpty) {
      await getUserData(
          authController.storedUid.value, authController.storedGymCode.value);
    } else {
      print("Waiting for UID or Gym Code...");
    }
  }

  Future<void> getUserData(String uid, String gymCode) async {
    print("$uid----------$gymCode");
    CollectionReference gymColRef = FirebaseFirestore.instance
        .collection(gymCode)
        .doc('clients')
        .collection('clients');
    DocumentReference clientDocRef = gymColRef.doc(uid);
    userDoc.value = clientDocRef;

    try {
      DocumentSnapshot docSnapshot = await clientDocRef.get();
      if (docSnapshot.exists) {
        userDocument.value = docSnapshot;
        print(userDocument.value?['email']);

        print('doc exists');
      } else {
        throw Exception("Document not found");
      }
    } catch (error) {
      print("Error fetching user data: ${error.toString()}");
    }
  }

  Future<void> updateUserData({
    required String name,
    required String phoneNo,
    required String dob,
    required String gender,
    required String services,
    required String fitnessGoals,
    required String allergies,
    required String injuries,
  }) async {
    final uid = authController.storedUid.value;
    final gymCode = authController.storedGymCode.value;

    if (uid.isNotEmpty && gymCode.isNotEmpty) {
      CollectionReference gymColRef = FirebaseFirestore.instance
          .collection(gymCode)
          .doc('clients')
          .collection('clients');
      DocumentReference clientDocRef = gymColRef.doc(uid);

      try {
        // Update Firestore
        await clientDocRef.update({
          'details.name': name,
          'phoneNo': phoneNo,
          'dob': dob,
          'gender': gender,
          'services': services.split(', '),
          'fitnessGoals': fitnessGoals.split(', '),
          'healthConsiderations': allergies,
          'medicalCondition': injuries,
        });

        // Refresh the userDocument in the controller
        DocumentSnapshot updatedDoc = await clientDocRef.get();
        userDocument.value = updatedDoc;

        Get.snackbar(
          'Success',
          'Profile updated successfully!',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 2),
        );
      } catch (e) {
        Get.snackbar('Error', 'Failed to update profile');
      }
    }
  }
}
