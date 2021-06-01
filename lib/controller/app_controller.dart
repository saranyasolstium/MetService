import 'dart:convert';

import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/headers.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/controller/app_binder.dart';
import 'package:eagle_pixels/controller/attendance_controller.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/model/site_model.dart';
import 'package:eagle_pixels/reuse/loader.dart';
import 'package:eagle_pixels/reuse/storage.dart';
import 'package:eagle_pixels/screen/all/job_detail_screen.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:eagle_pixels/screen/schedule/job_checklist_screen.dart';
import 'package:eagle_pixels/screen/schedule/schedule_job_details.dart';
import 'package:eagle_pixels/screen/schedule/schedule_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:http/http.dart' as http;

import 'package:eagle_pixels/model/profile_model.dart';
import 'package:eagle_pixels/screen/toast/feedback_screen.dart';
import 'package:toast/toast.dart';

enum LoginStatus { logged, logout, loading }

class AppController extends GetxController {
  bool get isEngineer {
    return _user.value.isEngineer;
  }

  bool get isAttendanceEngineer {
    return _user.value.employeeDetails?.department == '3';
  }

  //Local Auth
  var _localAuth = LocalAuthentication();
  var hasFingerPrintLock = false.obs;
  var hasFaceLock = false.obs;
  var isUserAuthenticated = false.obs;

  // Image Picker
  late PickedFile _image;
  final picker = ImagePicker();

  // Geolocation
  Position? position;
  double? latitude;
  double? longitude;

  void _getAllBiometrics() async {
    // Check whether there is local authentication available on this device or not
    final isAvailable = await _localAuth.canCheckBiometrics;
    final isDeviceSupported = await _localAuth.isDeviceSupported();
    bool hasLocalAuthentication = await _localAuth.canCheckBiometrics;
    if (isAvailable && isDeviceSupported) {
      if (hasLocalAuthentication) {
        List<BiometricType> availableBiometrics =
            await _localAuth.getAvailableBiometrics();
        hasFaceLock.value = availableBiometrics.contains(BiometricType.face);
        hasFingerPrintLock.value =
            availableBiometrics.contains(BiometricType.fingerprint);
      } else {
        showSnackBar(
            title: "Error",
            message: 'Local Authentication not available',
            backgroundColor: Colors.red);
      }
    } else {
      showSnackBar(
          title: "Error",
          message: 'Local Authentication not available',
          backgroundColor: Colors.red);
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

  Future localAuth() async {
    showLoading();
    position = await determinePosition();
    hideLoading();
    latitude = position?.latitude;
    longitude = position?.longitude;
    showLoading();
    bool isVerified = await authenticateUser();
    hideLoading();
    if (isVerified) {
      showLoading();
      await getImage();
      hideLoading();
    }
  }

  Future<Position> determinePosition() async {
    showLoading();
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Toast.show('Location services are disabled.', Get.context);
      hideLoading();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Toast.show('Location permissions are denied', Get.context);
        hideLoading();
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    var pos = await Geolocator.getCurrentPosition();
    hideLoading();
    return pos;
  }

  Future<bool> authenticateUser() async {
    try {
      const androidMessage = const AndroidAuthMessages(
        cancelButton: 'Cancel',
        goToSettingsButton: 'settings',
        goToSettingsDescription: 'Please set up your Fingerprint/Face.',
        biometricHint: 'Verify your identity',
      );
      isUserAuthenticated.value = await _localAuth.authenticate(
        localizedReason: 'Authenticate Yourself',
        biometricOnly: false,
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: androidMessage,
      );
      if (isUserAuthenticated.value) {
        return true;
        // showSnackBar(
        //     title: "Success",
        //     message: "You are authenticated",
        //     backgroundColor: Colors.green);
      } else {
        showSnackBar(
            title: "Error",
            message: "Authentication Cancelled",
            backgroundColor: Colors.red);
        return false;
      }
    } on Exception catch (e) {
      print(e);
      showSnackBar(
          title: "Error", message: e.toString(), backgroundColor: Colors.red);
      return false;
    }
  }

  Future getImage() async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      print('image picked');
      if (pickedFile != null) {
        _image = pickedFile;
        print(_image.path);
        var res = await uploadImage(_image.path,
            'https://pixel.solstium.net/api/v1/employee/upload_sign');
        if (res?.isSuccess ?? false) {
          print('Image Uploaded');
        }
      } else {
        print('No image selected.');
      }
    } catch (error) {
      print('Error $error');
    }
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
    _getAllBiometrics();
    position = await determinePosition();
    latitude = position?.latitude;
    longitude = position?.longitude;
    print(latitude);
    print(longitude);
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
        print('Account not active');
        // TODO: Show account inactive toast
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
    // return FeedbackScreen();
    //temp
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
    // if (AppController.to.showLoading.) {
    return Obx(() {
      if (showLoading.value > 0) {
        return ModalProgressHUD(inAsyncCall: true, child: Container());
      } else {
        return Container();
      }
    });
    // }
    // return Container();
  }
}
