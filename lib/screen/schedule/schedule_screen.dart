import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:eagle_pixels/screen/views/ChangeDateView.dart';
import 'package:eagle_pixels/screen/views/service_view.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/home/mypurchase_detail_screen.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

import '../../main.dart';

// extension ScheduleAction on ScheduleScreen {
//
//
// }

class ScheduleScreen extends StatelessWidget {
  final TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);
  final ScheduleListController schedule = Get.put(ScheduleListController());
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
                  Obx(
                    () => Expanded(
                      child: ListView.builder(
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
                                onJob: () {
                                  Get.toNamed(NavPage.jobCheckListScreen);
                                },
                                onSeeDetail: () {}),
                          );
                        },
                        // return Text('Hello');
                        // },
                        // itemCount: 10,
                        itemCount: schedule.scheduleList.length,
                      ),
                    ),
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
