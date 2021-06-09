import 'package:get/get.dart';

class CreateJobController extends GetxController {
  final valueOfDrop = ''.obs;

  void setSelected(String value) {
    valueOfDrop.value = value;
  }
}
