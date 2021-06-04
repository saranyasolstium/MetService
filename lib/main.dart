import 'dart:core';
import 'dart:math';

// import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:eagle_pixels/screen/Attendance/time_out_screen.dart';
import 'package:eagle_pixels/screen/home/my_reward_screen.dart';
import 'package:eagle_pixels/screen/job_history/job_history_screen.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/schedule/job_checklist_screen.dart';
import 'package:eagle_pixels/screen/schedule/schedule_job_details.dart';
import 'package:eagle_pixels/screen/schedule/schedule_screen.dart';
import 'package:eagle_pixels/screen/schedule/service_report_screen.dart';
import 'package:eagle_pixels/screen/toast/jobcompleted_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'colors.dart';
import 'controller/app_binder.dart';
import 'controller/app_controller.dart';
import 'dynamic_font.dart';
import 'screen/Attendance/calendar_screen.dart';
import 'screen/attendance/attendance_service_list_screen.dart';

class NavPage {
  static String calendar = '/calendar';
  static String clockIn = '/clockIn';
  static String clockOut = '/clockOut';
  static String scheduleScreen = '/schedule_screen';
  static String jobCompleted = '/jobCompleted';
  static String myReward = '/myReward';
  static String jobHistory = '/jobHistory';
  // static String jobCheckListScreen = '/joCheckList';
  static String jobServiceReportScreen = '/jobServiceReport';
  static String scheduleJobDetailsScreen = '/scheduleJobDetailsScreen';
  static String root = '/';
  static String attendanceServiceList = 'AttendanceServiceList';
  static String jobDetail = '/jobDetail';
  // static String confirmation = '/confirmation';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );

  runApp(MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    MediaQueryData query = MediaQuery.of(context);
    double minimum = min(query.size.width, query.size.height);
    double defaultSize = 360;
    scale = minimum / defaultSize;
    return GetMaterialApp(
      // title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
            name: '/',
            page: () {
              return Obx(() {
                return AppController.to.rootView();
              });
            }),
        GetPage(name: NavPage.calendar, page: () => CalendarScreen()),
        GetPage(name: NavPage.clockIn, page: () => TimeInScreen()),
        GetPage(name: NavPage.clockOut, page: () => TimeOutScreen()),
        GetPage(name: NavPage.scheduleScreen, page: () => ScheduleScreen()),
        // GetPage(
        //     name: NavPage.scheduleJobDetailsScreen,
        //     page: () => ScheduleJobDetailsScreen()),
        GetPage(name: NavPage.jobCompleted, page: () => JobCompletedScreen()),
        GetPage(name: NavPage.myReward, page: () => MyRewardScreen()),
        GetPage(name: NavPage.jobHistory, page: () => JobHistoryScreen()),
        GetPage(
            name: NavPage.attendanceServiceList,
            page: () => AttendanceServiceListScreen()),
        // GetPage(
        //   name: NavPage.jobCheckListScreen,
        //   page: () => JobCheckListScreen(),
        // ),
        GetPage(
            name: NavPage.jobServiceReportScreen,
            page: () => ServiceReportScreen()),
        // GetPage(name: NavPage.confirmation, page: () => ConfirmationScreen()),
      ],
      initialBinding: AppBinding(),

      theme: ThemeData(
          primaryColor: Colour.appBlue,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins'),
      initialRoute: NavPage.root,
      // home: JobCheckListScreen(),
    );
  }
}

// class Demo extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("ListView"),
//       ),
//       body: Container(
//         color: Colors.yellow,
//         child: ListView.builder(
//           itemBuilder: (context, index) {
//             return TestItem();
//           },
//           itemCount: 2,
//         ),
//       ),
//     );
//   }
// }
//
// class TestItem extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: GridView.count(
//         shrinkWrap: true,
//         scrollDirection: Axis.horizontal,
//         crossAxisCount: 2,
//         physics: NeverScrollableScrollPhysics(),
//         children: [
//           Text('fdsa'),
//           Text('fafds'),
//         ],
//       ),
//     );
//   }
// }

class Demo extends StatelessWidget {
  final list = generateNumbers();
  Widget content() {
    return ListView.builder(
      itemBuilder: (con, index) {
        return Column(
          children: [
            Text('TopView'),
            GridView.builder(
                itemCount: list.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 3),
                shrinkWrap: true,
                itemBuilder: (con, ind) {
                  var i = list[ind];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      // height: 20,
                      child: Text(i.toString()),
                      color: Colors.blue,
                    ),
                  );
                }),
          ],
        );
      },
      itemCount: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(),
      home: SafeArea(
        child: Scaffold(
          body: content(),
        ),
      ),
    );
  }
}

List<int> generateNumbers() => List<int>.generate(10, (i) => i + 1);
// List<int> generateList() => List<int>.generate(2, (i) => i + 1);
