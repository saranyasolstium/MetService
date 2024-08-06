import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/createjob_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:toast/toast.dart';

import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';

class CreateJobScreen2 extends StatelessWidget {
  final CreateJobController createJobController =
      Get.find<CreateJobController>();

  @override
  Widget build(BuildContext context) {
    String selectedTreatment = "Select Treatment method";
    String selectedFrequency = "Select Service Frequency";
    String selectedDegree = "Select";
    String selectedSource = "Select Source";
    String selectedPreparation = "Select ";
    String selectedBilling = "Select Billing Type";

    return Scaffold(
      backgroundColor: Colour.appLightGrey,
      appBar: AppBar(
        title: titleText('Create Job'),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: RawMaterialButton(
          onPressed: () => Get.back(),
          child: Icon(
            Icons.arrow_back,
            color: Colour.appBlue,
          ),
        ),
      ),
      body: GetBuilder<CreateJobController>(
        builder: (controller) => Stack(
          children: [
            Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(17.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Form(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Treatment method',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.dynamic),
                                      ),
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select Treatment method",
                                        ),
                                      ),
                                      items: [
                                        'Select Treatment method',
                                        'water base fogging',
                                        'oilbased fogging',
                                        'larviciding',
                                        'residual spraying',
                                        'gelling',
                                        'waterbased misting',
                                        'termite baiting',
                                        'dusting',
                                        'corrective treatment',
                                        'soil treatment',
                                        'bin chute (fogging)',
                                        'inspection',
                                        'monitoring',
                                        'others',
                                      ],
                                      onChanged: (val) {
                                        if (val == "Select Treatment method") {
                                          controller.selectedTreatment = "";
                                        } else {
                                          controller.selectedTreatment = val!;
                                        }
                                        print(controller.selectedTreatment);
                                        controller.update();
                                      },
                                      selectedItem: selectedTreatment,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  controller.selectedTreatment == "others"
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 19.dynamic),
                                          child: TextFormField(
                                            obscureText: false,
                                            controller:
                                                controller.treatmentOtherCtrl,
                                            onChanged: (val) {},
                                            style: TextStyle(
                                                fontSize: 14.dynamic,
                                                fontWeight: FontWeight.w300),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              hintText: "Enter Other",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Service Frequency',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.dynamic),
                                      ),
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select Service Frequency",
                                        ),
                                      ),
                                      items: [
                                        'Select Service Frequency',
                                        'Weekly (52x12)',
                                        'Monthly (12x12)',
                                        'Bi-Monthly (6x12)',
                                        'Quartely (4x12)',
                                        'Fortnightly (26x12)',
                                        'Other'
                                      ],
                                      onChanged: (val) {
                                        if (val == "Select Service Frequency") {
                                          controller.selectedfrequency = "";
                                        } else {
                                          controller.selectedfrequency = val!;
                                        }
                                        print(controller.selectedfrequency);
                                        controller.update();
                                      },
                                      selectedItem: selectedFrequency,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  controller.selectedfrequency == "Other"
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 19.dynamic),
                                          child: TextFormField(
                                            obscureText: false,
                                            controller:
                                                controller.freqOtherCtrl,
                                            onChanged: (val) {},
                                            style: TextStyle(
                                                fontSize: 14.dynamic,
                                                fontWeight: FontWeight.w300),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              hintText: "Enter Other",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: Text(
                                  //     'Service Order Id',
                                  //     style: TextStyle(
                                  //       fontSize: 14.dynamic,
                                  //       color: Colour.appBlack,
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10.dynamic,
                                  // ),
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.only(bottom: 19.dynamic),
                                  //   child: TextFormField(
                                  //     obscureText: false,
                                  //     readOnly: true,
                                  //     controller: controller.serviceOrderCtrl,
                                  //     onChanged: (val) {},
                                  //     style: TextStyle(
                                  //         fontSize: 14.dynamic,
                                  //         fontWeight: FontWeight.w300),
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: Colors.white,
                                  //       contentPadding: EdgeInsets.fromLTRB(
                                  //           20.0, 15.0, 20.0, 15.0),
                                  //       border: InputBorder.none,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10.dynamic,
                                  // ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Degree of Infestation',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.dynamic),
                                      ),
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select",
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                      ),
                                      items: [
                                        'Select',
                                        'Low',
                                        'Medium',
                                        'High',
                                        'NIL'
                                      ],
                                      onChanged: (val) {
                                        if (val == "Select") {
                                          controller.selectedInfestation = "";
                                        } else {
                                          controller.selectedInfestation = val!;
                                        }
                                        print(controller.selectedInfestation);
                                      },
                                      selectedItem: selectedDegree,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Source',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.dynamic),
                                      ),
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select Source",
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                      ),
                                      items: [
                                        'Select Source',
                                        'facebook',
                                        'website',
                                        'google',
                                        'friends',
                                        'other'
                                      ],
                                      onChanged: (val) {
                                        if (val == "Select Source") {
                                          controller.selectedSource = "";
                                        } else {
                                          controller.selectedSource = val!;
                                        }
                                        controller.update();
                                        print(controller.selectedSource);
                                      },
                                      selectedItem: selectedSource,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  controller.selectedSource == "other"
                                      ? Padding(
                                          padding: EdgeInsets.only(
                                              bottom: 19.dynamic),
                                          child: TextFormField(
                                            obscureText: false,
                                            controller:
                                                controller.sourceOtherCtrl,
                                            onChanged: (val) {},
                                            style: TextStyle(
                                                fontSize: 14.dynamic,
                                                fontWeight: FontWeight.w300),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      20.0, 15.0, 20.0, 15.0),
                                              hintText: "Enter Other",
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Preparations to be used',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  MultiSelectDialogField(
                                    items: <MultiSelectItem<String>>[
                                      for (String value in [
                                        'Advion Cockroach Gel',
                                        'Insect Detector 100i',
                                        'Deltacide (Misting)',
                                        'Fogging Solution (W)',
                                        'Diesel',
                                        'Demand 2.5 CS',
                                        'NewCyper 15WP',
                                        'Newcyper 6.5 EC',
                                        'Temprid SC',
                                        'Tenopa SC',
                                        'Rodent bait box',
                                        'Rodent bait',
                                        'Newcumin Tracking Powder',
                                        'Rodent glueboard tamper proof box',
                                        'Rodent glueboard ',
                                        'Optigard ant gel',
                                        'Termikil powder',
                                        'Premise 200 SC',
                                        'Xterm AG baiting',
                                        'Xterm IG station',
                                        'Rat cage',
                                        'Anti malaria oil',
                                        'Spar 1% ',
                                        'Mosquito dunk (BTI) ',
                                        'Dome Trap ',
                                        'Sulphur powder',
                                        'Ultrathor',
                                        'Ultriset',
                                      ])
                                        MultiSelectItem<String>(value, value),
                                    ],
                                    listType: MultiSelectListType.CHIP,
                                    onConfirm: (values) {
                                      controller.selectedPreparation =
                                          values.cast<String>().toList();

                                      print(controller.selectedPreparation);
                                    },
                                  ),
                                  SizedBox(
                                    height: 20.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Billing Type',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 19.dynamic),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 2, horizontal: 15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(5.dynamic),
                                      ),
                                    ),
                                    child: DropdownSearch<String>(
                                      dropdownDecoratorProps:
                                          DropDownDecoratorProps(
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          border: InputBorder.none,
                                          hintText: "Select Billing Type",
                                        ),
                                      ),
                                      popupProps: PopupProps.menu(
                                        showSelectedItems: true,
                                      ),
                                      items: [
                                        'Select Billing Type',
                                        'Bank Transfer',
                                        'Other',
                                      ],
                                      onChanged: (val) {
                                        if (val == "Select Billing Type") {
                                          controller.selectedBillingType = "";
                                        } else {
                                          controller.selectedBillingType = val!;
                                        }
                                        print(controller.selectedBillingType);
                                      },
                                      selectedItem: selectedBilling,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Referral name/department',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 19.dynamic),
                                    child: TextFormField(
                                      obscureText: false,
                                      controller: controller.referralNameCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText:
                                            "Enter Referral name/department ",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Billing Frequency ',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 19.dynamic),
                                    child: TextFormField(
                                      obscureText: false,
                                      controller: controller.billingFreqCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Enter Billing Frequency  ",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Estimation of duration during first service',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 19.dynamic),
                                    child: TextFormField(
                                      obscureText: false,
                                      controller:
                                          controller.estimationDurationCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText:
                                            "Enter Estimation of duration",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Decision Maker/Attention',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 19.dynamic),
                                    child: TextFormField(
                                      obscureText: false,
                                      controller: controller.decisionMakerCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Enter Decision Maker",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Whom to see on site',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.only(bottom: 19.dynamic),
                                    child: TextFormField(
                                      obscureText: false,
                                      controller: controller.whomtoSeeCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Enter Whom to see on site",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 10.dynamic,
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: Text(
                                  //     'Service Premise Address',
                                  //     style: TextStyle(
                                  //       fontSize: 14.dynamic,
                                  //       color: Colour.appBlack,
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10.dynamic,
                                  // ),
                                  // Padding(
                                  //   padding:
                                  //       EdgeInsets.only(bottom: 19.dynamic),
                                  //   child: TextFormField(
                                  //     obscureText: false,
                                  //     controller: controller.servicePremiseCtrl,
                                  //     onChanged: (val) {},
                                  //     style: TextStyle(
                                  //         fontSize: 14.dynamic,
                                  //         fontWeight: FontWeight.w300),
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: Colors.white,
                                  //       contentPadding: EdgeInsets.fromLTRB(
                                  //           20.0, 15.0, 20.0, 15.0),
                                  //       hintText:
                                  //           "Enter Service Premise Address",
                                  //       border: InputBorder.none,
                                  //     ),
                                  //   ),
                                  // ),
                                  // Align(
                                  //   alignment: Alignment.topLeft,
                                  //   child: Text(
                                  //     'Subject',
                                  //     style: TextStyle(
                                  //       fontSize: 14.dynamic,
                                  //       color: Colour.appBlack,
                                  //       fontWeight: FontWeight.w600,
                                  //     ),
                                  //   ),
                                  // ),
                                  // SizedBox(
                                  //   height: 10.dynamic,
                                  // ),
                                  // Container(
                                  //   child: TextFormField(
                                  //     obscureText: false,
                                  //     maxLines: 4,
                                  //     controller: controller.subjectCtrl,
                                  //     onChanged: (val) {},
                                  //     style: TextStyle(
                                  //         fontSize: 14.dynamic,
                                  //         fontWeight: FontWeight.w300),
                                  //     decoration: InputDecoration(
                                  //       filled: true,
                                  //       fillColor: Colors.white,
                                  //       contentPadding: EdgeInsets.fromLTRB(
                                  //           20.0, 15.0, 20.0, 15.0),
                                  //       hintText: "Subject",
                                  //       border: InputBorder.none,
                                  //     ),
                                  //   ),
                                  // ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Description',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.dynamic,
                                  ),
                                  Container(
                                    child: TextFormField(
                                      obscureText: false,
                                      maxLines: 4,
                                      controller: controller.descriptionCtrl,
                                      onChanged: (val) {},
                                      style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.fromLTRB(
                                            20.0, 15.0, 20.0, 15.0),
                                        hintText: "Description",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20.dynamic,
                                  ),
                                  Divider(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 20.dynamic,
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Technician',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () => controller.selectDate(context),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.date!.isEmpty
                                                ? "Select Date"
                                                : controller.date!,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Icon(Icons.calendar_today),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.selectTime(context, true),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.startTime!.isEmpty
                                                ? "Select Start Time"
                                                : controller.startTime!,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Icon(Icons.access_time),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  GestureDetector(
                                    onTap: () =>
                                        controller.selectTime(context, false),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20.0, vertical: 15.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            controller.endTime!.isEmpty
                                                ? "Select End Time"
                                                : controller.endTime!,
                                            style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w300,
                                            ),
                                          ),
                                          Icon(Icons.access_time),
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for (var engineer
                                      in controller.avaiableEngList)
                                    CheckboxListTile(
                                      title: Text(engineer.email ?? ''),
                                      value: engineer.isChecked,
                                      onChanged: (value) {
                                        controller.selectedEngId = controller
                                            .updateCheckboxState(
                                                engineer, value!)
                                            .toString();
                                        print(
                                            'Selected ID1: ${controller.selectedEngId}');
                                      },
                                    ),
                                ],
                              ),
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
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: 19.dynamic,
                        left: 17.dynamic,
                        right: 17.dynamic,
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

                                if (controller.selectedTreatment == "Other" &&
                                    controller.treatmentOtherCtrl.text
                                        .toString()
                                        .isEmpty) {
                                  Toast.show(
                                    "please enter treatment other filed",
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  );
                                } else if (controller.selectedfrequency ==
                                        "Other" &&
                                    controller.freqOtherCtrl.text
                                        .toString()
                                        .isEmpty) {
                                  Toast.show(
                                    "please enter frequency other filed",
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  );
                                } else if (controller.selectedSource ==
                                        "other" &&
                                    controller.sourceOtherCtrl.text
                                        .toString()
                                        .isEmpty) {
                                  Toast.show(
                                    "please enter source other filed",
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  );
                                } else if (controller.selectedEngId.isEmpty) {
                                  Toast.show(
                                    "please assign enginner",
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.0, color: Colors.black),
                                  );
                                } else {
                                  controller.createJob();
                                }
                              },
                              child: controller.isLoading
                                  ? Center(child: CircularProgressIndicator())
                                  : Text(
                                      'Create Job',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.dynamic,
                                        fontWeight: FontWeight.w300,
                                      ),
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
                              onPressed: () {
                                Get.back();
                              },
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colour.appRed,
                                  fontSize: 16.dynamic,
                                  fontWeight: FontWeight.w300,
                                ),
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
          ],
        ),
      ),
    );
  }
}
