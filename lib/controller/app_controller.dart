import 'package:eagle_pixels/reuse/storage.dart';
import 'package:eagle_pixels/screen/login_screen.dart';
import 'package:eagle_pixels/screen/nav_bottom.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AppController extends GetxController {
  static AppController get to => Get.find<AppController>();
  var isLogged = false.obs;
  var showLoading = 0.obs;
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    // Future.delayed(Duration(seconds: 2), () => ever(showLoading, showLoader()));
    // ever(AppController.to.isLogged, AppController.to.setupUI());
    super.onInit();

    Future.delayed(Duration(seconds: 2), () {
      isLogged.value = (storage.token.isNotEmpty);
      print('token ${storage.token}');
    });
  }

  Widget rootView() {
    if (isLogged.value) {
      return Nav();
    } else {
      return LoginScreen();
    }
  }

  Widget defaultLoaderView() {
    return GetBuilder<AppController>(
      builder: (con) {
        if (showLoading > 0) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container();
        }
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
