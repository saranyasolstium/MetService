import 'package:eagle_pixels/dynamic_font.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarService {
  static void showSnackbar(String title, String message) {
    Get.snackbar(
      '',
      '',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.grey,
      colorText: Colors.white,
      duration: Duration(seconds: 3),
      titleText: Text(
        title,
        style: TextStyle(fontSize: 16.dynamic),
      ),
      messageText: Text(
        message,
        style: TextStyle(fontSize: 14.dynamic), 
      ),
    );
  }
}
