import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/job_checklist_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/custom_checkbox.dart';

class ServiceReportScreen extends StatelessWidget {
  final TimerController time = Get.find();
  final JobCheckListController checkListController = Get.find();

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
          title: titleText('Service Report'),
          actions: [
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
                      color: Colour.appDarkGrey,
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
                        return ReportItem(
                          index: index,
                        );
                      },
                      itemCount: checkListController.selectedList.length,
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
                            Get.toNamed(NavPage.jobCompleted);
                          },
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.dynamic,
                                fontWeight: FontWeight.w300),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 14.dynamic,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(width: 1.5, color: Colour.appBlue),
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.dynamic),
                          ),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: Text(
                            'Re-Check',
                            style: TextStyle(
                                color: Colour.appBlue,
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

class ReportItem extends StatelessWidget {
  final JobCheckListController checkListController = Get.find();
  final int index;

  ACheckList get item {
    return checkListController.selectedList[index];
  }

  MCheckListItem? get selectedItem {
    return item.selectedItem;
  }

  ReportItem({required this.index});
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
            color: selectedItem!.color,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Text(
                    safeString(item.title),
                    style: TextStyle(
                      color: Colour.appBlack,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                // Expanded(child: Container()),
                ReportCheckbox(item: selectedItem),
              ],
            ),
            Divider(
              color: Colour.appDarkGrey,
            ),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     CheckListSelectionView(section: index, row: 0),
            //   ],
            // ),
            // Expanded(
            //   child: Container(
            //     child: StaggeredGridView.countBuilder(
            //       crossAxisCount: 2,
            //       itemCount: item.options.length,
            //       itemBuilder: (builder, row) {
            //         var selection = item.options[index];
            //         return CheckListSelectionView(section: index, row: row);
            //       },
            //       staggeredTileBuilder: (index) => StaggeredTile.fit(1),
            //     ),
            //   ),
            // ),
            Padding(
              padding: EdgeInsets.only(
                top: 10.5.dynamic,
                bottom: 5.dynamic,
              ),
              child: Text(
                'Remarks',
                style: TextStyle(
                  color: Colour.appRed,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Text(
                safeString(item.remarks),
                style: TextStyle(
                  fontSize: 14.dynamic,
                  color: Colour.appDarkGrey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ReportCheckbox extends StatelessWidget {
  final MCheckListItem? item;

  ReportCheckbox({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          8.0,
        ),
      ),
      child: Row(
        children: [
          Text(
            safeString(item!.title),
            style: TextStyle(
              color: Colour.appBlack,
              fontSize: 14.0,
              fontWeight: FontWeight.w400,
            ),
          ),
          SizedBox(
            width: 8.dynamic,
          ),
          CustomCheckbox(
            isChecked: true,
            size: 18.dynamic,
            selectedColor: item!.color,
            selectedIconColor: Colors.white,
            // didSelect: (checkbox) {
            //   if (checkbox) {
            //     checklistController.checkList[section].selectedItem = item;
            //   } else {
            //     checklistController.checkList[section].selectedItem = null;
            //   }
            //
            //   checklistController.update();
            // },
          ),
        ],
      ),
    );
  }
}
