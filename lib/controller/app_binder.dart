import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/my_purchase_controller.dart';
import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Get.smartManagement = SmartManagement.keepFactory;
    Get.put(AppController(), permanent: true);
    Get.put(AttendanceController(), permanent: true);
    Get.put(TimerController(), permanent: true);
    Get.put(MyPurchaseController(), permanent: true);
  }
}
