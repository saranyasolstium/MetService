import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/job_history_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:get/get.dart';

import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    // Get.smartManagement = SmartManagement.keepFactory;
    Get.put(AppController(), permanent: true);
    Get.create(() => ScheduleListController());
    Get.lazyPut(() => AttendanceController(), fenix: true);
    Get.create(() => TimerController());
    Get.create(() => JobHistoryController());
    // Get.create(() => TimerController(), tag: 'out');
  }
}
