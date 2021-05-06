import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/Attendance/time_in_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../colors.dart';

class CalendarScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      backgroundColor: HexColor.fromHex("F7F7F7"),
      body: Padding(
        padding: const EdgeInsets.only(top: 27.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              this.yearMonth,
              SizedBox(
                height: 35.dynamic,
              ),
              Container(
                child: this.calendarSurround,
              ),
              SizedBox(
                height: 86.dynamic,
              ),
              Text(
                '09:10 AM  |  21st September 2021',
                style: TextStyle(
                  fontSize: 14.dynamic,
                  fontWeight: FontWeight.w600,
                  color: HexColor.fromHex("333333"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colour.appBlue,
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.dynamic),
                    ),
                  ),
// margin: EdgeInsets.symmetric(vertical: 32.dynamic),
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TimeInScreen()),
                      );
                    },
                    child: Text(
                      'Start the day',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.dynamic,
                          fontWeight: FontWeight.w300),
                    ),
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

extension CalendarWidgets on CalendarScreen {
  AppBar get appBar {
    AppBar(
      title: Text(
        'Attendance',
      ),
      backgroundColor: CupertinoColors.white,
      elevation: 0,
      leading: RawMaterialButton(
        onPressed: () => Get.back(),
        child: Icon(
          Icons.arrow_back,
          color: Colour.appBlue,
        ),
      ),
    );
  }

  Widget get yearMonth {
    return Container(
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 17, right: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Year',
                    style: TextStyle(
                        color: Colour.appDarkGrey,
                        fontSize: 14.dynamic,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 11.dynamic,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Color(0xFFFFFFFF),
                    ),
                    padding:
                        EdgeInsets.only(top: 12.0, left: 13.0, bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  '   2020',
                                  style: TextStyle(
                                      color: Colour.appText,
                                      fontSize: 14.dynamic,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  DateTime newDateTime =
                                      await showRoundedDatePicker(
                                    context: Get.context,
                                    initialDatePickerMode: DatePickerMode.year,
                                    theme:
                                        ThemeData(primarySwatch: Colors.green),
                                  );
                                  print(newDateTime);
                                },
                                child: Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colour.appBlack,
                                  size: 30.dynamic,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 14, right: 17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Month',
                    style: TextStyle(
                        color: Colour.appDarkGrey,
                        fontSize: 14.dynamic,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 11.dynamic,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.0),
                      color: Color(0xFFFFFFFF),
                    ),
                    padding:
                        EdgeInsets.only(top: 12.0, left: 13.0, bottom: 12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showMonthPicker(
                              context: Get.context,
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2030),
                              initialDate: DateTime.now(),
                            );
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '   Sep',
                                    style: TextStyle(
                                        color: Colour.appText,
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colour.appBlack,
                                  size: 30.dynamic,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget get calendarSurround {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colour.appBlue,
            ),
          ),
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                    top: 12.dynamic, left: 16, bottom: 12.dynamic),
                child: Container(
                  child: Text(
                    DateFormat('MMMM, y').format(DateTime.now()).toString(),
                    style: TextStyle(
                      fontSize: 14.dynamic,
                      fontWeight: FontWeight.w600,
                      color: HexColor.fromHex('#0494FC'),
                    ),
                  ),
                ),
              ),
              Divider(
                color: Colour.appBlue,
                thickness: 1.0,
              ),
              this.calendar,
            ],
          ),
        ), //
      ],
    );
  }

  Widget get calendar {
    return CalendarCarousel<Event>(
      todayBorderColor: Colors.transparent,
      customDayBuilder: (isSelectable,
          index,
          isSelectedDay,
          isToday,
          isPrevMonthDay,
          styleForBuilder,
          isNextMonthDay,
          isThisMonthDay,
          now) {
        return CalendarItem(
            isSelectable,
            index,
            isSelectedDay,
            isToday,
            isPrevMonthDay,
            styleForBuilder,
            isNextMonthDay,
            isThisMonthDay,
            now,
            [1, 2, 3],
            [4, 5, 6],
            [7, 8, 9]);
      },
      // onDayPressed: (date, events) {
      //   this.setState(() => _currentDate2 = date);
      //   events.forEach((event) => print(event.title));
      // },
      // weekdayTextStyle: TextStyle(
      //   color: Colors.green,
      // ),
      daysHaveCircularBorder: false,
      showOnlyCurrentMonthDate: false,
      // w      thisMonthDayBorderColor: Colors.transparent,
      height: 287.dynamic,
      // selectedDateTime: _currentDate2,
      // targetDateTime: _targetDateTime,
      // customGridViewPhysics: NeverScrollableScrollPhysics(),
      showHeader: false,
      todayTextStyle: TextStyle(
        color: Colors.blue,
      ),
      todayButtonColor: Colors.white,
      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      selectedDayBorderColor: Colors.white,
      customWeekDayBuilder: (index, day) {
        return Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            day,
            style: TextStyle(
              fontSize: 14.dynamic,
              fontWeight: FontWeight.w500,
              color: index == 0 ? Colors.red : Colors.grey,
            ),
          ),
        );
      },
      // minSelectedDate: _currentDate.subtract(Duration(days: 360)),
      // maxSelectedDate: _currentDate.add(Duration(days: 360)),
      scrollDirection: Axis.horizontal,
      isScrollable: false,
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.pinkAccent,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.grey,
        fontSize: 16,
      ),
      // onCalendarChanged: (DateTime date) {
      //   this.setState(() {
      //     _targetDateTime = date;
      //     _currentMonth = DateFormat.yMMM().format(_targetDateTime);
      //   });
      // },
      onDayLongPressed: (DateTime date) {
        int day = int.parse(DateFormat.d().format(date));
        if ([4, 5, 6].contains(day)) {
          print('contain');
        } else {
          print('not contain');
        }
        print('long pressed date $date');
      },
    );
  }
}

