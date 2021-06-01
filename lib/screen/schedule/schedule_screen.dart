import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/schedule/schedule_job_details.dart';
import 'package:eagle_pixels/screen/views/ChangeDateView.dart';
import 'package:eagle_pixels/screen/views/service_view.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';

import 'package:get/get.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';

import '../../main.dart';
import 'package:toast/toast.dart';

class ScheduleScreen extends StatelessWidget {
  final TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);
  final ScheduleListController schedule = Get.put(ScheduleListController());
  final AttendanceController attendance = Get.find();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colour.appLightGrey,
        appBar: AppBar(
          toolbarHeight: 66.dynamic,
          elevation: 0,
          backgroundColor: Color(0xFFFFFFFF),
          leading: RawMaterialButton(
            onPressed: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colour.appBlue,
            ),
          ),
          title: titleText('Scheduled Job'),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ChangeDateView(
                    date: schedule.selectedDate,
                    didEnd: () {
                      print('change date called');
                      schedule.fetchScheduleList();
                    },
                  ),
                  SizedBox(
                    height: 17.dynamic,
                  ),
                  Expanded(
                    child: Obx(() {
                      if (schedule.viewState.value.isSuccess) {
                        return ListView.builder(
                          itemBuilder: (context, index) {
                            var item = schedule.scheduleList[index];
                            print('item $index');
                            // var item = ScheduleList();
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 15.0),
                              child: ServiceView(
                                  item: item,
                                  buttonTitle: 'Start Job',
                                  // isNeedStatus: ,
                                  isNeedDetail: true,
                                  isNeedStartJob: true,
                                  onJob: () {
                                    if (attendance.isClockedIn) {
                                      Toast.show(
                                          'Please clock out the attendance',
                                          Get.context);
                                    } else {
                                      Get.to(
                                        () => JobDetailScreen(
                                          isNeedStartJob: true,
                                          jobID: item.aServiceID!,
                                        ),
                                      );
                                    }

                                    // Get.bottomSheet(
                                    //   JobDetailScreen(
                                    //     isNeedContainer: true,
                                    //   ),
                                    //   ignoreSafeArea: false,
                                    //   isScrollControlled: true,
                                    // );
                                  },
                                  onSeeDetail: () {}),
                            );
                          },
                          // return Text('Hello');
                          // },
                          // itemCount: 10,
                          itemCount: schedule.scheduleList.length,
                        );
                      } else if (schedule.viewState.value.isFailed) {
                        return Center(
                          child: Text(
                            'No Scheduled job on this day',
                            style: TextStyle(fontSize: 15.dynamic),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                  ),
                ],
              ),
            ),
            AppController.to.defaultLoaderView(),
          ],
        ),
      ),
    );
  }
}
