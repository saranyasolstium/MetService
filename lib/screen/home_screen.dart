import 'package:eagle_pixels/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'schedule/schedule_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colour.appLightGrey,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 9.0, left: 17.0, bottom: 22.0),
                  constraints: BoxConstraints(
                    minHeight: 75.dynamic,
                  ),
                  color: Color(0xFFFFFFFF),
                  child: Column(
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
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.contain,
                                  image: AssetImage('images/user.png'),
                                ),
                                border: Border.all(
                                  color: Colors.blue,
                                ),
                                borderRadius:
                                    BorderRadius.circular(37.5.dynamic),
                              ),
                            ),
                            Text(
                              '   Jhon Doe',
                              style: TextStyle(
                                  color: Colour.appText,
                                  fontSize: 16.dynamic,
                                  fontWeight: FontWeight.w400),
                            ),
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: Colour.appBlue,
                              size: 30.dynamic,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 22.dynamic,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 17.0),
                  color: Colour.appLightGrey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
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
                      ),
                      SizedBox(
                        height: 18.dynamic,
                      ),
                      HomeMainCard(
                        imageName: 'images/attendence.png',
                        name: 'Attendance',
                      ),
                      SizedBox(
                        height: 18.dynamic,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ScheduleScreen(),
                            ),
                          );
                        },
                        child: HomeMainCard(
                          imageName: 'images/schedule.png',
                          name: 'Scheduled Job',
                        ),
                      ),
                      SizedBox(
                        height: 18.dynamic,
                      ),
                      HomeMainCard(
                        imageName: 'images/job_history.png',
                        name: 'Job History',
                      ),
                      SafeArea(
                        child: Padding(
                          padding: EdgeInsets.only(top: 26.0, bottom: 34.0),
                          child: Center(
                            child: Image.asset(
                              'images/poweredby.png',
                              fit: BoxFit.fill,
                              // width: 60.dynamic,
                              // height: 60.dynamic,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeMainCard extends StatelessWidget {
  final String imageName;
  final String name;
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
            image: AssetImage(imageName),
          ),
          SizedBox(
            height: 15.1.dynamic,
          ),
          Text(
            name,
            style: TextStyle(
                color: Colour.appBlue,
                fontSize: 16.dynamic,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}

class HomeCard extends StatelessWidget {
  final Color color;
  final String jobName;
  final String jobCount;
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
