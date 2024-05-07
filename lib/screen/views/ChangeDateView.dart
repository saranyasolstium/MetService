import 'package:eagle_pixels/colors.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/dynamic_font.dart';

class ChangeDateView extends StatelessWidget {
  String get todayOrDay {
    String selected = date.value.changeDay;
    if (DateTime.now().changeDay == selected) {
      return "Today";
    } else {
      return 'Day';
    }
  }


changeDate() {
  final currentYear = int.parse(DateFormat.y().format(DateTime.now()));
  final double fontSize = 12.dynamic; // Define your desired font size for tablets

  showDatePicker(
    context: Get.context!,
    initialDate: DateTime.now(),
    firstDate: DateTime(currentYear - 1),
    lastDate: DateTime(currentYear + 1),
    initialDatePickerMode: DatePickerMode.day,
    initialEntryMode: DatePickerEntryMode.calendar,
    builder: (BuildContext context, Widget? child) {
      return Theme(
        data: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: fontSize), 
            button: TextStyle(fontSize: 10.dynamic), 
            
          ),
        ),
        child: child!,
      );
    },
  ).then((value) {
    print(value);
    if (value != null) {
      date.value = value;
      didEnd();
    }
  });
}

bool isTablet() {
  // You can implement your own logic to determine if the device is a tablet or not
  // For example, you can use the screen size or device type
  // Here's a simple example assuming tablets have a screen width greater than 600 pixels
  return Get.width > 600;
}

  final Rx<DateTime> date;
  final Function() didEnd;
  
  const ChangeDateView({required this.date, required this.didEnd});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 14.dynamic,
        vertical: 13.dynamic,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.dynamic),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.calendar_today,
            size: 23.dynamic,
            color: Colour.appBlue,
          ),
          SizedBox(
            width: 5,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    todayOrDay,
                    style: TextStyle(
                      color: Colour.appDarkGrey,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.dynamic,
                    ),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Obx(
                  () => Text(
                    DateFormat('dd MMMM yyyy').format(date.value),
                    style: TextStyle(
                      color: Colour.appBlack,
                      fontWeight: FontWeight.w400,
                      fontSize: 14.dynamic,
                    ),
                  ),
                ),
              ],
            ),
          ),
          RawMaterialButton(
            onPressed: changeDate,
            child: Text(
              'Change',
              style: TextStyle(
                color: Colour.appBlue,
                fontWeight: FontWeight.w400,
                fontSize: 16.dynamic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


