import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';

class MonthlyAnalysisController extends GetxController {
    final UserDataController userController = Get.find<UserDataController>();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String userId;

  MonthlyAnalysisController({required this.userId});

  RxBool canSubmit = true.obs;

  Future<void> submitAnalysis({
    required double weight,
    required double height,
    required double bicep,
    required double hips,
    required double thighs,
    required double waist,
    required double chest,
    required double tricep,
  }) async {
    DateTime now = DateTime.now();
    String year = now.year.toString();
    String month = _getMonthName(now.month);


    // Access userDocument from UserDataController instead of fetching it again
    DocumentSnapshot? userDoc = userController.userDocument.value;

    if (userDoc == null || !userDoc.exists) {
      throw Exception('User document does not exist');
    }

    Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
    Map<String, dynamic>? monthlyAnalysis = userData?['monthlyAnalysis'] as Map<String, dynamic>?;

    // Check if analysis for the year and month already exists
    if (monthlyAnalysis != null &&
        monthlyAnalysis[year] != null &&
        monthlyAnalysis[year][month] != null) {
      canSubmit.value = false;
      return;
    }

    // Update Firestore with the new analysis
    await _firestore.collection('users').doc(userId).set({
      'monthlyAnalysis': {
        year: {
          month: {
            'weight': weight,
            'height': height,
            'bicep': bicep,
            'hips': hips,
            'thighs': thighs,
            'waist': waist,
            'chest': chest,
            'tricep': tricep,
          }
        }
      }
    }, SetOptions(merge: true));

    // Update the document in the controller after submission
    DocumentSnapshot updatedDoc = await _firestore.collection('users').doc(userId).get();
    userController.userDocument.value = updatedDoc;

    canSubmit.value = false;
  }

  Future<Map<String, dynamic>> retrieveAnalysis({required String period}) async {
    DateTime now = DateTime.now();
    DateTime startDate;

    if (period == '6months') {
      startDate = DateTime(now.year, now.month - 6);
    } else if (period == '1year') {
      startDate = DateTime(now.year - 1, now.month);
    } else {
      throw 'Invalid period';
    }

    DocumentSnapshot? userDoc = userController.userDocument.value;
    Map<String, dynamic> analysisData = {};

//     if (userDoc != null && userDoc.exists) {
// Map<String, dynamic>? monthlyAnalysis = userDoc.data()?['monthlyAnalysis'] as Map<String, dynamic>?;
//       if (monthlyAnalysis != null) {
//         monthlyAnalysis.forEach((year, monthsData) {
//           monthsData.forEach((month, data) {
//             DateTime entryDate = DateTime(int.parse(year), _getMonthNumber(month));
//             if (entryDate.isAfter(startDate)) {
//               analysisData[year] ??= {};
//               analysisData[year][month] = data;
//             }
//           });
//         });
//       }
//     }

    return analysisData;
  }

  String _getMonthName(int month) {
    const List<String> months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    return months[month - 1];
  }

  int _getMonthNumber(String monthName) {
    const List<String> months = [
      'jan',
      'feb',
      'mar',
      'apr',
      'may',
      'jun',
      'jul',
      'aug',
      'sep',
      'oct',
      'nov',
      'dec'
    ];
    return months.indexOf(monthName) + 1;
  }
}
