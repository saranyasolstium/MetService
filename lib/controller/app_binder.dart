import 'package:eagle_pixels/model/get_scheduled_job.dart';

import 'package:eagle_pixels/controller/attendance_controller.dart';

import 'package:get/get.dart';

import 'app_controller.dart';

class AppBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AppController(), permanent: true);

    Get.put(GetScheduledList());

    Get.lazyPut(() => AttendanceController());
  }
}
