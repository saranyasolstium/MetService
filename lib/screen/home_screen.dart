import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/screen/create_job/create_job_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


extension HomeAction on HomeScreen {
  onAttendance() {
    AttendanceController attendance = Get.find();
    Get.toNamed(NavPage.calendar);
    attendance.fetchAttendanceStatus();
    if (AppController.to.isAttendanceEngineer &&
        !attendance.isClockedIn &&
        attendance.arrSite.length == 0) {
      attendance.fetchSite();
    }

    // Get.find<AttendanceController>().fetchAttendance(isShowLoading: true);
  }

  onScheduleJob() {
    Get.toNamed(NavPage.scheduleScreen);
  }

  onJobHistory() {
    print('job history called');
    Get.toNamed(NavPage.jobHistory);
  }

  onCustomerInformation() {
    Get.toNamed(NavPage.customerInformation);
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colour.appLightGrey,
        body: SafeArea(
          child: Column(
            children: [
              profileView,
              Expanded(
                child: SingleChildScrollView(
                  child: homeContent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension HomeWidgets on HomeScreen {
  Widget get profileView {
    return Container(
      padding: EdgeInsets.only(top: 9.0, left: 17.0, bottom: 22.0),
      constraints: BoxConstraints(
        minHeight: 75.dynamic,
      ),
      color: Color(0xFFFFFFFF),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Logged in as ',
                style: TextStyle(
                    color: Colour.appDarkGrey,
                    fontSize: 12.dynamic,
                    fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 8.0,
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      width: 30.dynamic,
                      height: 30.dynamic,
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        fit: BoxFit.fill,
                        imageUrl:
                            AppController.user.employeeDetails?.profileImage ??
                                "",
                        placeholder: (_, url) => Image.asset('images/user.png'),
                        errorWidget: (_, __, ___) =>
                            Image.asset('images/user.png'),
                      ),
                      decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   fit: BoxFit.contain,
                        //
                        //   image: AssetImage('images/user.png'),
                        // ),
                        border: Border.all(
                          color: Colors.blue,
                        ),
                        borderRadius: BorderRadius.circular(37.5.dynamic),
                      ),
                    ),
                    Text(
                      '   ${AppController.user.name}',
                      style: TextStyle(
                          color: Colour.appText,
                          fontSize: 16.dynamic,
                          fontWeight: FontWeight.w400),
                    ),
                    // Icon(
                    //   Icons.keyboard_arrow_down,
                    //   color: Colour.appBlue,
                    //   size: 30.dynamic,
                    // ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              width: Get.width * 0.4,
              decoration: BoxDecoration(
                color: Colour.appBlue,
                borderRadius: BorderRadius.all(
                  Radius.circular(30.dynamic),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colour.appBlue.withOpacity(0.5),
                    blurRadius: 30,
                    offset: Offset(0.0, 5.0),
                    spreadRadius: 3,
                  )
                ],
              ),
              child: Padding(
                padding: EdgeInsets.only(left: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.medical_services_outlined,
                      color: Colors.white,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => CreateJobScreen());
                      },
                      child: Text(
                        'Create Job',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.dynamic,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        
        ],
      ),
    );
  }

  Widget get jobStatus {
    return Row(
      children: [
        HomeCard(
          color: Color(0xFF14CE1A),
          jobCount: '123',
          jobName: 'Jobs Completed',
        ),
        SizedBox(
          width: 16.dynamic,
        ),
        HomeCard(
          color: Colour.appBlue,
          jobCount: '80',
          jobName: 'Service Days',
        ),
      ],
    );
  }

  Widget get homeContent {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 17.0),
      color: Colour.appLightGrey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 18.dynamic,
          ),
          GestureDetector(
            child: HomeMainCard(
              imageName: 'images/attendence.png',
              name: 'Attendance',
            ),
            onTap: this.onAttendance,
          ),
          SizedBox(
            height: 18.dynamic,
          ),
          GestureDetector(
            onTap: this.onScheduleJob,
            child: HomeMainCard(
              imageName: 'images/schedule.png',
              name: 'Scheduled Job',
            ),
          ),
          SizedBox(
            height: 18.dynamic,
          ),
          GestureDetector(
            onTap: this.onJobHistory,
            child: HomeMainCard(
              imageName: 'images/job_history.png',
              name: 'Job History',
            ),
          ),
          SizedBox(
            height: 18.dynamic,
          ),
          GestureDetector(
            onTap: this.onCustomerInformation,
            child: HomeMainCard(
              imageName: 'images/customer_info.png',
              name: 'Customer Information',
            ),
          ),
          SizedBox(
            height: 18.dynamic,
          ),
          // SafeArea(
          //   child: Padding(
          //     padding: EdgeInsets.only(top: 26.0, bottom: 34.0),
          //     child: Center(
          //       child: Image.asset(
          //         'images/poweredby.png',
          //         fit: BoxFit.fill,
          //         // width: 60.dynamic,
          //         // height: 60.dynamic,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class HomeMainCard extends StatelessWidget {
  final String? imageName;
  final String? name;
  HomeMainCard({this.imageName, this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: 193.dynamic,
      ),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.fromLTRB(
          93.dynamic, 16.7.dynamic, 92.8.dynamic, 15.9.dynamic),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(imageName!),
          ),
          SizedBox(
            height: 15.1.dynamic,
          ),
          Text(
            name!,
            softWrap: false,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colour.appBlue,
              fontSize: 16.dynamic,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final Color? color;
  final String? jobName;
  final String? jobCount;
  HomeCard({this.color, this.jobCount, this.jobName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding:
            EdgeInsets.fromLTRB(20.dynamic, 17.dynamic, 19.dynamic, 13.dynamic),
        height: 93.dynamic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$jobName',
              style: TextStyle(
                  color: Colour.appDarkGrey,
                  fontSize: 14.dynamic,
                  fontWeight: FontWeight.w400),
            ),
            Text(
              '$jobCount',
              style: TextStyle(
                  color: color,
                  fontSize: 30.dynamic,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
