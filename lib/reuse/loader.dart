import 'package:eagle_pixels/controller/app_controller.dart';

showLoading() {
  AppController.to.showLoading++;
  // AppController.to.updateLoaderView();
  AppController.to.update();
}

hideLoading() {
  AppController.to.showLoading--;
  // AppController.to.updateLoaderView();
  AppController.to.update();
}
