import 'package:get/get.dart';

class CreateJobController extends GetxController {
  final valueOfDrop = 'A'.obs;

  void setSelected(String value) {
    valueOfDrop.value = value;
  }
}
