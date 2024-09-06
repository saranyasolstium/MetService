import '../api/api_service.dart';
import 'abstract_class.dart';

class MSubServiceResponse implements Codable {
  String? status;
  String? message;
  late List<MSubService> data;

  MSubServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List<MSubService>.from((json['data'] ?? []).map((x) => MSubService.fromJson(x)));
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
    return MSubServiceResponse.fromJson(json);
  }
}

class MSubService {
  late int id;
  int? service;
  String? serviceName;

  MSubService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    service=json['service'];
    serviceName = json['subservice_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service']=service;
    data['subservice_name'] = serviceName ?? "";
    return data;
  }
}


