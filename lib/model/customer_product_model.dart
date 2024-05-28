import '../api/api_service.dart';
import 'abstract_class.dart';

class MCustomerProductResponse implements Codable {
  String? status;
  String? message;
  late List<MCustomerProduct> data;

  MCustomerProductResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = List<MCustomerProduct>.from(
        (json['data'] ?? []).map((x) => MCustomerProduct.fromJson(x)));
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
    return MCustomerProductResponse.fromJson(json);
  }
}

class MCustomerProduct {
  late int id;
  int? type;
  String? name;
  String? sku;
  String? short_description;
  String? description;

  MCustomerProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['type'] = type;
    data['name'] = name;
    return data;
  }
}
