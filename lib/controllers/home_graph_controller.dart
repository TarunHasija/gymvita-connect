import 'package:get/get.dart';

class HomeGraphController extends GetxController {
  
  var selectedBodyPart = 'weight'.obs;

  void selectBodyPart(String bodyPart) {
    selectedBodyPart.value = bodyPart;
  }
}


