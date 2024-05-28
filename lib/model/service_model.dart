import '../api/api_service.dart';
import 'abstract_class.dart';

class MServiceResponse implements Codable {
  String? status;
  String? message;
  late List<MService> data;

  MServiceResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List<MService>.from((json['data'] ?? []).map((x) => MService.fromJson(x)));
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
    return MServiceResponse.fromJson(json);
  }
}

class MService {
  late int id;
  String? serviceName;

  MService.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    serviceName = json['service_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['service_name'] = serviceName;
    return data;
  }
}


