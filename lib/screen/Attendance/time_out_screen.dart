import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class TimeOutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mark Attendance'),
        backgroundColor: CupertinoColors.white,
        elevation: 0,
        leading: Icon(
          Icons.arrow_back,
          color: Colour.appBlue,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 17.dynamic),
          color: HexColor.fromHex("F7F7F7"),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 22.dynamic),
                child: Align(
                  child: Text(
                    'Employee Information',
                    style: TextStyle(
                        color: Colour.appBlue,
                        fontSize: 16.dynamic,
                        fontWeight: FontWeight.normal),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'images/user.png',
                ),
              ),
              Row(
                children: [
                  TimeInOutDetailItem(),
                  TimeInOutDetailItem(),
                ],
              ),
              Row(
                children: [
                  TimeInOutDetailItem(),
                  TimeInOutDetailItem(),
                ],
              ),
              Row(
                children: [
                  TimeInOutDetailItem(),
                  TimeInOutDetailItem(),
                ],
              ),
              Row(
                children: [
                  TimeInOutDetailItem(),
                  TimeInOutDetailItem(),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 22.dynamic),
                child: Align(
                  child: Text(
                    'Time Out',
                    style: TextStyle(
                        color: Colour.appBlue,
                        fontSize: 16.dynamic,
                        fontWeight: FontWeight.normal),
                  ),
                  alignment: Alignment.centerLeft,
                ),
              ),
              Container(
                color: Colors.white,
                height: 100,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeComponentItem(
                      topText: "HH",
                      bottomText: "01",
                      bottomTextColor: 'DB1A1A',
                    ),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                      bottomTextColor: 'DB1A1A',
                    ),
                    TimeComponentItem(
                      topText: "MM",
                      bottomText: "01",
                      bottomTextColor: 'DB1A1A',
                    ),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                      bottomTextColor: 'DB1A1A',
                    ),
                    TimeComponentItem(
                      topText: "SS",
                      bottomText: "01",
                      bottomTextColor: 'DB1A1A',
                    ),
                    TimeComponentItem(
                      topText: '',
                      bottomText: "AM",
                      bottomTextColor: '9A9A9A',
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colour.appRed,
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.dynamic),
                  ),
                ),
                margin: EdgeInsets.symmetric(vertical: 32.dynamic),
                width: double.infinity,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'End the day',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.dynamic,
                        fontWeight: FontWeight.w300),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
