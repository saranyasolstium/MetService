import 'package:eagle_pixels/colors.dart';
import 'package:eagle_pixels/model/get_scheduled_job.dart';
import 'package:eagle_pixels/reuse/date_manager.dart';
import 'package:flutter/material.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';


const kCameraPlaceholder = 'images/camera.png';
const kUserPlaceholder = 'images/user.png';
const kErrorMsg = 'something went wrong please try again';

String safeString(String dateString) {
  try {
    DateTime originalDate = DateFormat(AppDateFormat.defaultF).parse(dateString);
    return DateFormat(AppDateFormat.scheduledTime).format(originalDate);
  } catch (e) {
    // Handle the case where the date string is invalid
    print('Error parsing date: $e');
    return ''; // or return the original string or a default value
  }
}



Future<Object?> compressImage(File imageFile) async {
  // Get the original file size
  int originalSize = await imageFile.length();

  // Target size in bytes (1 MB = 1024 * 1024 bytes)
  int targetSize = 1024 * 1024;

  // If the original size is already below the target size, return the original image file
  if (originalSize < targetSize) {
    return imageFile;
  }

  // Compress the image
  var result = await FlutterImageCompress.compressAndGetFile(
    imageFile.path,
    imageFile.path, // Path to save the compressed image (overwrite the original file)
    quality: 70, // Adjust the quality as needed (0-100)
    minHeight: 1920, // Set the minimum height (optional)
    minWidth: 1080, // Set the minimum width (optional)
  );

  // Get the size of the compressed file
  int compressedSize = await result!.length();

  // If the compressed size is still above the target size, further reduce the quality
  while (compressedSize > targetSize) {
    result = await FlutterImageCompress.compressAndGetFile(
      imageFile.path,
      imageFile.path, // Path to save the compressed image (overwrite the original file)
      quality: 60, // Reduce the quality further
      minHeight: 1920, // Set the minimum height (optional)
      minWidth: 1080, // Set the minimum width (optional)
    );
    compressedSize = await result!.length();
  }

  // Return the compressed image file
  return result;
}


// String safeString(dynamic value, {String def = "NA"}) {
//   if (value == null) {
//     return def;
//   } else {
//     try {
//       DateTime dateTime = DateFormat(AppDateFormat.defaultF).parse((value as MScheduledJobItem).serviceDate!);
//       String formattedString = DateFormat('your_pattern_here').format(dateTime);
//       return formattedString.isNotEmpty ? formattedString : def;
//     } catch (e) {
//       return def;
//     }
//   }
// }

Widget titleText(String title) => Text(
      title,
      style: TextStyle(
          color: Colour.appBlack,
          fontWeight: FontWeight.w400,
          fontSize: 16.dynamic),
    );

enum ViewState { loading, updating, refreshing, failed, success,message }

extension ViewStateExtension on ViewState {
  bool get isSuccess {
    return this == ViewState.success;
  }

  bool get isLoading {
    return this == ViewState.loading;
  }

  bool get isFailed {
    return this == ViewState.failed;
  }

  bool get isMessage{
    return this == ViewState.message;
  }
}

String constructAddress(List<String?> units) {
  var address = '';
  units.forEach((element) {
    if (element != null && element != '') {
      address += '$element, ';
    }
  });
  if (address.length < 2) {
    return '';
  } else {
    return address.substring(0, address.length - 2);
  }
}

// String constructNames(List<String?> units) {
//   var address = '';
//   units.forEach((element) {
//     if (element != null && element != '') {
//       address += '$element ';
//     }
//   });
//   if (address.length < 1) {
//     return '';
//   } else {
//     return address.substring(0, address.length - 1);
//   }
//}
