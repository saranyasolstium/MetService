import 'package:get_storage/get_storage.dart';

extension AppStorage on GetStorage {
  String get token {
    return this.read("token") ?? "";
  }
}