class CalendarItem extends StatelessWidget {
  final bool isSelectable;
  final int index;
  final bool isSelectedDay;
  final bool isToday;
  final bool isPrevMonthDay;
  final TextStyle styleForBuilder;
  final bool isNextMonthDay;
  final bool isThisMonthDay;
  final DateTime now;

  final List<int> presentedDays;
  final List<int> absentsDays;
  final List<int> halfDayPresents;

  CalendarItem(
    this.isSelectable,
    this.index,
    this.isSelectedDay,
    this.isToday,
    this.isPrevMonthDay,
    this.styleForBuilder,
    this.isNextMonthDay,
    this.isThisMonthDay,
    this.now,
    this.presentedDays,
    this.absentsDays,
    this.halfDayPresents,
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Builder(
          builder: (context) {
            if (isPrevMonthDay || isNextMonthDay)
              return DateItemText(now: now, color: Colors.grey);
            else if (presentedDays
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.PRESENT);
            } else if (absentsDays
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.ABSENT);
            } else if (halfDayPresents
                .contains(int.parse(DateFormat.d().format(now)))) {
              return WorkingDates(now: now, status: DayStatus.HALFDAY);
            } else
              return DateItemText(now: now, color: Colors.black);
          },
        ),
      ),
    );
  }
}

enum DayStatus {
  PRESENT,
  ABSENT,
  HALFDAY,
}

extension StatusExtension on DayStatus {
  Color get color {
    switch (this) {
      case DayStatus.ABSENT:
        return HexColor.fromHex('#D85151');
      case DayStatus.PRESENT:
        return HexColor.fromHex('#14E19C');
      case DayStatus.HALFDAY:
        return HexColor.fromHex('#EFD100');
    }
    return Colors.black;
  }

  String get text {
    switch (this) {
      case DayStatus.ABSENT:
        return 'ABSENT';
      case DayStatus.PRESENT:
        return 'PRESENT';
      case DayStatus.HALFDAY:
        return 'HALF DAY';
    }
    return '';
  }
}

class WorkingDates extends StatelessWidget {
  const WorkingDates({@required this.now, @required this.status});
  final DateTime now;
  final DayStatus status;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          DateFormat.d().format(now),
          style: TextStyle(
              fontSize: 14.dynamic,
              color: status.color,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
              decorationThickness: 2.0),
        ),
        DatePresentText(status: status),
      ],
    );
  }
}

class DatePresentText extends StatelessWidget {
  final DayStatus status;
  const DatePresentText({this.status});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(
          fit: BoxFit.contain,
          child: Text(
            status.text,
            style: TextStyle(
              fontSize: 8.dynamic,
              color: status.color,
            ),
          ),
        ),
      ],
    );
  }
}

class DateItemText extends StatelessWidget {
  DateItemText({this.now, this.color});

  final DateTime now;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      fit: BoxFit.fitHeight,
      child: Text(
        DateFormat.d().format(now),
        style: TextStyle(
          fontSize: 14.dynamic,
          color: color,
          fontWeight: FontWeight.normal,
        ),
      ),
    );
  }
}
