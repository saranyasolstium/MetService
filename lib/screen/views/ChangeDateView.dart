import 'package:eagle_pixels/colors.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:jiffy/jiffy.dart';

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
    showDatePicker(
      context: Get.context!,
      initialDate: DateTime(2021, 2, 9), //temp //DateTime.now(),
      firstDate: DateTime(currentYear - 1),
      lastDate: DateTime(currentYear + 1),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((value) {
      print(value);
      // var year = DateFormat.y().format(value);
      if (value != null) {
        date.value = value;
        didEnd();
      }
      // schedule.fetchProducts();
    });
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
        borderRadius: BorderRadius.circular(8.0),
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
                        fontSize: 12.dynamic),
                  ),
                ),
                SizedBox(
                  height: 1,
                ),
                Obx(
                  () => Text(
                    // '3rd March, 2021',
                    Jiffy(date.value).format('do MMMM yyyy'),
                    style: TextStyle(
                        color: Colour.appBlack,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.dynamic),
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
                  fontSize: 16.dynamic),
            ),
          ),
        ],
      ),
    );
  }
}
