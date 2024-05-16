import '../api/api_service.dart';
import 'abstract_class.dart';

class MServiceTypeResponse implements Codable {
  String? status;
  String? message;
  late List<MServiceType> data;

  MServiceTypeResponse fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new MServiceType.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    // if (this.data != null) {
    //   data['data'] = this.data.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  bool get isValid => data.length > 0;
}

class MServiceType implements ADropDown {
  late int id;
  late String name;
  int? status;
  String? createdAt;
  String? updatedAt;

  MServiceType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  String get aId => id.toString();

  String get aName => name;
  
  @override
  // TODO: implement aBillingAddress
  String get aBillingAddress => throw UnimplementedError();
  
  @override
  // TODO: implement aEmail
  String get aEmail => throw UnimplementedError();
  
  @override
  // TODO: implement aPhoneNo
  String get aPhoneNo => throw UnimplementedError();
}
