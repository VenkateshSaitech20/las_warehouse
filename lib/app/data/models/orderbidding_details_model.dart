// To parse this JSON data, do
//
//     final orderBiddingDetailModel = orderBiddingDetailModelFromJson(jsonString);

import 'dart:convert';

OrderBiddingDetailModel orderBiddingDetailModelFromJson(String str) =>
    OrderBiddingDetailModel.fromJson(json.decode(str));

String orderBiddingDetailModelToJson(OrderBiddingDetailModel data) =>
    json.encode(data.toJson());

class OrderBiddingDetailModel {
  bool? result;
  OrderBiddingDetailsData? message;

  OrderBiddingDetailModel({
    this.result,
    this.message,
  });

  factory OrderBiddingDetailModel.fromJson(Map<String, dynamic> json) =>
      OrderBiddingDetailModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : OrderBiddingDetailsData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class OrderBiddingDetailsData {
  String? id;
  String? cusId;
  Customer? customer;
  String? requirementType;
  String? requirementNo;
  String? bookingType;
  String? recurringType;
  String? weeklyType;
  String? monthlyType;
  String? monthlyDay;
  String? recurringDates;
  String? city;
  String? preferredLocation;
  String? fromDateTime;
  String? toDateTime;
  String? materialTypeData;
  double? totalWeight;
  String? weightType;
  String? totalQuantity;
  String? reqSqft;
  String? itemDescription;
  String? consignmentLoadingType;
  String? consignmentType;
  String? availableWarehouseType;
  DateTime? createdAt;
  int? v;

  OrderBiddingDetailsData({
    this.id,
    this.cusId,
    this.customer,
    this.requirementType,
    this.requirementNo,
    this.bookingType,
    this.recurringType,
    this.weeklyType,
    this.monthlyType,
    this.monthlyDay,
    this.recurringDates,
    this.city,
    this.preferredLocation,
    this.fromDateTime,
    this.toDateTime,
    this.materialTypeData,
    this.totalWeight,
    this.weightType,
    this.totalQuantity,
    this.reqSqft,
    this.itemDescription,
    this.consignmentLoadingType,
    this.consignmentType,
    this.availableWarehouseType,
    this.createdAt,
    this.v,
  });

  factory OrderBiddingDetailsData.fromJson(Map<String, dynamic> json) =>
      OrderBiddingDetailsData(
        id: json["_id"],
        cusId: json["cusId"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        requirementType: json["requirementType"],
        requirementNo: json["requirementNo"],
        bookingType: json["bookingType"],
        recurringType: json["recurringType"],
        weeklyType: json["weeklyType"],
        monthlyType: json["monthlyType"],
        monthlyDay: json["monthlyDay"],
        recurringDates: json["recurringDates"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        materialTypeData: json["materialTypeData"],
        totalWeight: double.parse(json["totalWeight"].toString()),
        weightType: json["weightType"],
        totalQuantity: json["totalQuantity"].toString(),
        reqSqft: json["reqSqft"],
        itemDescription: json["itemDescription"],
        consignmentLoadingType: json["consignmentLoadingType"],
        consignmentType: json["consignmentType"],
        availableWarehouseType: json["availableWarehouseType"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "cusId": cusId,
        "customer": customer?.toJson(),
        "requirementType": requirementType,
        "requirementNo": requirementNo,
        "bookingType": bookingType,
        "recurringType": recurringType,
        "weeklyType": weeklyType,
        "monthlyType": monthlyType,
        "monthlyDay": monthlyDay,
        "recurringDates": recurringDates,
        "city": city,
        "preferredLocation": preferredLocation,
        "fromDateTime": fromDateTime,
        "toDateTime": toDateTime,
        "materialTypeData": materialTypeData,
        "totalWeight": totalWeight,
        "weightType": weightType,
        "totalQuantity": totalQuantity,
        "reqSqft": reqSqft,
        "itemDescription": itemDescription,
        "consignmentLoadingType": consignmentLoadingType,
        "consignmentType": consignmentType,
        "availableWarehouseType": availableWarehouseType,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}

class Customer {
  String? cusName;
  String? email;
  String? logo;
  String? phone;
  String? address1;
  String? address2;

  Customer({
    this.cusName,
    this.email,
    this.logo,
    this.phone,
    this.address1,
    this.address2,
  });

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        cusName: json["cusName"],
        email: json["email"],
        logo: json["logo"],
        phone: json["phone"],
        address1: json["address1"],
        address2: json["address2"],
      );

  Map<String, dynamic> toJson() => {
        "cusName": cusName,
        "email": email,
        "logo": logo,
        "phone": phone,
        "address1": address1,
        "address2": address2,
      };
}

class PackagingType {
  String? packagingType;
  String? icon;

  PackagingType({
    this.packagingType,
    this.icon,
  });

  factory PackagingType.fromJson(Map<String, dynamic> json) => PackagingType(
        packagingType: json["packagingType"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "packagingType": packagingType,
        "icon": icon,
      };
}

class MaterialTypeData {
  String? materialType;
  double? weight;
  String? weightType;
  String? quantity;
  double? length;
  double? width;
  double? height;
  String? uom;
  String? packagingType;

  MaterialTypeData({
    this.materialType,
    this.weight,
    this.weightType,
    this.quantity,
    this.length,
    this.width,
    this.height,
    this.uom,
    this.packagingType,
  });

  factory MaterialTypeData.fromJson(Map<String, dynamic> json) =>
      MaterialTypeData(
        materialType: json["materialType"],
        weight: double.parse(json["weight"].toString()),
        weightType: json["weightType"],
        quantity: json["quantity"].toString(),
        length: double.parse(json["length"].toString()),
        width: double.parse(json["width"].toString()),
        height: double.parse(json["height"].toString()),
        uom: json["uom"],
        packagingType: json["packagingType"],
      );

  Map<String, dynamic> toJson() => {
        "materialType": materialType,
        "weight": weight,
        "weightType": weightType,
        "quantity": quantity,
        "length": length,
        "width": width,
        "height": height,
        "uom": uom,
        "packagingType": packagingType,
      };
}
