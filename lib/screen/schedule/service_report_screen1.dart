import 'dart:convert';

import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/common/currency_convertor.dart';
import 'package:eagle_pixels/constant.dart';
import 'package:eagle_pixels/controller/app_controller.dart';
import 'package:eagle_pixels/controller/job_checklist_controller.dart';
import 'package:eagle_pixels/controller/job_detail_controller.dart';
import 'package:eagle_pixels/controller/schedule_list_controller.dart';
import 'package:eagle_pixels/reuse/shared_preference_helper.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/schedule/service_report_screen.dart';
import 'package:flutter/material.dart';

import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:toast/toast.dart';

class ServiceReportScreen1 extends StatefulWidget {
  //final String imagePath;

  const ServiceReportScreen1({Key? key}) : super(key: key);
  @override
  _ServiceReportScreen1State createState() => _ServiceReportScreen1State();
}

class _ServiceReportScreen1State extends State<ServiceReportScreen1> {
  String? selectedInspect = '';

  final TimerController time = Get.find();
  final JobCheckListController checkListController = Get.find();
  final ScheduleListController schedule = Get.find();

  // final controller = Get.put(JobDetailController());
  final controller = Get.find<JobDetailController>();
  AJobDetail get detail {
    return controller.detail.value;
  }

  TextEditingController typeCtrl = TextEditingController();
  TextEditingController methodCtrl = TextEditingController();
  TextEditingController quantityCtrl = TextEditingController();
  TextEditingController otherCtrl = TextEditingController();
  FocusNode contactNameFocusNode = FocusNode();
  FocusNode clientIdFocusNode = FocusNode();
  FocusNode jobTitleFocusNode = FocusNode();

  List<String> attachedImageList = [];

