import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/api/urls.dart';
import 'package:eagle_pixels/dynamic_font.dart';
import 'package:eagle_pixels/reuse/storage.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

import 'package:eagle_pixels/model/profile_model.dart';

enum LoginStatus { logged, logout, loading }

class AppController extends GetxController {
  bool get isEngineer {
    return _user.value.isEngineer; //temp
  }

  static AppController get to => Get.find<AppController>();
  // static var profile = MProfile();
  var loginStatus = LoginStatus.loading.obs;
  var showLoading = 0.obs;
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

  Widget defaultLoaderView() {
    return GetBuilder<AppController>(
      builder: (con) {
        return ModalProgressHUD(
            opacity: 0.3, inAsyncCall: showLoading > 0, child: Container());
      },
    );
  }
}

// var storedKey;
// updateLoaderView() {
//   if (showLoading > 0) {
//     print('Show requested');
//     showDialog(
//       context: Get.context,
//       builder: (_) => Center(
//         key: Key('defaultLoader'),
//         child: CircularProgressIndicator(),
//       ),
//     );
//     storedKey = navigator.widget.key;
//   } else {
//     Future.delayed(Duration(seconds: 10), () {
//       print('hide requested');
//       print('Got Key - ${navigator.context.widget.key} - $storedKey');
//       Navigator.of(Get.context).pop();
//     });
//   }
// }
