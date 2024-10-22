import 'package:get/get.dart';
import 'package:gymvita_connect/controllers/usercontroller.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

class AnalysisGraphController extends GetxController {
  final UserController userController = Get.find<UserController>();

  List<Map<String, String>> getMonthsAndYears(
      int startMonthOffset, int numberOfMonths) {
    DateTime now = DateTime.now();
    List<Map<String, String>> monthsAndYears = [];

    for (int i = 0; i < numberOfMonths; i++) {
      DateTime currentMonth =
          DateTime(now.year, now.month - startMonthOffset - i, 1);
      String monthName = DateFormat('MMM').format(currentMonth).toLowerCase();
      String year = currentMonth.year.toString();

      monthsAndYears.add({'month': monthName, 'year': year});
    }

    return monthsAndYears;
  }

  LinkedHashMap<String, dynamic> getPreviousMonthsData(
      String bodyPart, int numberOfMonths, int startMonthOffset) {
    final userDocSnap = userController.userDocSnap.value;

    if (userDocSnap == null) {
      return LinkedHashMap<String, dynamic>();
    }

    Map<String, dynamic>? userData =
        userDocSnap.data() as Map<String, dynamic>?;

    if (userData == null) {
      return LinkedHashMap<String, dynamic>();
    }

    Map<String, dynamic>? monthlyAnalysis =
        userData['monthlyAnalysis'] as Map<String, dynamic>?;

    if (monthlyAnalysis == null) {
      return LinkedHashMap<String, dynamic>();
    }

    List<Map<String, String>> lastMonthsAndYears =
        getMonthsAndYears(startMonthOffset, numberOfMonths);

    LinkedHashMap<String, dynamic> bodyPartData =
        LinkedHashMap<String, dynamic>();

    for (var entry in lastMonthsAndYears) {
      String month = entry['month']!;
      String year = entry['year']!;

      if (monthlyAnalysis[year] != null &&
          monthlyAnalysis[year][month] != null &&
          monthlyAnalysis[year][month][bodyPart] != null) {
        bodyPartData['$month $year'] = monthlyAnalysis[year][month][bodyPart];
      }
    }

    return bodyPartData;
  }

  // Function to get data for the previous six months (last six months)
  LinkedHashMap<String, dynamic> getLastSixMonthsData(String bodyPart) {
    return getPreviousMonthsData(bodyPart, 6, 0); // Current 6 months
  } //not using it rightnow

  // Function to get data for the previous six months prior to the last six months
  LinkedHashMap<String, dynamic> getPreviousToPreviousSixMonthsData(
      String bodyPart) {
    return getPreviousMonthsData(bodyPart, 6, 6);
    // Previous to previous 6 months
  }
}