  final List<String> radioValues = ['N', 'L', 'M', 'H'];
  String? selectedPreparationType = 'Advion Cockroach Gel';
  void addValue() {
    setState(() {
      controller.enteredValues.add({
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
    controller.itemsInspected.value = [
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

    controller.selectedValues =
        List.generate(controller.itemsInspected.length, (index) => []);

    String requestId = detail.aServiceId ?? '0';
    controller.getJobUpdate(requestId);
    loadImage();
    // Print for debugging
    print('Selected Values: ${controller.selectedValues}');
  }

  void loadImage() async {
    setState(() {});

    String? key = detail.aAttachedImages;
    String? attachedImage = await controller.getSignedUrl(key);
    attachedImage = attachedImage?.replaceAll('[', '').replaceAll(']', '');

    if (attachedImage != null && attachedImage.isNotEmpty) {
      setState(() {
        attachedImageList.clear();
        for (var url in attachedImage!.split(',')) {
          attachedImageList.add(url.trim());
        }
      });
    } else {
      setState(() {});
    }
  }

  Future<String> convertAndDisplayAmount(String amount) async {
    try {
      double amountInSGD = double.tryParse(amount) ?? 0.0;
      String? toCurrency =
          await SharedPreferencesHelper.instance.readCurrencyCode();
      String? currencySymbol =
          await SharedPreferencesHelper.instance.readCurrencySymbol();

      print(toCurrency);
      double result = await CurrencyConversionService()
          .convertAmount(amountInSGD, 'SGD', toCurrency!);
      return '$currencySymbol $result';
    } catch (error) {
      print('Error converting amount: $error');
      return 'Error';
    }
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
            if (detail.aSubServiceName != null &&
                detail.aSubServiceName!.toLowerCase().contains('termites'))
              JobDetailTitleDescriptionView(
                  'Warranty Status:', detail.aService ?? 'NA'),
            JobDetailTitleDescriptionView(
                'Source:', detail.aBusinessSource ?? 'NA'),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
              'Treatment Method:',
              (detail.aTreatmentMethod != null
                  ? detail.aTreatmentMethod!
                      .replaceAll('[', '')
                      .replaceAll(']', '')
                      .trim()
                  : 'NA'),
            ),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailAmountDescriptionView(
              'Service Amount',
              detail.aBookingAmount == null || detail.aBookingAmount!.isEmpty
                  ? () async => "NA"
                  : () async =>
                      await convertAndDisplayAmount(detail.aBookingAmount!),
            ),
          ],
        ),
        SizedBox(
          height: 20.dynamic,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            JobDetailTitleDescriptionView(
                'Degree of Infestation:', detail.aDegreeInfestation ?? 'NA'),
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
                'Preparation:',
                (detail.aPreparation ?? 'NA')
                    .replaceAll('[', '')
                    .replaceAll(']', '')
                    .trim()),
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
            JobDetailTitleDescriptionView(
                'Customer Type:', detail.aCustomerType ?? 'NA'),
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attachment Images',
              style: TextStyle(
                color: Colour.appDarkGrey,
                fontWeight: FontWeight.normal,
                fontSize: 12.dynamic,
              ),
            ),
            const SizedBox(height: 8),
            attachedImageList.isNotEmpty
                ? GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: attachedImageList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 items per row
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1,
                    ),
                    itemBuilder: (context, index) {
                      print(
                          'hdshdshhdsh ${attachedImageList[index].replaceAll('[', '').replaceAll(']', '')}');
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          attachedImageList[index]
                              .replaceAll('[', '')
                              .replaceAll(']', ''),
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print("Image load error at index $index: $error");
                            return Icon(Icons.broken_image);
                          },
                        ),
                      );
                    },
                  )
                : Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      'No attachment images.',
                      style:
                          TextStyle(fontSize: 12.dynamic, color: Colors.grey),
                    ),
                  ),
          ],
        )
      ],
    );
  }

  Future<bool> _handleBack(BuildContext context) async {
    String requestId = detail.aServiceId ?? '0';

    if (controller.isOtherChecked.value) {
      if (controller.otherInspectedController.text.isNotEmpty) {
        handleCheckboxChange(
          "Other",
          selectedOtherValues + "-" + controller.otherInspectedController.text,
          true,
        );
        handleCheckboxChange(
          "others_value",
          controller.otherInspectedController.text,
          true,
        );
      }
    }

    Map<String, String> convertedMap = {};
    controller.selectedCheckboxValues.forEach((key, value) {
      convertedMap['"$key"'] = '"$value"';
    });

    controller.preparation.value = jsonEncode(controller.enteredValues);
    controller.updateJob(requestId);

    Get.back(); // or Navigator.pop(context)

    return false; // Prevent default pop (we already handled it)
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _handleBack(context),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Colour.appLightGrey,
        appBar: AppBar(
          toolbarHeight: 66.dynamic,
          elevation: 0,
          backgroundColor: Colors.white,
          leading: RawMaterialButton(
            onPressed: () {
              _handleBack(context);
            },
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
                          GetBuilder<JobDetailController>(
                            init: JobDetailController(),
                            builder: (controller) {
                              return Container(
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Contact Name Field
                                    Text(
                                      'Contact Name',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 12.dynamic),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colour.appLightGrey,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        focusNode: contactNameFocusNode,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            controller.contactNameController,
                                        obscureText: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          hintText: "Contact Name",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),

                                    // Client ID Field
                                    SizedBox(height: 10.dynamic),
                                    Text(
                                      'Client Id',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 12.dynamic),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colour.appLightGrey,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        focusNode: clientIdFocusNode,
                                        textInputAction: TextInputAction.next,
                                        controller:
                                            controller.clientIdController,
                                        obscureText: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          hintText: "Client Id",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),

                                    // Job Title Field
                                    SizedBox(height: 10.dynamic),
                                    Text(
                                      'Job Title',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 12.dynamic),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colour.appLightGrey,
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      child: TextFormField(
                                        focusNode: jobTitleFocusNode,
                                        textInputAction: TextInputAction.done,
                                        controller:
                                            controller.jobTitleController,
                                        obscureText: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w300,
                                        ),
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.fromLTRB(
                                              20.0, 15.0, 20.0, 15.0),
                                          hintText: "Job Title",
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
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
                                    Obx(() => DropdownButton<String>(
                                          value: controller
                                              .selectedVisitType.value,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              controller.selectedVisitType
                                                  .value = newValue!;

                                              print(
                                                  controller.selectedVisitType);
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
                                                style: TextStyle(
                                                    fontSize: 14.dynamic),
                                              ),
                                            );
                                          }).toList(),
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.dynamic),
                          Obx(() => detail.aServiceName == "Pest Control"
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
                                        children: List.generate(
                                            controller.itemsInspected.length,
                                            (index) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 100.dynamic,
                                                    child: Text(
                                                      controller.itemsInspected[
                                                          index],
                                                      softWrap: true,
                                                      style: TextStyle(
                                                          fontSize: 14.dynamic),
                                                    ),
                                                  ),
                                                  ...radioValues.map((value) {
                                                    return Row(
                                                      children: [
                                                        Checkbox(
                                                          value: controller
                                                                  .selectedCheckboxValues[
                                                                      controller
                                                                              .itemsInspected[
                                                                          index]]
                                                                  ?.contains(
                                                                      value) ??
                                                              false,
                                                          onChanged:
                                                              (newValue) {
                                                            if (newValue!) {
                                                              controller
                                                                      .selectedValues[
                                                                  index] = [
                                                                value
                                                              ];

                                                              if (controller
                                                                          .itemsInspected[
                                                                      index] ==
                                                                  "Other") {
                                                                controller
                                                                    .isOtherChecked
                                                                    .value = true;
                                                                selectedOtherValues =
                                                                    controller
                                                                        .selectedValues[
                                                                            index]
                                                                        .first;
                                                              }
                                                            } else {
                                                              controller
                                                                  .selectedValues[
                                                                      index]
                                                                  .remove(
                                                                      value);
                                                              controller
                                                                  .isOtherChecked
                                                                  .value = false;
                                                            }
                                                            handleCheckboxChange(
                                                                controller
                                                                        .itemsInspected[
                                                                    index],
                                                                value,
                                                                newValue ??
                                                                    false);
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
                                                  : SizedBox(),
                                            ],
                                          );
                                        }),
                                      ),
                                      SizedBox(height: 10.dynamic),
                                      controller.isOtherChecked.value
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
                                                controller: controller
                                                    .otherInspectedController,
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
                                      SizedBox(height: 10.dynamic),
                                    ],
                                  ),
                                )
                              : SizedBox()),
                          SizedBox(height: 12.dynamic),
                          detail.aServiceName == "Pest Control"
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
                                      Obx(() => controller
                                              .enteredValues.isNotEmpty
                                          ? DataTable(
                                              columnSpacing: 10.dynamic,
                                              columns: [
                                                DataColumn(
                                                  label: SizedBox(
                                                    width: 80.dynamic,
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
                                                    width: 80.dynamic,
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
                                                    width: 60.dynamic,
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
                                              rows: controller.enteredValues
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
                                                          controller
                                                              .enteredValues
                                                              .removeAt(index);
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ]);
                                              }).toList(),
                                            )
                                          : SizedBox())
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
                                controller.visitType.value =
                                    controller.selectedVisitType.value;

                                bool hasUncheckedRequired = controller
                                    .itemsInspected
                                    .asMap()
                                    .entries
                                    .take(controller.itemsInspected.length -
                                        1) // Exclude the last entry
                                    .any((entry) {
                                  int index = entry.key;
                                  bool isEmpty =
                                      controller.selectedValues[index].isEmpty;
                                  return isEmpty;
                                });

                                if (controller
                                    .contactNameController.text.isEmpty) {
                                  Toast.show(
                                    'Please enter contact name',
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 16.dynamic,
                                      color: Colors.black,
                                    ),
                                  );
                                  return;
                                }
                                if (controller
                                    .clientIdController.text.isEmpty) {
                                  Toast.show(
                                    'Please enter client id',
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 16.dynamic,
                                      color: Colors.black,
                                    ),
                                  );
                                  return;
                                }
                                if (controller
                                    .jobTitleController.text.isEmpty) {
                                  Toast.show(
                                    'Please enter job title',
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                      fontSize: 16.dynamic,
                                      color: Colors.black,
                                    ),
                                  );
                                  return;
                                }

                                if (controller.isOtherChecked.value) {
                                  if (controller.otherInspectedController.text
                                      .isNotEmpty) {
                                    handleCheckboxChange(
                                        "Other",
                                        selectedOtherValues +
                                            "-" +
                                            controller
                                                .otherInspectedController.text,
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

                                if (detail.aServiceName == "Pest Control" &&
                                    controller.enteredValues.isEmpty) {
                                  Toast.show(
                                    'Please enter preparation used',
                                    backgroundColor: Colors.white,
                                    textStyle: TextStyle(
                                        fontSize: 16.dynamic,
                                        color: Colors.black),
                                  );
                                  return;
                                }

                                print(detail.aServiceName);
                                print(controller.selectedCheckboxValues
                                    .toString());

                                Map<String, String> convertedMap = {};

                                controller.selectedCheckboxValues
                                    .forEach((key, value) {
                                  convertedMap['"$key"'] = '"$value"';
                                });

                                print(convertedMap.toString());

                                controller.preparation.value =
                                    jsonEncode(controller.enteredValues);
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
