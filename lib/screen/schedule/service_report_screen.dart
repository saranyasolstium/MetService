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
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:flutter/material.dart';

import 'package:eagle_pixels/dynamic_font.dart';
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

class ServiceReportScreen extends StatefulWidget {
  //final String imagePath;

  const ServiceReportScreen({Key? key}) : super(key: key);
  @override
  _ServiceReportScreenState createState() => _ServiceReportScreenState();
}

class _ServiceReportScreenState extends State<ServiceReportScreen> {
  // String? selectedChemist = '';
  List<File> _images = [];
  List<String> _imagePaths = [];

  final picker = ImagePicker();

  final TimerController time = Get.find();
  final JobCheckListController checkListController = Get.find();
  final ScheduleListController schedule = Get.find();

  // final controller = Get.put(JobDetailController());
  final controller = Get.find<JobDetailController>();
  AJobDetail get detail {
    return controller.detail.value;
  }

  Future getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        _imagePaths.add(pickedFile.name);
      });
    }
  }

  Future<void> _removeImage(int index) async {
    setState(() {
      _images.removeAt(index);
      _imagePaths.removeAt(index);
    });
  }

  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
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
                          // GetBuilder<JobCheckListController>(
                          //   builder: (_) {
                          //     return ListView.builder(
                          //       shrinkWrap: true,
                          //       physics: NeverScrollableScrollPhysics(),
                          //       itemBuilder: (builder, index) {
                          //         var item =
                          //             checkListController.selectedlist[index];
                          //         return ReportItem(
                          //           item: item,
                          //         );
                          //       },
                          //       itemCount:
                          //           checkListController.selectedlist.length,
                          //     );
                          //   },
                          // ),
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
                                  'Areas Inspected/Treated',
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
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      controller.areasInspected.value = txt;
                                    },
                                    controller: TextEditingController(
                                        text: controller.areasInspected.value),
                                    obscureText: false,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Write your areas inspected",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.dynamic),
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
                                Text(
                                  'Recommendation/Remarks',
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
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      controller.remark.value = txt;
                                    },
                                    controller: TextEditingController(
                                        text: controller.remark.value),
                                    obscureText: false,
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Write your remarks",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.dynamic),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Payment Mode :',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        color: Colour.appBlack,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    DropdownButton<String>(
                                      value: controller.selectedPaymentMode,
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          controller.selectedPaymentMode =
                                              newValue!;
                                          controller.other.value = "";
                                          print(controller.selectedPaymentMode);
                                        });
                                      },
                                      items: <String>['Bank Transfer', 'Others']
                                          .map<DropdownMenuItem<String>>(
                                              (String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: TextStyle(
                                                  fontSize: 14.dynamic)),
                                        );
                                      }).toList(),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 12.dynamic,
                                ),
                                controller.selectedPaymentMode ==
                                        "Bank Transfer"
                                    ? Column(
                                        children: [
                                          Image.asset(
                                            'images/met_sgqr.jpg',
                                            fit: BoxFit.fill,
                                            height: 400.dynamic,
                                          ),
                                          Text(
                                            'OCBC Bank : AC 509079455001',
                                            style: TextStyle(
                                              fontSize: 16.dynamic,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      )
                                    : SizedBox(),
                                controller.selectedPaymentMode == "Others"
                                    ? Container(
                                        decoration: BoxDecoration(
                                          color: Colour.appLightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: TextFormField(
                                          obscureText: false,
                                          onChanged: (txt) {
                                            controller.other.value = txt;
                                          },
                                          controller: TextEditingController(
                                              text: controller.other.value),
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 1,
                                          style: TextStyle(
                                              fontSize: 14.dynamic,
                                              fontWeight: FontWeight.w300),
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                20.0, 15.0, 20.0, 15.0),
                                            hintText: "Others",
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      )
                                    : SizedBox(),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Customer E-Sign',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w400,
                                        color: Colour.appText,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller.signatureController.value
                                            .clear();
                                      },
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                          color: Colour.appBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.dynamic),
                                DottedBorder(
                                  color: Colour.appDarkGrey,
                                  borderType: BorderType.RRect,
                                  dashPattern: [4.dynamic, 4.dynamic],
                                  child: Signature(
                                    height: 67.dynamic,
                                    width: Get.width - 60.dynamic,
                                    controller:
                                        controller.signatureController.value,
                                    backgroundColor: Colors.white,
                                  ),
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
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Technician E-Sign',
                                      style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w400,
                                        color: Colour.appText,
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        controller
                                            .signatureTechnicianController.value
                                            .clear();
                                      },
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                          fontSize: 14.dynamic,
                                          fontWeight: FontWeight.w400,
                                          color: Colour.appBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 12.dynamic),
                                DottedBorder(
                                  color: Colour.appDarkGrey,
                                  borderType: BorderType.RRect,
                                  dashPattern: [4.dynamic, 4.dynamic],
                                  child: Signature(
                                    height: 67.dynamic,
                                    width: Get.width - 60.dynamic,
                                    controller: controller
                                        .signatureTechnicianController.value,
                                    backgroundColor: Colors.white,
                                  ),
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
                                Text(
                                  'Customer Feedback',
                                  style: TextStyle(
                                    fontSize: 14.dynamic,
                                    fontWeight: FontWeight.w400,
                                    color: Colour.appText,
                                  ),
                                ),
                                SizedBox(height: 12.dynamic),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      controller.feedback.value = txt;
                                    },
                                    obscureText: false,
                                    controller: TextEditingController(
                                        text: controller.feedback.value),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Write your feedback",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.dynamic),
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
                                Text(
                                  'Technician Feedback',
                                  style: TextStyle(
                                    fontSize: 14.dynamic,
                                    fontWeight: FontWeight.w400,
                                    color: Colour.appText,
                                  ),
                                ),
                                SizedBox(height: 12.dynamic),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colour.appLightGrey,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  child: TextFormField(
                                    onChanged: (txt) {
                                      controller.engineerFeedback.value = txt;
                                    },
                                    obscureText: false,
                                    controller: TextEditingController(
                                        text:
                                            controller.engineerFeedback.value),
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    style: TextStyle(
                                        fontSize: 14.dynamic,
                                        fontWeight: FontWeight.w300),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.fromLTRB(
                                          20.0, 15.0, 20.0, 15.0),
                                      hintText: "Write your feedback",
                                      border: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.dynamic),
                          Container(
                            margin:
                                EdgeInsets.symmetric(horizontal: 17.dynamic),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colour.appBlue,
                              borderRadius: BorderRadius.all(
                                Radius.circular(5.dynamic),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () async {
                                showImagePickerModal(context);
                              },
                              child: Text(
                                'Select Image',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.dynamic,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: List<Widget>.generate(_imagePaths.length,
                                (index) {
                              final path = _imagePaths[index];
                              return Row(
                                children: [
                                  SizedBox(width: 10),
                                  IconButton(
                                    icon: Icon(Icons.close, color: Colors.red),
                                    onPressed: () {
                                      _removeImage(index);
                                    },
                                  ),
                                  SizedBox(width: 5),
                                  Expanded(
                                    child: Text(
                                      path,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                ],
                              );
                            }),
                          ),
                          SizedBox(height: 42.dynamic),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.dynamic,
                  ),
                  GetBuilder<JobCheckListController>(builder: (_) {
                    return Container(
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
                                  var bytes = await controller
                                      .signatureController.value
                                      .toPngBytes();
                                  var techBytes = await controller
                                      .signatureTechnicianController.value
                                      .toPngBytes();

                                  if (controller.selectedPaymentMode ==
                                          "Others" &&
                                      controller.other.isEmpty) {
                                    Toast.show(
                                      'Please enter other ',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  } else if (controller
                                      .feedback.value.isEmpty) {
                                    Toast.show(
                                      'Please provide customer feedback',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  } else if (controller
                                      .engineerFeedback.value.isEmpty) {
                                    Toast.show(
                                      'Please provide technician feedback',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  } else if (_images.isEmpty) {
                                    Toast.show(
                                      'Please select at least one image',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  } else if (bytes != null &&
                                      techBytes != null) {
                                    List<String> base64Images = [];

                                    print(_images.length);
                                    for (var imageFile in _images) {
                                      List<int> imageBytes =
                                          await imageFile.readAsBytes();
                                      String base64Image =
                                          base64Encode(imageBytes);
                                      base64Images.add(base64Image);
                                    }
                                    print(base64Images.length);

                                    String concatenatedImages = '';

                                    for (int i = 0;
                                        i < base64Images.length;
                                        i++) {
                                      concatenatedImages += base64Images[i];
                                      if (i < base64Images.length - 1) {
                                        concatenatedImages += ',';
                                      }
                                    }
                                    Map<String, String> convertedMap = {};

                                    controller.selectedCheckboxValues
                                        .forEach((key, value) {
                                      convertedMap['"$key"'] = '"$value"';
                                    });

                                    print(convertedMap.toString());

                                    String? status =
                                        await checkListController.onCompleteJob(
                                            requestID: detail.aServiceId ?? '0',
                                            signature: base64Encode(bytes),
                                            technicianSign:
                                                base64Encode(techBytes),
                                            feedback: controller.feedback.value,
                                            paymentMode:
                                                controller.selectedPaymentMode!,
                                            chemicalList: "",
                                            technicianComment: controller
                                                .engineerFeedback.value,
                                            imagPath: concatenatedImages,
                                            visitType:
                                                controller.visitType.value,
                                            inspectionReport:
                                                convertedMap.toString(),
                                            remark: controller.remark.value,
                                            areasInspected:
                                                controller.areasInspected.value,
                                            preparation:
                                                controller.preparation.value,
                                            contactName:
                                                controller.contactName.value,
                                            clientId: controller.clientId.value,
                                            jobTitle:
                                                controller.jobTitle.value);

                                    if (status != null) {
                                      Toast.show(
                                        status,
                                        backgroundColor: Colors.white,
                                        textStyle: TextStyle(
                                            fontSize: 16.dynamic,
                                            color: Colors.black),
                                      );
                                    } else {
                                      Get.toNamed(NavPage.jobCompleted);
                                    }
                                  } else {
                                    Toast.show(
                                      'Please put your signature',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  }
                                },
                                child: checkListController.isLoading
                                    ? Center(child: CircularProgressIndicator())
                                    : Text(
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
                                border: Border.all(
                                    width: 1.5, color: Colour.appBlue),
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
                    );
                  })
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

// class ReportItem extends StatelessWidget {
//   // final JobCheckListController checkListController = Get.find();
//   // final int index;
//   //
//   // ACheckListItem get item {
//   //   return checkListController.selectedlist[index];
//   // }
//   //
//   // MCheckListOption get selectedItem {
//   //   return item.selectedItem!;
//   // }

//   final ACheckListItem item;
//   ReportItem({required this.item});
//   // final _remarkController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         horizontal: 17.dynamic,
//         vertical: 18.dynamic,
//       ),
//       child: Container(
//         width: double.infinity,
//         padding: EdgeInsets.only(
//           top: 12.dynamic,
//           left: 14.dynamic,
//           right: 14.dynamic,
//           bottom: 15.dynamic,
//         ),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(
//             8.0,
//           ),
//           border: Border.all(
//             width: 1.5,
//             color: item.lastItem?.color ?? Colors.grey,
//           ),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Row(
//               // mainAxisAlignment: MainAxisAlignment.spaceAround,
//               // mainAxisSize: MainAxisSize.max,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Expanded(
//                   child: Text(
//                     item.title,
//                     style: TextStyle(
//                       color: Colour.appBlack,
//                       fontSize: 16.dynamic.dynamic,
//                       fontWeight: FontWeight.normal,
//                     ),
//                   ),
//                 ),
//                 // Expanded(child: Container()),
//                 SizedBox(width: 5.dynamic),
//                 ReportCheckbox(
//                     item: item.lastItem ?? MCheckListOption('', Colors.grey)),
//               ],
//             ),
//             Divider(
//               color: Colour.appDarkGrey,
//             ),
//             // Row(
//             //   mainAxisSize: MainAxisSize.max,
//             //   children: [
//             //     CheckListSelectionView(section: index, row: 0),
//             //   ],
//             // ),
//             // Expanded(
//             //   child: Container(
//             //     child: StaggeredGridView.countBuilder(
//             //       crossAxisCount: 2,
//             //       itemCount: item.options.length,
//             //       itemBuilder: (builder, row) {
//             //         var selection = item.options[index];
//             //         return CheckListSelectionView(section: index, row: row);
//             //       },
//             //       staggeredTileBuilder: (index) => StaggeredTile.fit(1),
//             //     ),
//             //   ),
//             // ),
//             Padding(
//               padding: EdgeInsets.only(
//                 top: 10.5.dynamic,
//                 bottom: 5.dynamic,
//               ),
//               child: Text(
//                 'Remarks',
//                 style: TextStyle(
//                   color: Colour.appRed,
//                   fontSize: 16.dynamic,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//               ),
//               child: Text(
//                 item.remarks,
//                 style: TextStyle(
//                   fontSize: 14.dynamic,
//                   color: Colour.appDarkGrey,
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10.dynamic,
//             ),
//             Row(
//               children: [
//                 // Image.asset(
//                 //   'images/add.png',
//                 //   width: 19.dynamic,
//                 //   height: 19.dynamic,
//                 // ),
//                 Text(
//                   'Photo Added',
//                   style: TextStyle(
//                     fontSize: 14.dynamic,
//                     fontWeight: FontWeight.w400,
//                     color: Colour.appText,
//                   ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 16.dynamic,
//             ),
//             SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: List.generate(
//                   item.selectedImages.length,
//                   (row) => Row(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         clipBehavior: Clip.hardEdge,
//                         decoration: BoxDecoration(
//                           border: Border.all(color: Colour.appBlue),
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(5.0),
//                           clipBehavior: Clip.hardEdge,
//                           child: (item.selectedImages[row] is Uint8List)
//                               ? Image.memory(
//                                   item.selectedImages[row],
//                                   height: 43.dynamic,
//                                   width: 43.dynamic,
//                                   fit: BoxFit.fill,
//                                   isAntiAlias: false,
//                                 )
//                               : Image.network(
//                                   item.selectedImages[row],
//                                   height: 43.dynamic,
//                                   width: 43.dynamic,
//                                   fit: BoxFit.fill,
//                                   isAntiAlias: false,
//                                 ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 20.dynamic,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10.dynamic,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ReportCheckbox extends StatelessWidget {
//   final MCheckListOption item;

//   ReportCheckbox({required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(
//           8.0,
//         ),
//       ),
//       child: Row(
//         children: [
//           Text(
//             item.name,
//             style: TextStyle(
//               color: Colour.appBlack,
//               fontSize: 14.0,
//               fontWeight: FontWeight.w400,
//             ),
//           ),
//           SizedBox(
//             width: 8.dynamic,
//           ),
//           CustomCheckbox(
//             isChecked: true,
//             size: 18.dynamic,
//             selectedColor: item.color,
//             selectedIconColor: Colors.white,
//             // didSelect: (checkbox) {
//             //   if (checkbox) {
//             //     checklistController.checkList[section].selectedItem = item;
//             //   } else {
//             //     checklistController.checkList[section].selectedItem = null;
//             //   }
//             //
//             //   checklistController.update();
//             // },
//           ),
//         ],
//       ),
//     );
//   }
// }
