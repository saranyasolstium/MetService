import '../api/api_service.dart';
import 'abstract_class.dart';

class MCustomerList implements Codable {
  String? status;
  String? message;
  late List<MCustomerItem> data;

  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = <MCustomerItem>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new MCustomerItem.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data.length > 0) {
      // data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isValid => data.length > 0;
}

class MCustomerItem implements ADropDown {
  // int? id;
  late String customerId;
  late String name;
  // String? companyName;
  // String? firstName;
  // String? lastName;
  // String? userName;
  // String? email;
  // String? phoneNumber;
  // String? billingAddress;
  // String? shippingAddress;
  // String? createdAt;
  // String? updatedAt;

  MCustomerItem.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    customerId = json['customer_id'].toString();
    name = json['name'];
    // companyName = json['company_name'];
    // firstName = json['first_name'];
    // lastName = json['last_name'];
    // userName = json['user_name'];
    // email = json['email'];
    // phoneNumber = json['phone_number'];
    // billingAddress = json['billing_address'];
    // shippingAddress = json['shipping_address'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['customer_id'] = this.customerId;
  //   data['name'] = this.name;
  //   data['company_name'] = this.companyName;
  //   data['first_name'] = this.firstName;
  //   data['last_name'] = this.lastName;
  //   data['user_name'] = this.userName;
  //   data['email'] = this.email;
  //   data['phone_number'] = this.phoneNumber;
  //   data['billing_address'] = this.billingAddress;
  //   data['shipping_address'] = this.shippingAddress;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }

  String get aId => customerId.toString();

  String get aName => name;
}
