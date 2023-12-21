import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eagle_pixels/dynamic_font.dart';

extension PhotoChooseAction on PhotoChooseScreen {
  onPickFromGallery(BuildContext context) async {
    final image = await this.getImage(ImageSource.gallery);
    Navigator.pop(context, image);
  }

  onPickFromCamera(BuildContext context) async {
    final image = await this.getImage(ImageSource.camera);
    Navigator.pop(context, image);
  }
}

extension PhotoChooseExtension on PhotoChooseScreen {
  Future<File?> getImage(ImageSource source) async {
    try {
      XFile? pickedFile = await imagePicker.pickImage(source: source);
      print('Image picked');
      if (pickedFile != null) {
        return File(pickedFile.path);
      } else {
        print('No image selected.');
        return null;
      }
    } catch (error) {
      print('Error $error');
      return null;
    }
  }
}

class PhotoChooseScreen extends StatelessWidget {
  final imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Container(
          //   color: Colors.black.withOpacity(0.52),
          // ),

          Center(
            child: Container(
              padding: EdgeInsets.only(bottom: 30.dynamic),
              width: Get.width - 45,
              constraints: BoxConstraints(
                minHeight: Get.width - 245,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 5,
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.pop(context);
                        }),
                    alignment: Alignment.topRight,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            this.onPickFromGallery(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              'images/gallery_open.png',
                              height: 98.dynamic,
                              width: 116.dynamic,
                            ),
                            // padding: EdgeInsets.all(10.dynamic),
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   width: 10.dynamic,
                      // ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            this.onPickFromCamera(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10)),
                            child: Image.asset(
                              'images/camera_open.png',
                              height: 98.dynamic,
                              width: 116.dynamic,
                            ),
                            // padding: EdgeInsets.all(10.dynamic),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
