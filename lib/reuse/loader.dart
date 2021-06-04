import 'package:eagle_pixels/controller/app_controller.dart';

showLoading({int? value}) {
  if (value != null) {
    AppController.to.showLoading.value = value;
  } else {
    AppController.to.showLoading.value++;
    if (AppController.to.showLoading.value <= 0) {
      AppController.to.showLoading.value = 1;
    }
  }
  AppController.to.update();
}

hideLoading({int? value}) {
  if (value != null) {
    AppController.to.showLoading.value = value;
  } else {
    AppController.to.showLoading.value--;
    if (AppController.to.showLoading.value < 0) {
      AppController.to.showLoading.value = 0;
    }
  }
  AppController.to.update();
}
