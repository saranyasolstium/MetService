import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../colors.dart';

class TimeInScreen extends StatelessWidget {
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
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 85.dynamic, bottom: 23.dynamic),
                child: Align(
                  child: Text(
                    'Time In',
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
                    ),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                    ),
                    TimeComponentItem(
                      topText: "MM",
                      bottomText: "01",
                    ),
                    TimeComponentItem(
                      topText: "",
                      bottomText: ":",
                    ),
                    TimeComponentItem(
                      topText: "SS",
                      bottomText: "01",
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
                margin: EdgeInsets.symmetric(vertical: 32.dynamic),
                width: double.infinity,
                color: HexColor.fromHex("14CE1A"),
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Start the day',
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

class TimeComponentItem extends StatelessWidget {
  final String topText;
  final String topTextColor;
  final String bottomText;
  final String bottomTextColor;

  TimeComponentItem(
      {this.topText = '',
      this.topTextColor = "9A9A9A",
      this.bottomText = '',
      this.bottomTextColor = "14CE1A"});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontSize: 20.dynamic,
              fontWeight: FontWeight.normal,
              color: HexColor.fromHex(topTextColor),
            ),
          ),
          Text(
            bottomText,
            style: TextStyle(
              fontSize: 29.dynamic,
              fontWeight: FontWeight.w700,
              color: HexColor.fromHex(bottomTextColor),
            ),
          ),
        ],
      ),
    );
  }
}

class TimeInOutDetailItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.dynamic),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Title',
              style: TextStyle(
                fontSize: 12.dynamic,
                fontWeight: FontWeight.normal,
                color: HexColor.fromHex("9A9A9A"),
              ),
            ),
            Text(
              'Description',
              style: TextStyle(
                fontSize: 14.dynamic,
                fontWeight: FontWeight.w600,
                color: HexColor.fromHex("333333"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
