import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/reuse/storage.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/local_auth.dart';
import 'package:http/http.dart' as http;

import 'package:eagle_pixels/model/profile_model.dart';
import 'package:toast/toast.dart';
import 'dart:io';

enum LoginStatus { logged, logout, loading }

class MAuthenticationStatus {
  PickedFile? image;
  bool isLocalAuthenticated = false;
  Position? position;
  Future<String> get base64Image async {
    final byte = await File(image!.path).readAsBytes();
    return base64Encode(byte);
  }

  bool get isValid {
    return (image != null && isLocalAuthenticated && position != null);
  }

  MAuthenticationStatus();
}

class AppController extends GetxController {
  bool get isEngineer {
    return _user.value.isEngineer;
  }

  bool get isAttendanceEngineer {
    return false;
    return _user.value.employeeDetails?.designation != '1';
  }

  //Local Auth
  var _localAuth = LocalAuthentication();
  // var hasFingerPrintLock = false.obs;
  // var hasFaceLock = false.obs;
  // var isUserAuthenticated = false.obs;

  // Image Picker
  // late PickedFile _image;
  // final picker = ImagePicker();

  // Geolocation
  // Position? position;
  // double? latitude;
  // double? longitude;

    Future<MAuthenticationStatus> verifyUser() async {
    var result = MAuthenticationStatus();
    try {
      final position = await determinePosition();
      result.position = position;

      final isLocalAuthenticated = await onLocalAuthenticate();
      result.isLocalAuthenticated = isLocalAuthenticated;
      hideLoading();

      final pickedImageFile = await ImagePicker().pickImage(source: ImageSource.camera);

      if (pickedImageFile != null) {
        // Handle the conversion from XFile to PickedFile
        result.image = PickedFile(pickedImageFile.path);
      } else {
        throw Exception('Not able to get image');
      }

      print('Verification Result: $result');
      return result;
    } catch (e) {
      print('Error during user verification: $e');
      throw e;
    }
  }


   Future<bool> onLocalAuthenticate() async {
    try {
      var isAvailable = await _localAuth.isDeviceSupported();

      if (isAvailable) {
        var availableBio = await _localAuth.getAvailableBiometrics();
        print('Available Biometrics: $availableBio');
        hideLoading(value: 0);

        var isAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Authentication for attendance',
        );

        print('Authentication Result: $isAuthenticated');

        if (isAuthenticated) {
          // Returning true indicates successful authentication
          return true;
        } else {
          // Returning false indicates authentication failure
          return false;
        }
      } else {
        // Returning false indicates that the device does not support local authentication
        print('Device does not support local authentication');
        return false;
      }
    } catch (e) {
      print('Error during local authentication: $e');
      throw e;
    }
  }

  Future<Position> determinePosition() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        throw Exception('Location services are disabled.');
      }

      LocationPermission permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          throw Exception('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        throw Exception('Location permissions are permanently denied, we cannot request permissions.');
      }

      return await Geolocator.getCurrentPosition();
    } catch (e) {
      print('Error during position determination: $e');
      throw e;
    }
  }


  void showSnackBar(
      {required String title,
      required String message,
      Color? backgroundColor}) {
    Get.snackbar(title, message,
        colorText: Colors.white,
        backgroundColor: backgroundColor,
        snackPosition: SnackPosition.BOTTOM);
  }

  
  Future<String?> uploadImage(filepath, url) async {
    try {
      showLoading();
      print('image uploading');
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.fields['service_id'] = '1';
      request.files.add(await http.MultipartFile.fromPath('image', filepath));
      request.headers.addAll(Header.defaultHeader);
      var res = await request.send();
      var jsonResponse = await http.Response.fromStream(res);
      return jsonDecode(jsonResponse.body)["status"];
      // return res.reasonPhrase;
    } catch (e) {
      print('Error$e');
    } finally {
      hideLoading();
    }
  }

  static AppController get to => Get.find<AppController>();

  // static var profile = MProfile();
  var loginStatus = LoginStatus.loading.obs;
  var showLoading = 0.obs;

  // void showLoader({int load = 0}) {
  //   showLoading.value = load;
  //   update();
  // }

  static var _user = MProfile().obs;

  static MProfile get user {
    return _user.value;
  }

  GetStorage storage = GetStorage();

  @override
  void onInit() async {
    // Future.delayed(Duration(seconds: 2), () => ever(showLoading, showLoader()));
    // ever(AppController.to.isLogged, AppController.to.setupUI());
    super.onInit();
    loadInitialState();
  }

  fetchProfile() async {
    var response = await API.service
        .call(model: MProfileResponse(), endPoint: EndPoint.profile);
    if (response.isValidModel) {
      _user.value = response.model!.data!.first;
      if (_user.value.isActive) {
        loginStatus.value = LoginStatus.logged;
        Get.find<AttendanceController>().fetchAttendanceStatus();
      } else {
        loginStatus.value = LoginStatus.logout;
        Toast.show('Account not active', textStyle: Get.context);
      }
    } else {
      // loginStatus.value = LoginStatus.logout;
      // TODO: try again request;
    }
  }

  loadInitialState() async {
    await GetStorage.init();
    if (storage.token.isNotEmpty) {
      fetchProfile();
    } else {
      loginStatus.value = LoginStatus.logout;
    }
  }

  Widget rootView() {
    switch (loginStatus.value) {
      case LoginStatus.logged:
        return Nav();
      case LoginStatus.logout:
        return LoginScreen();
      case LoginStatus.loading:
        return Scaffold(
          body: Container(
            child: Center(
                child: Text(
              'Loading...',
              style: TextStyle(
                fontSize: 20.dynamic,
              ),
            )),
          ),
        );
    }
  }

  // addOverLay() {}

  Widget defaultLoaderView() {
    // return Container();
    return Obx(() {
      if (showLoading.value > 0) {
        return ProgressHUD(child: Container());
      } else {
        return Container();
      }
    });
    // }
    // return Container();
  }
}
