import 'dart:core';
import 'dart:math';

import 'package:eagle_pixels/api/fcm/firebase_api.dart';
import 'package:eagle_pixels/api/fcm/notification_sender.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:eagle_pixels/screen/Attendance/time_out_screen.dart';
import 'package:eagle_pixels/screen/home/my_reward_screen.dart';
import 'package:eagle_pixels/screen/job_history/job_history_screen.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/schedule/schedule_screen.dart';
import 'package:eagle_pixels/screen/toast/jobcompleted_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:toast/toast.dart';

import 'colors.dart';
import 'controller/app_binder.dart';
import 'controller/app_controller.dart';
import 'dynamic_font.dart';
import 'screen/Attendance/calendar_screen.dart';
import 'screen/attendance/attendance_service_list_screen.dart';
import 'screen/customer_information/customer_information_screen.dart';

class NavPage {
  static String calendar = '/calendar';
  static String clockIn = '/clockIn';
  static String clockOut = '/clockOut';
  static String scheduleScreen = '/schedule_screen';
  static String jobCompleted = '/jobCompleted';
  static String myReward = '/myReward';
  static String jobHistory = '/jobHistory';
  static String scheduleJobDetailsScreen = '/scheduleJobDetailsScreen';
  static String root = "/";
  static String attendanceServiceList = '/AttendanceServiceList';
  static String jobDetail = '/jobDetail';
  static String customerInformation = '/customerInformation';
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseApi().initNotification();

 // String? fcmToken = await SharedPreferencesHelper.getFCMToken();
  

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
    // Initialize ToastContext here before runApp
    ToastContext toastContext = ToastContext();
    toastContext.init(context);

    return GetMaterialApp(
      // title: 'Flutter Demo',
      getPages: [
        GetPage(
            name: '/',
            page: () {
              return Obx(() {
                return AppController.to.rootView();
              });
            }),
        GetPage(name: '/login', page: () => LoginScreen()),
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
        // GetPage(
        //     name: NavPage.jobServiceReportScreen,
        //     page: () => ServiceReportScreen()),
        // GetPage(name: NavPage.confirmation, page: () => ConfirmationScreen()),
        GetPage(
            name: NavPage.customerInformation,
            page: () => CustomerInformationScreen()),
      ],
      initialBinding: AppBinding(),

      theme: ThemeData(
        primaryColor: Colour.appBlue,
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colors.green,
          contentTextStyle:
              TextStyle(fontSize: 16.dynamic, color: Colors.white),
        ),
      ),
      initialRoute: NavPage.root,

      // home: FeedbackScreen(),
    );
  }
}
