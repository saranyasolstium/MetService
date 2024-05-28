import '../api/api_service.dart';
import 'abstract_class.dart';

class MAvailableEngineerResponse implements Codable {
  String? status;
  String? message;
  late List<MAvailableEngineer> data;

  MAvailableEngineerResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List<MAvailableEngineer>.from(
        (json['data'] ?? []).map((x) => MAvailableEngineer.fromJson(x)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    data['data'] = this.data.map((x) => x.toJson()).toList();
    return data;
  }

  bool get isValid => data.isNotEmpty;

  @override
  Codable fromJson(Map<String, dynamic> json) {
    return MAvailableEngineerResponse.fromJson(json);
  }
}

class MAvailableEngineer {
  late int allot;
  String? email;
  String? designation;
  bool isChecked = false;

  MAvailableEngineer.fromJson(Map<String, dynamic> json) {
    allot = json['allot'];
    email = json['email'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['allot'] = allot;
    data['email'] = email;
    data['designation'] = designation;
    return data;
  }
}
