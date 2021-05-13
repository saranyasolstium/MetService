import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/job_checklist_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/custom_checkbox.dart';

class JobCheckListScreen extends StatelessWidget {
  final TimerController time = Get.find();
  final JobCheckListController checkListController =
      Get.put(JobCheckListController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colour.appLightGrey,
        appBar: AppBar(
          toolbarHeight: 66.dynamic,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: RawMaterialButton(
            onPressed: () => Get.back(),
            child: Icon(
              Icons.arrow_back,
              color: Colour.appBlue,
            ),
          ),
          title: titleText('Job Checklist'),
          actions: [
            Image.asset(
              'images/clock.png',
              width: 21.dynamic,
              height: 21.dynamic,
            ),
            SizedBox(
              width: 7.dynamic,
            ),
            Obx(
              () => (Padding(
                padding: const EdgeInsets.only(right: 16.0),
                child: Center(
                  child: Text(
                    DateFormat('hh:mm:ss a').format(time.currentDate.value),
                    style: TextStyle(
                      fontSize: 16.dynamic,
                      fontWeight: FontWeight.w700,
                      color: Colour.appBlue,
                    ),
                  ),
                ),
              )),
            )
          ],
        ),
        body: Container(
          color: Colour.appLightGrey,
          child: Column(
            children: [
              Expanded(
                child: GetBuilder<JobCheckListController>(
                  builder: (_) {
                    return ListView.builder(
                      itemBuilder: (builder, index) {
                        return CheckListItem(index: index);
                      },
                      itemCount: checkListController.checkList.length,
                    );
                  },
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
                            Get.toNamed(NavPage.jobServiceReportScreen);
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
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.dynamic),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: Colour.appRed,
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

class CheckListItem extends StatelessWidget {
  final JobCheckListController checkListController = Get.find();
  final int index;
  ACheckList get item {
    return checkListController.checkList[index];
  }

  CheckListItem({@required this.index});
  // final _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 17.dynamic,
        vertical: 18.dynamic,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 12.dynamic,
          left: 14.dynamic,
          right: 14.dynamic,
          bottom: 15.dynamic,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          border: Border.all(
            width: 1.5,
            color: item.selectedItem == null
                ? Colors.grey
                : item.selectedItem.color,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              safeString(item.title),
              style: TextStyle(
                color: Colour.appBlack,
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(
              height: 6.dynamic,
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                CheckListSelectionView(section: index, row: 0),
                SizedBox(
                  width: 20.dynamic,
                ),
                CheckListSelectionView(section: index, row: 1),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 13.dynamic,
                bottom: 9.dynamic,
              ),
              child: Text(
                'Remarks',
                style: TextStyle(
                  color: Colour.appBlack,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  8.0,
                ),
                border: Border.all(
                  color: Colour.appDarkGrey,
                ),
              ),
              child: TextFormField(
                onChanged: (txt) {
                  item.remarks = txt;
                },
                obscureText: false,
                // controller: _remarkController,
                keyboardType: TextInputType.multiline,
                maxLines: 4,
                style: TextStyle(
                    fontSize: 14.dynamic, fontWeight: FontWeight.w300),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: "elaborate about the condition here...",
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CheckListSelectionView extends StatelessWidget {
  final int section;
  final int row;
  final JobCheckListController checklistController = Get.find();

  MCheckListItem get item {
    return checklistController.checkList[section].options[row];
  }

  // String get selected {
  //   return checklistController.checkList[section].selectedItem.id;
  // }

  bool get isSelected {
    return checklistController.checkList[section].selectedItem != null &&
        checklistController.checkList[section].selectedItem.id == item.id;
  }

  CheckListSelectionView({@required this.section, @required this.row});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(
          top: 10.dynamic,
          left: 12.dynamic,
          right: 16.dynamic,
          bottom: 10.dynamic,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            8.0,
          ),
          border: Border.all(
            width: 1.5,
            color: isSelected ? item.color : Colors.grey,
          ),
        ),
        child: Row(
          children: [
            CustomCheckbox(
              isChecked: isSelected,
              size: 24.dynamic,
              selectedColor: isSelected ? item.color : Colors.grey,
              selectedIconColor: Colors.white,
              didSelect: (checkbox) {
                if (checkbox) {
                  checklistController.checkList[section].selectedItem = item;
                } else {
                  checklistController.checkList[section].selectedItem = null;
                }

                checklistController.update();
              },
            ),
            SizedBox(
              width: 8.dynamic,
            ),
            Text(
              safeString(item.title),
              style: TextStyle(
                color: Colour.appBlack,
                fontSize: 14.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
