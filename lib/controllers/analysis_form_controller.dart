import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';

class MonthlyAnalysisController extends GetxController {
  final UserController userController = Get.find<UserController>();

  // TextEditingControllers
  final weightController = TextEditingController();
  final heightController = TextEditingController();
  final bicepController = TextEditingController();
  final hipsController = TextEditingController();
  final thighsController = TextEditingController();
  final waistController = TextEditingController();
  final chestController = TextEditingController();
  final tricepController = TextEditingController();

  RxBool canSubmit = true.obs;

  @override
  void onInit() {
    super.onInit();
    loadAnalysisData();
  }

  Future<void> loadAnalysisData() async {
    DocumentSnapshot? userDocSnap = userController.userDocSnap.value;

    if (userDocSnap != null && userDocSnap.exists) {
      final data = userDocSnap.data();
      if (data is Map<String, dynamic>) {
        Map<String, dynamic>? monthlyAnalysis =
            data['monthlyAnalysis'] as Map<String, dynamic>?;

        if (monthlyAnalysis != null) {
          DateTime now = DateTime.now();
          String year = now.year.toString();
          String month = _getMonthName(now.month);

          if (monthlyAnalysis[year] != null &&
              monthlyAnalysis[year][month] != null) {
            final analysis = monthlyAnalysis[year][month];

            weightController.text = analysis['weight'].toString();
            heightController.text = analysis['height'].toString();
            bicepController.text = analysis['bicep'].toString();
            hipsController.text = analysis['hips'].toString();
            thighsController.text = analysis['thighs'].toString();
            waistController.text = analysis['waist'].toString();
            chestController.text = analysis['chest'].toString();
            tricepController.text = analysis['tricep'].toString();

            canSubmit.value = false;
          }
        }
      }
    }
  }

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

    DocumentSnapshot? userDocSnap = userController.userDocSnap.value;

    if (userDocSnap == null || !userDocSnap.exists) {
      throw Exception('User document does not exist');
    }

    final data = userDocSnap.data();
    if (data is Map<String, dynamic>) {
      Map<String, dynamic>? monthlyAnalysis =
          data['monthlyAnalysis'] as Map<String, dynamic>?;

      if (monthlyAnalysis != null &&
          monthlyAnalysis[year] != null &&
          monthlyAnalysis[year][month] != null) {
        canSubmit.value = false;
        return;
      }

      try {
        await userController.userDocRef.value?.set({
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

        DocumentSnapshot? updatedDocSnap =
            await userController.userDocRef.value?.get();

        if (updatedDocSnap != null) {
          userController.userDocSnap.value = updatedDocSnap;
        } else {
          print('Document not found');
          throw Exception('Document not found');
        }

        canSubmit.value = false;
      } catch (e) {
        print('Error submitting analysis: $e');
        throw Exception('Failed to submit analysis');
      }
    } else {
      print('User document data is not in the expected format.');
      throw Exception('User document data is not in the expected format.');
    }
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
