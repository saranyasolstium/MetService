import 'dart:io';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/controller/job_checklist_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/active_service_model.dart';
import 'package:eagle_pixels/model/check_list_model.dart';
import 'package:eagle_pixels/reuse/Keys.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/toast/photo_choose_screen.dart';
import 'package:eagle_pixels/screen/views/service_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/custom_checkbox.dart';
import 'package:toast/toast.dart';
import 'package:eagle_pixels/screen/attendance/attendance_service_list_screen.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

extension CheckListItemAction on CheckListItem {
  onPickImage() async {
    // Get.dialog(PhotoChooseScreen(), barrierDismissible: false);
    File? selectedImage =
        await Get.dialog(PhotoChooseScreen(), barrierDismissible: false);
    print('picked image path - ${selectedImage?.path ?? 'null'}');
    if (selectedImage != null) {
      checkListController.checkList[index].selectedImages.add(selectedImage);
      checkListController.update();
    }
  }
}

extension StopJobAction on JobCheckListScreen {
  Future<bool> _onSubmitWork() async {
    // if (checkListController.selectedlist.length == 0) {
    //   print(checkListController.checkList.length);
    //   return false;
    // }

    showLoading();
    final String? errorWhenSubmit = await checkListController.onSubmitJob(
      service_id: detail.aServiceId ?? '',
    );
    hideLoading();
    if (errorWhenSubmit != null) {
      Toast.show(errorWhenSubmit, Get.context);
      return false;
    } else {
      return true;
    }
  }

  onStopJob() async {
    bool isCompleted = true;
    if (checkListController.selectedlist.length > 0) {
      isCompleted = await _onSubmitWork();
    }
    if (!isCompleted) {
      return;
    }
    showLoading();
    await schedule.onStopJob(service_id: detail.aServiceId ?? '0');
    hideLoading();
    await AttendanceController.to.fetchAttendanceStatus();

    schedule.reloadList();
    navigator!
        .popUntil((route) => route.settings.name == NavPage.scheduleScreen);
  }

  onCompleteJob() async {
    // if (checkListController.selectedlist.length ==
    //     checkListController.checkList.length)
    if (true) {
      final isCompleted = await _onSubmitWork();
      if (isCompleted) {
        Get.toNamed(NavPage.jobServiceReportScreen);
      } else {
        Toast.show('Must Choose Option', Get.context);
      }
    } else {
      Toast.show('Must Choose Option', Get.context);
      return;
    }
  }
}

class JobCheckListScreen extends StatelessWidget {
  AJobDetail get detail {
    return controller.detail.value;
  }

  final String serviceID;
  JobCheckListScreen(this.serviceID);
  // final controller = Get.put(JobDetailController());
  final controller = Get.find<JobDetailController>();
  final ScheduleListController schedule = Get.find();

  final TimerController time = Get.find();
  final JobCheckListController checkListController =
      Get.put(JobCheckListController());
  @override
  Widget build(BuildContext context) {
    // if (!checkListController.isOneTimeListRequested) {
    //   checkListController.isOneTimeListRequested = true;
    //   checkListController
    //       .fetchCheckList(controller.detail.value.aServiceId.toString());
    //   // Future.delayed(Duration(milliseconds: 100), () {
    //   //   checkListController.isOneTimeListRequested = true;
    //   //   checkListController.fetchCheckList(serviceID);
    //   // });
    // }
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
        body: Stack(
          children: [
            Container(
              color: Colour.appLightGrey,
              child: Column(
                children: [
                  Expanded(
                    child: GetBuilder<JobCheckListController>(
                      builder: (_) {
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(
                                    17.dynamic, 17.dynamic, 17.dynamic, 0),
                                child: AttendenceDetail(
                                    item: controller.detail.value
                                        as AActiveService),
                              ),
                              ListView.builder(
                                itemBuilder: (builder, index) {
                                  return CheckListItem(index: index);
                                },
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                // itemCount:
                                //     checkListController.checkList.length > 0
                                //         ? 1
                                //         : 0,
                                itemCount: checkListController.checkList.length,
                              ),
                            ],
                          ),
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
                        // bottom: 10.dynamic,
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
                                this.onCompleteJob();
                              },
                              child: Text(
                                'Complete Job',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.dynamic,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colour.appRed,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.dynamic),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                onStopJob();
                              },
                              child: Text(
                                'Pause Job',
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
            // AppController.to.defaultLoaderView(),
          ],
        ),
      ),
    );
  }
}

class CheckListItem extends StatelessWidget {
  final JobCheckListController checkListController = Get.find();
  final int index;
  ACheckListItem get item {
    return checkListController.checkList[index];
  }

  CheckListItem({required this.index});
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
              width: 1.5, color: item.selectedItem?.color ?? Colors.grey),
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
            // Obx(() {
            Wrap(
              spacing: 10,
              alignment: WrapAlignment.spaceBetween,
              // runAlignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.center,
              direction: Axis.horizontal,
              runSpacing: 10,
              children: List.generate(
                item.options?.length ?? 0,
                (row) => CheckListSelectionView(section: index, row: row),
              ),
            ),
            // checkListController.checkList
            //     .map((e) =>
            //CheckListSelectionView(section: index, row: e))
            //.toList(),
            // ),
            // return GridView.builder(
            //     itemCount: item.options?.length ?? 0,
            //     physics: NeverScrollableScrollPhysics(),
            //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //         crossAxisCount: 2, childAspectRatio: 3),
            //     shrinkWrap: true,
            //     itemBuilder: (con, ind) {
            //       return Padding(
            //         padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
            //         child: Expanded(
            //             child:
            //                 CheckListSelectionView(section: index, row: ind)),
            //       );
            //     });
            // }),
            // Row(
            //   mainAxisSize: MainAxisSize.max,
            //   children: [
            //     CheckListSelectionView(section: index, row: 0),
            //     SizedBox(
            //       width: 20.dynamic,
            //     ),
            //     CheckListSelectionView(section: index, row: 1),
            //   ],
            // ),
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
            ),
            SizedBox(
              height: 16.dynamic,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  item.selectedImages.length,
                  (row) => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colour.appBlue),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          clipBehavior: Clip.hardEdge,
                          child: Image.file(
                            item.selectedImages[row],
                            height: 43.dynamic,
                            width: 43.dynamic,
                            fit: BoxFit.fill,
                            isAntiAlias: false,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20.dynamic,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10.dynamic,
            ),
            GestureDetector(
              onTap: () async {
                this.onPickImage();
              },
              child: Row(
                children: [
                  Image.asset(
                    'images/add.png',
                    width: 19.dynamic,
                    height: 19.dynamic,
                  ),
                  Text(
                    '  Add Photo',
                    style: TextStyle(
                      fontSize: 14.dynamic,
                      fontWeight: FontWeight.w400,
                      color: Colour.appBlue,
                    ),
                  ),
                ],
              ),
            ),
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

  MCheckListOption get item {
    return checklistController.checkList[section].options![row];
  }

  // String get selected {
  //   return checklistController.checkList[section].selectedItem.id;
  // }

  bool get isSelected {
    return checklistController.checkList[section].selectedItem != null &&
        checklistController.checkList[section].selectedItem!.id == item.id;
  }

  CheckListSelectionView({required this.section, required this.row});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minWidth: (Get.width - (34.dynamic + 28.dynamic + 15)) / 2),
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
          mainAxisSize: MainAxisSize.min,
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
              safeString(item.name),
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
