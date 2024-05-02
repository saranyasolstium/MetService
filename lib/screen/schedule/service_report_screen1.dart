import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_checklist_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/main.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/schedule/service_report_screen.dart';
import 'package:flutter/material.dart';

import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/reuse/custom_checkbox.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:eagle_pixels/model/check_list_model.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import 'package:signature/signature.dart';
import 'package:toast/toast.dart';

class ServiceReportScreen1 extends StatefulWidget {
  //final String imagePath;

  const ServiceReportScreen1({Key? key}) : super(key: key);
  @override
  _ServiceReportScreen1State createState() => _ServiceReportScreen1State();
}

class _ServiceReportScreen1State extends State<ServiceReportScreen1> {
  String? selectedVisitType = 'Routine';
  String? selectedInspect = '';

  final TimerController time = Get.find();
  final JobCheckListController checkListController = Get.find();
  final ScheduleListController schedule = Get.find();
  TextEditingController otherController = TextEditingController();

  // final controller = Get.put(JobDetailController());
  final controller = Get.find<JobDetailController>();
  AJobDetail get detail {
    return controller.detail.value;
  }

  List<Map<String, String>> enteredValues = [];

  TextEditingController typeCtrl = TextEditingController();
  TextEditingController methodCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  TextEditingController otherCtrl = TextEditingController();

  late List<String> items;
  late List<List<String>> selectedValues;
  final List<String> radioValues = ['N', 'L', 'M', 'H'];
  bool _isOtherChecked = false;

  void addValue() {
    setState(() {
      enteredValues.add({
        "Type": typeCtrl.text,
        "Method": methodCtrl.text,
        "Quantity": quantityCtrl.text,
      });
    });

    typeCtrl.clear();
    methodCtrl.clear();
    quantityCtrl.clear();
  }

