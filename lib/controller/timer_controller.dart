import 'dart:async';

import 'package:get/get.dart';

class TimerController extends GetxController {
  static TimerController get to => Get.find<TimerController>();
  Timer timer;
  final currentDate = DateTime.now().obs;

  @override
  void onInit() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      currentDate.value = DateTime.now();
      // print('Timer called ');
    });
    super.onInit();
  }

  @override
  void disposeId(Object id) {
    print('dispoed id $id');
    super.disposeId(id);
  }

  clearMemory() {
    timer.cancel();
    timer = null;
    print('Timer controller deinited');
  }

  @override
  void onClose() {
    clearMemory();
    super.onClose();
  }

  @override
  void dispose() {
    clearMemory();
    super.dispose();
  }
}
