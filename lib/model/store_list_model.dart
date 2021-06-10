import 'package:eagle_pixels/api/api_service.dart';
import 'package:eagle_pixels/model/abstract_class.dart';

class MCustomerSite implements Codable {
  String? status;
  String? message;
  late List<MCustomerSiteItem> data;

  MCustomerSite fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = <MCustomerSiteItem>[];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new MCustomerSiteItem.fromJson(v));
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

class MCustomerSiteItem implements ADropDown {
  // int id;
  // int clientId;
  // Null location;
  // Null sublocation;
  // String name;
  // String address1;
  // Null address2;
  // String country;
  // String state;
  // String city;
  // String zipCode;
  // Null latitude;
  // Null longitude;
  // String status;
  // String createdAt;
  // String updatedAt;
  late int siteID;
  late String siteName;

  MCustomerSiteItem.fromJson(Map<String, dynamic> json) {
    // id = json['id'];
    // clientId = json['client_id'];
    // location = json['location'];
    // sublocation = json['sublocation'];
    // name = json['name'];
    // address1 = json['address_1'];
    // address2 = json['address_2'];
    // country = json['country'];
    // state = json['state'];
    // city = json['city'];
    // zipCode = json['zip_code'];
    // latitude = json['latitude'];
    // longitude = json['longitude'];
    // status = json['status'];
    // createdAt = json['created_at'];
    // updatedAt = json['updated_at'];
    siteID = json['SiteID'];
    siteName = json['SiteName'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['client_id'] = this.clientId;
  //   data['location'] = this.location;
  //   data['sublocation'] = this.sublocation;
  //   data['name'] = this.name;
  //   data['address_1'] = this.address1;
  //   data['address_2'] = this.address2;
  //   data['country'] = this.country;
  //   data['state'] = this.state;
  //   data['city'] = this.city;
  //   data['zip_code'] = this.zipCode;
  //   data['latitude'] = this.latitude;
  //   data['longitude'] = this.longitude;
  //   data['status'] = this.status;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['SiteID'] = this.siteID;
  //   data['SiteName'] = this.siteName;
  //   return data;
  // }

  String get aId => siteID.toString();

  String get aName => siteName;
}
