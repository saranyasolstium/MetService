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
import 'package:get/get_connect/http/src/utils/utils.dart';
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
  String? selectedPreparationType = 'Advion Cockroach Gel';

  void addValue() {
    setState(() {
      enteredValues.add({
        "Type": selectedPreparationType!,
        "Method": methodCtrl.text,
        "Quantity": quantityCtrl.text,
      });
    });

    selectedPreparationType = 'Advion Cockroach Gel';
    methodCtrl.clear();
    quantityCtrl.clear();
  }

  String selectedOtherValues = "";

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
      "Other"
    ];
    selectedValues = List.generate(items.length, (index) => []);
    controller.selectedCheckboxValues.clear();
  }

  Widget get serviceReportView {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Product name:', detail.aCameraName ?? 'NA'),
          ],
        ),
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
                    : 'NA'),
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
                'Customer Type:', detail.aCustomerType ?? 'NA'),
            JobDetailTitleDescriptionView('Subject:', detail.aSubject ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Warranty Status:', detail.aService ?? 'NA'),
            JobDetailTitleDescriptionView('Vendor Warranty:', 'NA'),
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
            JobDetailTitleDescriptionView(
                'Priority:', detail.aPriority ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Service Cover:', detail.aServiceCover ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Treatment Method:', detail.aTreatmentMethod ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Degree Infestation:', detail.aDegreeInfestation ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Service Frequency:', detail.aServiceFrequency ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Preparation:', detail.aPreparation ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Referral Name:', detail.aReferralName ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Billing Type:', detail.aBillingType ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Decision Maker:', detail.aDecisionMaker ?? 'NA'),
            JobDetailTitleDescriptionView('Estimation First Service:',
                detail.aEstimationFirstService ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView('Service Premise Address:',
                detail.aServicePremiseAddress ?? 'NA'),
            JobDetailTitleDescriptionView(
                'See On Site:', detail.aSeeOnSite ?? 'NA'),
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
                                          child: Text(
                                            value,
                                            style:
                                                TextStyle(fontSize: 14.dynamic),
                                          ),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.dynamic),
                          detail.aServiceName == "Pest Control Management"
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(6.dynamic),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 17.dynamic),
                                  padding: EdgeInsets.all(14.dynamic),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Column(
                                        children: List.generate(items.length,
                                            (index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 100
                                                        .dynamic, // Fixed width for the item text
                                                    child: Text(
                                                      items[index],
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 14.dynamic),
                                                    ),
                                                  ),
                                                  ...radioValues.map((value) {
                                                    return Row(
                                                      children: [
                                                        Checkbox(
                                                          value: selectedValues[
                                                                  index]
                                                              .contains(value),
                                                          onChanged:
                                                              (newValue) {
                                                            setState(() {
                                                              if (newValue!) {
                                                                selectedValues[
                                                                    index] = [
                                                                  value
                                                                ];

                                                                if (items[
                                                                        index] ==
                                                                    "Other") {
                                                                  _isOtherChecked =
                                                                      true;
                                                                  selectedOtherValues =
                                                                      selectedValues[
                                                                              index]
                                                                          .first;
                                                                  print(selectedValues[
                                                                          index]
                                                                      .first);
                                                                }
                                                              } else {
                                                                selectedValues[
                                                                        index]
                                                                    .remove(
                                                                        value);
                                                                _isOtherChecked =
                                                                    false;
                                                              }
                                                            });
                                                            handleCheckboxChange(
                                                                items[index],
                                                                value,
                                                                newValue!);
                                                          },
                                                        ),
                                                        Container(
                                                          width: Get.width > 600
                                                              ? 25.dynamic
                                                              : 5.dynamic,
                                                          child: Text(
                                                            value,
                                                            softWrap: true,
                                                            style: TextStyle(
                                                                fontSize:
                                                                    12.dynamic),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  }).toList(),
                                                ],
                                              ),
                                              Get.width > 600
                                                  ? SizedBox(height: 10.dynamic)
                                                  : SizedBox(), // Add space between rows
                                            ],
                                          );
                                        }),
                                      ),
                                      // Row(
                                      //   children: [
                                      //     Container(
                                      //       width: 100.dynamic,
                                      //       child: Text(
                                      //         "Other",
                                      //         softWrap: true,
                                      //         style: TextStyle(fontSize: 14.dynamic),
                                      //       ),
                                      //     ),
                                      //     ...radioValues.map((value) {
                                      //       return Row(
                                      //         children: [
                                      //           Checkbox(
                                      //             value: selectedOtherValues
                                      //                 .contains(value),
                                      //             onChanged: (newValue) {
                                      //               setState(() {
                                      //                 if (newValue!) {
                                      //                   selectedOtherValues
                                      //                       .add(value);
                                      //                   _isOtherChecked = true;
                                      //                 } else {
                                      //                   selectedOtherValues
                                      //                       .remove(value);
                                      //                   _isOtherChecked = false;
                                      //                 }
                                      //               });
                                      //             },
                                      //           ),
                                      //           Container(
                                      //             width: Get.width > 600
                                      //                 ? 25.dynamic
                                      //                 : 5.dynamic,
                                      //             child: Text(
                                      //               value,
                                      //               softWrap: true,
                                      //               style: TextStyle(
                                      //                   fontSize: 14.dynamic),
                                      //             ),
                                      //           ),
                                      //         ],
                                      //       );
                                      //     }).toList(),
                                      //   ],
                                      // ),

                                      // Row(children: [
                                      //   Container(
                                      //     width: 100.dynamic,
                                      //     child: Text(
                                      //       "Other",
                                      //       softWrap: true,
                                      //       style: TextStyle(fontSize: 14.dynamic),
                                      //     ),
                                      //   ),
                                      //   Checkbox(
                                      //     value: _isOtherChecked,
                                      //     onChanged: (newValue) {
                                      //       setState(() {
                                      //         _isOtherChecked = newValue!;
                                      //       });
                                      //     },
                                      //   ),
                                      // ]),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      _isOtherChecked
                                          ? Container(
                                              decoration: BoxDecoration(
                                                color: Colour.appLightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                                border: Border.all(
                                                    color: Colors.grey),
                                              ),
                                              child: TextFormField(
                                                obscureText: false,
                                                controller: otherController,
                                                keyboardType:
                                                    TextInputType.multiline,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  fontSize: 14.dynamic,
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
                                )
                              : SizedBox(),
                          SizedBox(height: 12.dynamic),
                          detail.aServiceName == "Pest Control Management"
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(6.dynamic),
                                    color: Colors.white,
                                  ),
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 17.dynamic),
                                  padding: EdgeInsets.all(14.dynamic),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: 10.dynamic),
                                      Text(
                                        'Preparation Used:',
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          color: Colour.appBlack,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      // Container(
                                      //   decoration: BoxDecoration(
                                      //     color: Colour.appLightGrey,
                                      //     borderRadius: BorderRadius.circular(5.0),
                                      //     border: Border.all(color: Colors.grey),
                                      //   ),
                                      //   child: TextFormField(
                                      //     onChanged: (txt) {
                                      //       // controller.feedback.value = txt;
                                      //     },
                                      //     obscureText: false,
                                      //     controller: typeCtrl,
                                      //     keyboardType: TextInputType.multiline,
                                      //     maxLines: 1,
                                      //     style: TextStyle(
                                      //       fontSize: 14,
                                      //       fontWeight: FontWeight.w300,
                                      //     ),
                                      //     decoration: InputDecoration(
                                      //       contentPadding: EdgeInsets.symmetric(
                                      //           vertical: 15.0, horizontal: 20.0),
                                      //       hintText: "Type",
                                      //       border: InputBorder.none,
                                      //     ),
                                      //   ),
                                      // ),
                                      DropdownButton<String>(
                                        value: selectedPreparationType,
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            selectedPreparationType = newValue!;
                                            print(selectedPreparationType);
                                          });
                                        },
                                        items: <String>[
                                          "Advion Cockroach Gel",
                                          "Insect Detector 100i",
                                          "Deltacide (Misting)",
                                          "Fogging Solution (W)",
                                          "Diesel",
                                          "Demand 2.5 CS",
                                          "NewCyper 15WP",
                                          "Newcyper 6.5 EC",
                                          "Temprid SC",
                                          "Tenopa SC",
                                          "Rodent bait box",
                                          "Rodent bait",
                                          "Newcumin Tracking Powder",
                                          "Rodent glueboard tamper proof box",
                                          "Rodent glueboard ",
                                          "Optigard ant gel",
                                          "Termikil powder",
                                          "Premise 200 SC",
                                          "Xterm AG baiting",
                                          "Xterm IG station",
                                          "Rat cage",
                                          "Anti malaria oil",
                                          "Spar 1%",
                                          "Mosquito dunk (BTI)",
                                          "Dome Trap",
                                          "Sulphur powder",
                                          "Ultrathor",
                                          "Ultriset"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(
                                              value,
                                              style: TextStyle(
                                                  fontSize: 14.dynamic),
                                            ),
                                          );
                                        }).toList(),
                                      ),

                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colour.appLightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5.dynamic),
                                          border:
                                              Border.all(color: Colors.grey),
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
                                            fontSize: 14.dynamic,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20.0),
                                            hintText: "Method",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.dynamic,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colour.appLightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5.dynamic),
                                          border:
                                              Border.all(color: Colors.grey),
                                        ),
                                        child: TextFormField(
                                          obscureText: false,
                                          controller: quantityCtrl,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontSize: 14.dynamic,
                                            fontWeight: FontWeight.w300,
                                          ),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical: 15.0,
                                                    horizontal: 20.0),
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
                                            if (methodCtrl.text.isNotEmpty &&
                                                quantityCtrl.text.isNotEmpty) {
                                              addValue();
                                            } else {
                                              Toast.show(
                                                'Please enter all value',
                                                backgroundColor: Colors.white,
                                                textStyle: TextStyle(
                                                    fontSize: 16.dynamic,
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
                                        height: 10.dynamic,
                                      ),
                                      enteredValues.isNotEmpty
                                          ? DataTable(
                                              columnSpacing: 10.dynamic,
                                              columns: [
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 80
                                                        .dynamic, // Set width for the first column
                                                    child: Text(
                                                      'Type',
                                                      style: TextStyle(
                                                        fontSize: 14.dynamic,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 80
                                                        .dynamic, // Set width for the second column
                                                    child: Text(
                                                      'Method',
                                                      style: TextStyle(
                                                        fontSize: 14.dynamic,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 60.dynamic,
                                                    child: Text(
                                                      'Quantity',
                                                      style: TextStyle(
                                                        fontSize: 14.dynamic,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 60
                                                        .dynamic, // Set width for the fourth column
                                                    child: Text(
                                                      'Actions',
                                                      style: TextStyle(
                                                        fontSize: 14.dynamic,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w600,
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
                                                      width: 80.dynamic,
                                                      child: Text(
                                                        value["Type"] ?? "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14.dynamic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    SizedBox(
                                                      width: 80.dynamic,
                                                      child: Text(
                                                        value["Method"] ?? "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14.dynamic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    SizedBox(
                                                      width: 50.dynamic,
                                                      child: Text(
                                                        value["Quantity"] ?? "",
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontSize: 14.dynamic,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  DataCell(
                                                    SizedBox(
                                                      width: 50.dynamic,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.delete,
                                                          size: 15.dynamic,
                                                        ),
                                                        onPressed: () {
                                                          setState(() {
                                                            enteredValues
                                                                .removeAt(
                                                                    index);
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
                                )
                              : SizedBox(),
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
                                        "Other",
                                        selectedOtherValues +
                                            "-" +
                                            otherController.text,
                                        true);
                                  } else {
                                    Toast.show(
                                      'Please specify other',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                    return;
                                  }
                                } else {
                                  handleCheckboxChange("Other", "", false);
                                }

                                if (detail.aServiceName ==
                                        "Pest Control Management" &&
                                    enteredValues.isEmpty) {
                                  Toast.show(
                                    'Please enter preparation used',
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.dynamic,
                                        color: Colors.black),
                                  );
                                  return;
                                }

                                print(controller.selectedCheckboxValues
                                    .toString());

                                Map<String, String> convertedMap = {};

                                controller.selectedCheckboxValues
                                    .forEach((key, value) {
                                  convertedMap['"$key"'] = '"$value"';
                                });

                                print(convertedMap.toString());

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
