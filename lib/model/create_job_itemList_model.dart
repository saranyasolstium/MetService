import '../api/api_service.dart';
import 'abstract_class.dart';
import 'abstract_class.dart';

class MCustomerProductList implements Codable {
  String? status;
  String? message;
  late List<MCustomerProductItem> data;

  MCustomerProductList.init() {
    data = [];
  }
  // MCustomerProductList({this.status, this.message, this.data});

  MCustomerProductList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = [];
    if (json['data'] != null) {
      json['data'].forEach((v) {
        data.add(new MCustomerProductItem.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data.length > 0) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }

  bool get isValid => data.length > 0;
}

class MCustomerProductItem implements ADropDown, AServiceItem {
  int? id;
  late int productId;
  late String productName;
  String? productImage;
  String? sku;
  String? serialNumber;
  String? companyName;
  String? customerName;
  String? customerImage;
  String? siteName;
  String? siteAddress;
  String? siteAddress2;
  String? siteCity;
  String? siteState;
  String? siteZipcode;
  String? subsiteName;
  String? siteMap;
  String? warrantyEnding;
  String? warrentyPeriod;

  MCustomerProductItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productId = json['product_id'];
    productName = json['product_name'];
    productImage = json['product_image'];
    sku = json['sku'];
    serialNumber = json['serial_number'];
    companyName = json['company_name'];
    customerName = json['customer_name'];
    customerImage = json['customer_image'];
    siteName = json['site_name'];
    siteAddress = json['site_address'];
    siteAddress2 = json['site_address2'];
    siteCity = json['site_city'];
    siteState = json['site_state'];
    siteZipcode = json['site_zipcode'];
    subsiteName = json['subsite_name'];
    siteMap = json['site_map'];
    warrantyEnding = json['warranty_ending'];
    warrentyPeriod = json['warrenty_period'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['id'] = this.id;
    data['product_id'] = this.productId;
    data['product_name'] = this.productName;
    // data['product_image'] = this.productImage;
    // data['sku'] = this.sku;
    // data['serial_number'] = this.serialNumber;
    // data['company_name'] = this.companyName;
    // data['customer_name'] = this.customerName;
    // data['customer_image'] = this.customerImage;
    // data['site_name'] = this.siteName;
    // data['site_address'] = this.siteAddress;
    // data['site_address2'] = this.siteAddress2;
    // data['site_city'] = this.siteCity;
    // data['site_state'] = this.siteState;
    // data['site_zipcode'] = this.siteZipcode;
    // data['subsite_name'] = this.subsiteName;
    // data['site_map'] = this.siteMap;
    // data['warranty_ending'] = this.warrantyEnding;
    // data['warrenty_period'] = this.warrentyPeriod;
    return data;
  }

  String get aId => productId.toString();
  String get aName => productName;
  String? get aCctvID => sku;
  String? get aCustomerImage => customerImage;
  String? get aCustomerName => customerName;
  String? get aEndDay => ''; //temp
  double? get aLat => 0;
  double? get aLong => 0;
  String? get aProdouctName => productName;
  String? get aProductImage => productImage;
  String? get aPurchaseDate => ''; //temp
  String? get aRequestNo => '';
  String? get aServiceID => productId.toString();
  String? get aServiceType => ''; //temp
  String? get aSiteID => ''; //temp
  String? get aStartDay => ''; //temp
}
