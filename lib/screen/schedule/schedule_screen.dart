import 'package:cached_network_image/cached_network_image.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/screen/home/mypurchase_detail_screen.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

extension ScheduleAction on ScheduleScreen {
  String get todayOrDay {
    String selected = schedule.serviceDate(schedule.selectedDate.value);
    if (schedule.serviceDate(DateTime.now()) == selected) {
      return "Today";
    } else {
      return 'Day';
    }
  }

  changeDate() {
    final currentYear = int.parse(DateFormat.y().format(DateTime.now()));
    showDatePicker(
      context: Get.context,
      initialDate: DateTime.now(),
      firstDate: DateTime(currentYear - 1),
      lastDate: DateTime(currentYear + 1),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.calendar,
    ).then((value) {
      print(value);
      // var year = DateFormat.y().format(value);
      schedule.selectedDate.value = value;
      schedule.fetchProducts();
    });
  }
}

class ScheduleScreen extends StatelessWidget {
  final TextStyle style =
      TextStyle(fontSize: 14.dynamic, fontWeight: FontWeight.w300);
  final ScheduleListController schedule = Get.find();
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
              color: Colour.appBlue,
            ),
          ),
          title: Text(
            'Scheduled Job',
            style: TextStyle(
                color: Colour.appBlack,
                fontWeight: FontWeight.w400,
                fontSize: 16.dynamic),
          ),
        ),
        body: Stack(
          children: [
            Padding(
              padding: EdgeInsets.all(17.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
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
                                  Jiffy(schedule.selectedDate.value)
                                      .format('do MMMM yyyy'),
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
                  ),
                  SizedBox(
                    height: 17.dynamic,
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        var item = schedule.scheduleList[index];
                        return Container(
                          padding: EdgeInsets.only(
                            top: 16.dynamic,
                            left: 16.dynamic,
                            bottom: 13.dynamic,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CachedNetworkImage(
                                    imageUrl: item.customerImage,
                                    placeholder: (_, url) => Image.asset(
                                      'images/camera.png',
                                    ),
                                  ),
                                  SizedBox(
                                    width: 13.dynamic,
                                  ),
                                  Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          safeString(item.productName),
                                          style: TextStyle(
                                              color: Colour.appBlack,
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16.dynamic),
                                        ),
                                        SizedBox(
                                          height: 4.dynamic,
                                        ),
                                        Text(
                                          'ID - ${safeString(item.ticketId)}',
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                                  image: AssetImage(
                                                      'images/user.png'),
                                                ),
                                                border: Border.all(
                                                  color: Colors.blue,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(
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
                                children: [
                                  Expanded(
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: 18.dynamic),
                                      child: Material(
                                        // elevation: 5.0,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        color: Colour.appBlue,
                                        child: MaterialButton(
                                          minWidth: 121.dynamic,
                                          height: 44.dynamic,
                                          padding: EdgeInsets.fromLTRB(
                                              25.0, 11.0, 14.0, 10.0),
                                          onPressed: () {},
                                          child: Text(
                                            'Start Job',
                                            textAlign: TextAlign.center,
                                            style: style.copyWith(
                                              color: Colors.white,
                                              fontSize: 16.dynamic,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: GestureDetector(
                                      onTap: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (context) =>
                                              SingleChildScrollView(
                                            child: Container(
                                              padding: EdgeInsets.only(
                                                  bottom: MediaQuery.of(context)
                                                      .viewInsets
                                                      .bottom),
                                              child: MyPurchaseDetailsScreen(),
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                            color: Colour.appBlue,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 16.dynamic),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: schedule.scheduleList.length,
                    ),
                  )
                ],
              ),
            ),
            AppController.to.defaultLoaderView(),
          ],
        ),
      ),
    );
  }
}
