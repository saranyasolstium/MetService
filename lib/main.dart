import 'dart:core';
import 'dart:math';

import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:eagle_pixels/screen/Attendance/time_out_screen.dart';
import 'package:eagle_pixels/screen/home/my_reward_screen.dart';
import 'package:eagle_pixels/screen/job_history/job_history_screen.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/schedule/schedule_screen.dart';
import 'package:eagle_pixels/screen/toast/confirmation_screen.dart';
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

class NavPage {
  static String calendar = '/calendar';
  static String clockIn = '/clockIn';
  static String clockOut = '/clockOut';
  static String scheduleScreen = '/schedule_screen';
  static String jobCompleted = '/jobCompleted';
  static String myReward = '/myReward';
  static String jobHistory = '/jobHistory';
  // static String confirmation = '/confirmation';
}

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

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
      title: 'Flutter Demo',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(
            name: '/',
            page: () {
              print('root loaded');
              return Obx(() {
                print('root loaded');
                return AppController.to.rootView();
              });
            }),
        GetPage(name: NavPage.calendar, page: () => CalendarScreen()),
        GetPage(name: NavPage.clockIn, page: () => TimeInScreen()),
        GetPage(name: NavPage.clockOut, page: () => TimeOutScreen()),
        GetPage(name: NavPage.scheduleScreen, page: () => ScheduleScreen()),
        GetPage(name: NavPage.jobCompleted, page: () => JobCompletedScreen()),
        GetPage(name: NavPage.myReward, page: () => MyRewardScreen()),
        GetPage(name: NavPage.jobHistory, page: () => JobHistoryScreen()),
        // GetPage(name: NavPage.confirmation, page: () => ConfirmationScreen()),
      ],
      initialBinding: AppBinding(),
      theme: ThemeData(
          primaryColor: Colour.appBlue,
          primarySwatch: Colors.blue,
          fontFamily: 'Poppins'),
      initialRoute: '/',
    );
  }
}
