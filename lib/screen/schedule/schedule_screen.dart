import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class ScheduleScreen extends StatefulWidget {
  static String id = '/schedule_screen';

  @override
  _ScheduleScreenState createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
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
            onPressed: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              color: Colors.grey,
            ),
          ),
          title: Text(
            'Schedule Job',
            style: TextStyle(
                color: Colour.appBlack,
                fontWeight: FontWeight.w400,
                fontSize: 16.dynamic),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(17.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 50.dynamic,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.white,
                ),
                child: Row(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: Colour.appBlue,
                    ),
                    Expanded(
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.values[],
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Today'),
                          Text('Today'),
                        ],
                      ),
                    ),
                    Text(
                      'Change',
                      style: TextStyle(
                          color: Colour.appBlue,
                          fontWeight: FontWeight.w400,
                          fontSize: 16.dynamic),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
