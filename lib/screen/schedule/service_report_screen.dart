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
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:eagle_pixels/dynamic_font.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/controller/timer_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:eagle_pixels/model/abstract_class.dart';
import 'package:dotted_border/dotted_border.dart';
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
  List<TextEditingController> _remarkControllers = [];

  final picker = ImagePicker();

  final TimerController time = Get.find();
  final JobCheckListController checkListController = Get.find();
  final ScheduleListController schedule = Get.find();

  // final controller = Get.put(JobDetailController());
  final controller = Get.find<JobDetailController>();
  AJobDetail get detail {
    return controller.detail.value;
  }

  /// Function to select multiple images
  Future<void> getImages() async {
    final List<XFile>? pickedFiles = await picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles.map((file) => File(file.path)).toList());
        _imagePaths.addAll(pickedFiles.map((file) => file.name).toList());
        _remarkControllers.addAll(
          List.generate(pickedFiles.length, (index) => TextEditingController()),
        );
      });
    }
  }

  Future<void> processImagesAndRemarks() async {
    controller.concatenatedImages = '';
    List<String> base64Images = [];

    // Encode all images to base64
    for (var imageFile in _images) {
      List<int> imageBytes = await imageFile.readAsBytes();
      String base64Image = base64Encode(imageBytes);
      base64Images.add(base64Image);
    }

    // Concatenate with commas
    for (int i = 0; i < base64Images.length; i++) {
      controller.concatenatedImages += base64Images[i];
      if (i < base64Images.length - 1) {
        controller.concatenatedImages += ',';
      }
    }

    // Capture remarks into comma-separated string
    controller.imageCaption.value =
        _remarkControllers.map((c) => c.text).join(', ');

    print("All Remarks: ${controller.imageCaption.value}");
  }

  /// Function to capture a single image using the camera
  Future<void> getSingleImage(ImageSource source) async {
    final XFile? pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _images.add(File(pickedFile.path));
        _imagePaths.add(pickedFile.name);
        _remarkControllers.add(TextEditingController());
      });
    }
  }

  /// Function to remove a selected image
  Future<void> _removeImage(int index) async {
    if (index >= 0 && index < _images.length) {
      setState(() {
        _images.removeAt(index);
        _imagePaths.removeAt(index);
        _remarkControllers[index].dispose(); // ✅ Dispose controller
        _remarkControllers.removeAt(index); // ✅ Remove remark controller
      });
    } else {
      print("Invalid index: $index");
    }
  }

  /// Function to show image picker options
  void showImagePickerModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Select from Gallery'),
                onTap: () {
                  getImages();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Capture with Camera'),
                onTap: () {
                  getSingleImage(ImageSource.camera);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<Uint8List> networkImageToBytes(String url) async {
    final response = await http.get(Uri.parse(url));
    return response.bodyBytes;
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
            onPressed: () {
              processImagesAndRemarks();
              Get.back();
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
                                        // Clear the signature and reset the URL
                                        controller.signatureController.value
                                            .clear();
                                        controller.customerSignatureUrl.value =
                                            "";
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
                                Obx(() => DottedBorder(
                                      color: Colour.appDarkGrey,
                                      borderType: BorderType.RRect,
                                      dashPattern: [4.dynamic, 4.dynamic],
                                      child: controller.customerSignatureUrl
                                              .value.isEmpty
                                          ? Signature(
                                              height: 67.dynamic,
                                              width: Get.width - 60.dynamic,
                                              controller: controller
                                                  .signatureController.value,
                                              backgroundColor: Colors.white,
                                            )
                                          : Container(
                                              height: 67.dynamic,
                                              width: Get.width - 60.dynamic,
                                              child: Center(
                                                child: Image.network(controller
                                                    .customerSignatureUrl
                                                    .value),
                                              ),
                                            ),
                                    )),
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
                                        controller.technicianSignUrl.value = "";
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
                                Obx(
                                  () => DottedBorder(
                                      color: Colour.appDarkGrey,
                                      borderType: BorderType.RRect,
                                      dashPattern: [4.dynamic, 4.dynamic],
                                      child:
                                          controller.technicianSignUrl.isEmpty
                                              ? Signature(
                                                  height: 67.dynamic,
                                                  width: Get.width - 60.dynamic,
                                                  controller: controller
                                                      .signatureTechnicianController
                                                      .value,
                                                  backgroundColor: Colors.white,
                                                )
                                              : Container(
                                                  height: 67.dynamic,
                                                  width: Get.width - 60.dynamic,
                                                  child: Center(
                                                      child: Image.network(
                                                          controller
                                                              .technicianSignUrl
                                                              .value)),
                                                )),
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
                          Container(
                            height: 300,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: _images.isNotEmpty
                                ? ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    itemCount: _images.length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 5),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            // ✅ Image Display
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: Image.file(
                                                _images[index],
                                                fit: BoxFit.cover,
                                                height: 60,
                                                width: 60,
                                              ),
                                            ),
                                            SizedBox(width: 10),

                                            // ✅ TextField for Remarks (Bound to Controller)
                                            Expanded(
                                              child: TextField(
                                                controller: _remarkControllers[
                                                    index], // ✅ Bound controller
                                                decoration: InputDecoration(
                                                  hintText: "Enter remark",
                                                  border: OutlineInputBorder(),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 10,
                                                          vertical: 8),
                                                ),
                                              ),
                                            ),
                                            SizedBox(width: 10),

                                            // ✅ Remove Image Button
                                            GestureDetector(
                                              onTap: () => _removeImage(index),
                                              child: Container(
                                                padding: EdgeInsets.all(6),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.red,
                                                ),
                                                child: Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  )
                                : Center(child: Text("No images selected")),
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
                                  var bytes;
                                  var techBytes;
                                  bool allRemarksFilled =
                                      _remarkControllers.every((controller) =>
                                          controller.text.trim().isNotEmpty);

                                  print('saranya ${_remarkControllers.length}');
                                  if (controller
                                      .signatureController.value.isNotEmpty) {
                                    bytes = await controller
                                        .signatureController.value
                                        .toPngBytes();
                                  } else if (controller
                                      .customerSignatureUrl.value.isNotEmpty) {
                                    bytes = await networkImageToBytes(
                                        controller.customerSignatureUrl.value);
                                  }

                                  if (controller.signatureTechnicianController
                                      .value.isNotEmpty) {
                                    techBytes = await controller
                                        .signatureTechnicianController.value
                                        .toPngBytes();
                                  } else if (controller
                                      .technicianSignUrl.value.isNotEmpty) {
                                    techBytes = await networkImageToBytes(
                                        controller.technicianSignUrl.value);
                                  }

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
                                  } else if (!allRemarksFilled) {
                                    Toast.show(
                                      'Please fill all remarks before submitting',
                                      backgroundColor: Colors.white,
                                      textStyle: TextStyle(
                                          fontSize: 16.dynamic,
                                          color: Colors.black),
                                    );
                                  } else if (bytes != null &&
                                      techBytes != null) {
                                    List<String> base64Images = [];

                                    // print(_images.length);
                                    for (var imageFile in _images) {
                                      List<int> imageBytes =
                                          await imageFile.readAsBytes();
                                      String base64Image =
                                          base64Encode(imageBytes);
                                      base64Images.add(base64Image);
                                    }
                                    // print(base64Images.length);

                                    for (int i = 0;
                                        i < base64Images.length;
                                        i++) {
                                      controller.concatenatedImages +=
                                          base64Images[i];
                                      if (i < base64Images.length - 1) {
                                        controller.concatenatedImages += ',';
                                      }
                                    }
                                    Map<String, String> convertedMap = {};

                                    controller.selectedCheckboxValues
                                        .forEach((key, value) {
                                      convertedMap['"$key"'] = '"$value"';
                                    });

                                    print(convertedMap.toString());
                                    controller.imageCaption.value =
                                        _remarkControllers
                                            .map(
                                                (controller) => controller.text)
                                            .join(', ');

                                    print(
                                        "All Remarks: ${controller.imageCaption.value}");

                                    String? status = await checkListController
                                        .onCompleteJob(
                                            requestID: detail.aServiceId ?? '0',
                                            signature: base64Encode(bytes),
                                            technicianSign:
                                                base64Encode(techBytes),
                                            feedback: controller.feedback.value,
                                            paymentMode: controller
                                                .selectedPaymentMode!,
                                            chemicalList: "",
                                            technicianComment: controller
                                                .engineerFeedback.value,
                                            imagPath:
                                                controller.concatenatedImages,
                                            visitType:
                                                controller.visitType.value,
                                            inspectionReport:
                                                convertedMap.toString(),
                                            remark: controller.remark.value,
                                            areasInspected:
                                                controller.areasInspected.value,
                                            preparation:
                                                controller.preparation.value,
                                            contactName: controller
                                                .contactNameController.text,
                                            clientId: controller
                                                .clientIdController.text,
                                            jobTitle: controller
                                                .jobTitleController.text,
                                            imageRemark:
                                                controller.imageCaption.value);

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
                                  setState(() {
                                    // ✅ Clear text fields
                                    controller.contactNameController.text = "";
                                    controller.clientIdController.text = "";
                                    controller.jobTitleController.text = "";

                                    // ✅ Reset dropdowns and checkboxes
                                    controller.selectedVisitType.value =
                                        'Routine';
                                    controller.selectedCheckboxValues.clear();
                                    print(
                                        'varshan123 ${controller.selectedCheckboxValues}');

                                    controller.selectedValues = List.generate(
                                        controller.itemsInspected.length,
                                        (index) => []);
                                    controller.isOtherChecked.value = false;
                                    controller.otherInspectedController.text =
                                        "";

                                    // ✅ Clear preparation used
                                    controller.enteredValues.clear();
                                    controller.preparation.value = "";
                                    // ✅ Clear "Areas Inspected" and "Remarks"
                                    controller.areasInspected.value = "";
                                    controller.remark.value = "";

                                    // ✅ Reset Payment Mode
                                    controller.selectedPaymentMode =
                                        "Bank Transfer";
                                    controller.other.value = "";

                                    // ✅ Clear Customer & Technician E-Sign
                                    controller.signatureController.value
                                        .clear();
                                    controller.customerSignatureUrl.value = "";
                                    controller
                                        .signatureTechnicianController.value
                                        .clear();
                                    controller.technicianSignUrl.value = "";

                                    // ✅ Clear Feedback & Technician Feedback
                                    controller.feedback.value = "";
                                    controller.engineerFeedback.value = "";

                                    // ✅ Refresh UI updates
                                    controller.areasInspected.refresh();
                                    controller.remark.refresh();
                                    controller.feedback.refresh();
                                    controller.engineerFeedback.refresh();
                                    controller.update();
                                  });
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
