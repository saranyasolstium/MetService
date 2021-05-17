import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:get/get.dart';
import 'package:jiffy/jiffy.dart';

class ScheduleJobDetailsScreen extends StatefulWidget {
  @override
  _ScheduleJobDetailsScreenState createState() =>
      _ScheduleJobDetailsScreenState();
}

class _ScheduleJobDetailsScreenState extends State<ScheduleJobDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color(0xff757575),
        child: Container(
          // padding: EdgeInsets.only(top: 30.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 13.dynamic,
              ),
              Center(
                child: CircleAvatar(
                  backgroundColor: Colour.appLightGrey,
                  radius: 23.dynamic,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.close,
                      size: 23.dynamic,
                      color: Colour.appBlue,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                      left: 30.dynamic,
                      bottom: 21.dynamic,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Colors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 13.dynamic,
                        ),
                        Text(
                          'Job Details',
                          style: TextStyle(
                              color: Colour.appBlue,
                              fontWeight: FontWeight.w400,
                              fontSize: 16.dynamic),
                        ),
                        SizedBox(
                          height: 21.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              'images/camera.png',
                            ),
                            SizedBox(
                              width: 13.dynamic,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hitech Security Camera',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    'ID - CCTVCAM5698533',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Purchase Date:',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    '12th May, 2020',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    'PO6589OLK68',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Purchase Date:',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    '12th May, 2020',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Name:',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24.dynamic,
                                        height: 24.dynamic,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image:
                                                AssetImage('images/user.png'),
                                          ),
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              37.5.dynamic),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.dynamic,
                                      ),
                                      Text(
                                        'Luis Philippe',
                                        style: TextStyle(
                                            color: Colour.appBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.dynamic),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Purchase Date:',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    '12th May, 2020',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Customer Name:',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        width: 24.dynamic,
                                        height: 24.dynamic,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            fit: BoxFit.contain,
                                            image:
                                                AssetImage('images/user.png'),
                                          ),
                                          border: Border.all(
                                            color: Colors.blue,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                              37.5.dynamic),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 7.dynamic,
                                      ),
                                      Text(
                                        'Luis Philippe',
                                        style: TextStyle(
                                            color: Colour.appBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.dynamic),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Warranty Status',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Row(
                                    children: [
                                      Image.asset('images/warranty.png'),
                                      SizedBox(
                                        width: 4.dynamic,
                                      ),
                                      Text(
                                        'Under Warranty',
                                        style: TextStyle(
                                            color: Colour.appBlack,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14.dynamic),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Order ID',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    'PO6589OLK68',
                                    style: TextStyle(
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15.dynamic,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Instructions from Customer',
                                    style: TextStyle(
                                        color: Colour.appDarkGrey,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.dynamic),
                                  ),
                                  SizedBox(
                                    height: 4.dynamic,
                                  ),
                                  Text(
                                    'Camera lens quality not clear, and it gets off suddenly time to time.',
                                    style: TextStyle(
                                        color: Colour.appRed,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14.dynamic),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0),
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      spreadRadius: 1,
                    )
                  ],
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 19.dynamic,
                    left: 17.dynamic,
                    right: 17.dynamic,
                    bottom: 10.dynamic,
                  ),
                  child: Column(
                    children: [
                      Obx(
                        () => Text(
                          // var time = DateFormat('hh:mm a').format(DateTime.now());
                          Jiffy(TimerController.to.currentDate.value)
                              .format('hh:mm a  |  do MMMM yyyy'),
                          // DateFormat('hh:mm a | MMst MMMM yyyy').format(DateTime.now()),
                          // '09:10 AM  |  21st September 2021',
                          style: TextStyle(
                            fontSize: 14.dynamic,
                            fontWeight: FontWeight.w600,
                            color: HexColor.fromHex("333333"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 19.dynamic,
                      ),
                      androidDropdown(),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colour.appBlue,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.dynamic),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            // Get.toNamed(NavPage.jobServiceReportScreen);
                          },
                          child: Text(
                            'Save & Continue',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.dynamic,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget androidDropdown() {
  List<DropdownMenuItem<String>> dropdownItems = [];
  var currenciesList = ['2342', 'fsdafd', 'fdsafd'];
  for (String currency in currenciesList) {
    var newItem = DropdownMenuItem(
      child: Text(currency),
      value: currency,
    );
    dropdownItems.add(newItem);
  }

  return Container(
    margin: EdgeInsets.only(bottom: 19.dynamic),
    padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colour.appLightGrey,
      borderRadius: BorderRadius.all(
        Radius.circular(5.dynamic),
      ),
    ),
    child: DropdownButton<String>(
      value: currenciesList[0],
      items: dropdownItems,
      underline: Container(),
      icon: Expanded(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.keyboard_arrow_down,
              size: 30.dynamic,
              color: Colour.appDarkGrey,
            ),
          ],
        ),
      ),
      onChanged: (value) {},
    ),
  );
}
