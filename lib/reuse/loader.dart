import 'package:eagle_pixels/controller/app_controller.dart';

showLoading() {
  AppController.to.showLoading.value++;
  if (AppController.to.showLoading.value <= 0) {
    AppController.to.showLoading.value = 1;
  }
  // print('loader show ${AppController.to.showLoading.value}');
  // AppController.to.updateLoaderView();
  AppController.to.update();
}

hideLoading() {
  AppController.to.showLoading.value--;
  if (AppController.to.showLoading.value < 0) {
    AppController.to.showLoading.value = 0;
  }
  // print('loader hide ${AppController.to.showLoading.value}');
  // AppController.to.updateLoaderView();
  AppController.to.update();
}