  void handleCheckboxChange(String item, String value, bool isChecked) {
    setState(() {
      if (isChecked) {
        controller.selectedCheckboxValues[item] = value;
      } else {
        controller.selectedCheckboxValues.remove(item);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    items = [
      "Cockroach",
      "Common Ant",
      "Rodent",
      "Subterranean Termite",
      "Mosquito",
      "Housefly",
      "Bedbug",
      "Fleas",
    ];
    selectedValues = List.generate(items.length, (index) => []);
    controller.selectedCheckboxValues.clear();
  }

  Widget get serviceReportView {
    return Column(
      children: [
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service Name:', detail.aServiceName ?? 'NA'),
            JobDetailTitleDescriptionView(
                'SubService Name:', detail.aSubServiceName ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service Type:',
                detail.aTeamName != null && detail.aTeamName!.isNotEmpty
                    ? detail.aTeamName
                    : 'NA')
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Customer Type:', detail.aCustomerType ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Service Order No:', detail.aServiceOrderNo ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Attention:', detail.aAttention ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service date:', detail.aBookingDate ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Schedule Time:', detail.aBookingTime ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
      ],
    );
  }

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
        resizeToAvoidBottomInset: true,
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
        body: Stack(
          children: [
            Container(
              color: Colour.appLightGrey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GetBuilder<JobCheckListController>(
                            builder: (_) {
                              return ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (builder, index) {
                                  var item =
                                      checkListController.selectedlist[index];
                                  return ReportItem(
                                    item: item,
                                  );
                                },
                                itemCount:
                                    checkListController.selectedlist.length,
                              );
                            },
                          ),
                          SizedBox(height: 12.dynamic),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.dynamic),
                              color: Colors.white,
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: 17.dynamic),
                            padding: EdgeInsets.all(14.dynamic),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Service information:',
                                  style: TextStyle(
                                      color: Colour.appBlue,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 16.dynamic),
                                ),
                                serviceReportView
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 12.dynamic,
                          ),
                          SizedBox(height: 12.dynamic),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.dynamic),
                              color: Colors.white,
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: 20.dynamic),
                            padding: EdgeInsets.all(14.dynamic),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Visit Type :',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: selectedVisitType,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          selectedVisitType = newValue!;

                                          print(selectedVisitType);
                                        });
                                      },
                                      items: <String>[
                                        'Routine',
                                        'Call Out',
                                        'Follow Up',
                                        'KIV'
                                      ].map<DropdownMenuItem<String>>(
                                          (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.dynamic),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.dynamic),
                              color: Colors.white,
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: 17.dynamic),
                            padding: EdgeInsets.all(14.dynamic),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Inspected for:',
                                  style: TextStyle(
                                    fontSize: 14.dynamic,
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10),
                                // MultiSelectDialogField(
                                //   items: <MultiSelectItem<String>>[
                                //     for (String value in [
                                //       "Cockroach",
                                //       "Common Ant",
                                //       "Rodent",
                                //       "Subterranean Termite",
                                //       "Others,Please specify",
                                //       "Mosquito",
                                //       "Housefly",
                                //       "Bedbug",
                                //       "Fleas",
                                //       "Other",
                                //     ])
                                //       MultiSelectItem<String>(value, value),
                                //   ],
                                //   listType: MultiSelectListType.CHIP,
                                //   onConfirm: (values) {
                                //     setState(() {
                                //       selectedInspect = values.join(", ");
                                //       print(selectedInspect);
                                //     });
                                //   },
                                // ),

                                Column(
                                  children:
                                      List.generate(items.length, (index) {
                                    return Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Text(
                                            items[index],
                                            softWrap: true,
                                          ),
                                        ),
                                        ...radioValues.map((value) {
                                          return Row(
                                            children: [
                                              Checkbox(
                                                value: selectedValues[index]
                                                    .contains(value),
                                                onChanged: (newValue) {
                                                  setState(() {
                                                    if (newValue!) {
                                                      selectedValues[index] = [
                                                        value
                                                      ];
                                                    } else {
                                                      selectedValues[index]
                                                          .remove(value);
                                                    }
                                                  });
                                                  handleCheckboxChange(
                                                      items[index],
                                                      value,
                                                      newValue!);
                                                },
                                              ),
                                              Container(
                                                width: 10,
                                                child: Text(
                                                  value,
                                                  softWrap: true,
                                                ),
                                              ),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    );
                                  }),
                                ),
                                Row(children: [
                                  Container(
                                    width: 100,
                                    child: Text(
                                      "Other",
                                      softWrap: true,
                                    ),
                                  ),
                                  Checkbox(
                                    value: _isOtherChecked,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _isOtherChecked = newValue!;
                                      });
                                    },
                                  ),
                                ]),
                                _isOtherChecked
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colour.appLightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: TextFormField(
                                          obscureText: false,
                                          controller: otherController,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20.0),
                                            hintText: "Specify other",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),

                                SizedBox(
                                  height: 10.dynamic,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.dynamic),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.dynamic),
                              color: Colors.white,
                            ),
                            margin:
                                EdgeInsets.symmetric(horizontal: 17.dynamic),
                            padding: EdgeInsets.all(14.dynamic),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Text(
                                  'Preparation Used:',
                                  style: TextStyle(
                                    fontSize: 14.dynamic,
                                    color: Colour.appBlack,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      // controller.feedback.value = txt;
                                    },
                                    obscureText: false,
                                    controller: typeCtrl,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      hintText: "Type",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      // controller.feedback.value = txt;
                                    },
                                    obscureText: false,
                                    controller: methodCtrl,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      hintText: "Method",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(5.0),
                                    border: Border.all(color: Colors.grey),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      // controller.feedback.value = txt;
                                    },
                                    obscureText: false,
                                    controller: quantityCtrl,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(
                                          3), // Limit to 3 digits
                                    ],
                                    maxLines: 1,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    ),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 15.0, horizontal: 20.0),
                                      hintText: "Quantity",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10.dynamic,
                                ),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colour.appBlue,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(5.dynamic),
                                    ),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      if (typeCtrl.text.isNotEmpty &&
                                          methodCtrl.text.isNotEmpty &&
                                          quantityCtrl.text.isNotEmpty) {
                                        addValue();
                                      } else {
                                        Toast.show(
                                          'Please enter all value',
                                          backgroundColor: Colors.white,
                                          textStyle: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black),
                                        );
                                      }
                                    },
                                    child: Text(
                                      'Add',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16.dynamic,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                enteredValues.isNotEmpty
                                    ? DataTable(
                                        columnSpacing: 10,
                                        columns: [
                                          DataColumn(
                                            label: SizedBox(
                                              width:
                                                  80, // Set width for the first column
                                              child: Text(
                                                'Type',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width:
                                                  80, // Set width for the second column
                                              child: Text(
                                                'Method',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width: 60,
                                              child: Text(
                                                'Quantity',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                          DataColumn(
                                            label: SizedBox(
                                              width:
                                                  60, // Set width for the fourth column
                                              child: Text(
                                                'Actions',
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                        rows: enteredValues
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          final index = entry.key;
                                          final value = entry.value;

                                          return DataRow(cells: [
                                            DataCell(
                                              SizedBox(
                                                width: 80,
                                                child: Text(
                                                  value["Type"] ?? "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: 80,
                                                child: Text(
                                                  value["Method"] ?? "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: 50,
                                                child: Text(
                                                  value["Quantity"] ?? "",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            ),
                                            DataCell(
                                              SizedBox(
                                                width: 50,
                                                child: IconButton(
                                                  icon: Icon(Icons.delete),
                                                  onPressed: () {
                                                    setState(() {
                                                      enteredValues
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ),
                                            ),
                                          ]);
                                        }).toList(),
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          ),
                          SizedBox(height: 42.dynamic),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.dynamic,
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
                              onPressed: () async {
                                controller.visitType.value = selectedVisitType!;
                                if (_isOtherChecked) {
                                  if (otherController.text.isNotEmpty) {
                                    handleCheckboxChange(
                                        "Other", otherController.text, true);
                                  } else {
                                    Toast.show(
                                      'Please specify other"',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.0, color: Colors.black),
                                    );
                                  }
                                } else {
                                  handleCheckboxChange("Other", "", false);
                                }

                                print(controller.selectedCheckboxValues
                                    .toString());

                                controller.preparation.value =
                                    jsonEncode(enteredValues);
                                print(controller.preparation.value);

                                Get.put(JobCheckListController());

                                Get.to(() => ServiceReportScreen());
                              },
                              child: Text(
                                'Next',
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
            AppController.to.defaultLoaderView(),
          ],
        ),
      ),
    );
  }
}

class ReportItem extends StatelessWidget {
  // final JobCheckListController checkListController = Get.find();
  // final int index;
  //
  // ACheckListItem get item {
  //   return checkListController.selectedlist[index];
  // }
  //
  // MCheckListOption get selectedItem {
  //   return item.selectedItem!;
  // }

  final ACheckListItem item;
  ReportItem({required this.item});
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
            color: item.lastItem?.color ?? Colors.grey,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.spaceAround,
              // mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    item.title,
                    style: TextStyle(
                      color: Colour.appBlack,
                      fontSize: 16.0.dynamic,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                // Expanded(child: Container()),
                SizedBox(width: 5.dynamic),
                ReportCheckbox(
                    item: item.lastItem ?? MCheckListOption('', Colors.grey)),
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
                item.remarks,
                style: TextStyle(
                  fontSize: 14.dynamic,
                  color: Colour.appDarkGrey,
                ),
              ),
            ),
            SizedBox(
              height: 10.dynamic,
            ),
            Row(
              children: [
                // Image.asset(
                //   'images/add.png',
                //   width: 19.dynamic,
                //   height: 19.dynamic,
                // ),
                Text(
                  'Photo Added',
                  style: TextStyle(
                    fontSize: 14.dynamic,
                    fontWeight: FontWeight.w400,
                    color: Colour.appText,
                  ),
                ),
              ],
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
                          child: (item.selectedImages[row] is Uint8List)
                              ? Image.memory(
                                  item.selectedImages[row],
                                  height: 43.dynamic,
                                  width: 43.dynamic,
                                  fit: BoxFit.fill,
                                  isAntiAlias: false,
                                )
                              : Image.network(
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
          ],
        ),
      ),
    );
  }
}

class ReportCheckbox extends StatelessWidget {
  final MCheckListOption item;

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
            item.name,
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
            selectedColor: item.color,
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
