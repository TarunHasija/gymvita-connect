import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/auth_controller.dart';

class UserDataController extends GetxController {
  final usergymCode = ''.obs;
  final userName = ''.obs;
  final userUid = ''.obs;
  final email = ''.obs;

  final userDocument = Rx<DocumentSnapshot?>(null); 
  // current user data
  
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

  Future<void> fetchRecommendedPlayList()async{
    
  }


}
