// To parse this JSON data, do
//
//     final wbsRequirementModel = wbsRequirementModelFromJson(jsonString);

import 'dart:convert';

WbsRequirementModel wbsRequirementModelFromJson(String str) => WbsRequirementModel.fromJson(json.decode(str));

String wbsRequirementModelToJson(WbsRequirementModel data) => json.encode(data.toJson());

class WbsRequirementModel {
    bool? result;
    List<WbsRequirement>? message; 

    WbsRequirementModel({
        this.result,
        this.message,
    });

    factory WbsRequirementModel.fromJson(Map<String, dynamic> json) => WbsRequirementModel(
        result: json["result"],
        message: json["message"] == null ? [] : List<WbsRequirement>.from(json["message"]!.map((x) => WbsRequirement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class WbsRequirement {
    String? id;
    String? cusId;
    Customer? customer;
    String? requirementType;
    String? requirementNo;
    String? bookingType;
    String? city;
    String? preferredLocation;
    String? fromDateTime;
    String? toDateTime;
    String? materialType;
    List<PackagingType>? packagingType;
    int? length;
    int? width;
    int? height;
    String? uom;
    int? weight;
    String? weightType;
    String? quantity;
    String? reqSqft;
    String? itemDescription;
    String? consignmentLoadingType;
    String? consignmentType;
    String? availableWarehouseType;
    DateTime? createdAt;
    int? v;

    WbsRequirement({
        this.id,
        this.cusId,
        this.customer,
        this.requirementType,
        this.requirementNo,
        this.bookingType,
        this.city,
        this.preferredLocation,
        this.fromDateTime,
        this.toDateTime,
        this.materialType,
        this.packagingType,
        this.length,
        this.width,
        this.height,
        this.uom,
        this.weight,
        this.weightType,
        this.quantity,
        this.reqSqft,
        this.itemDescription,
        this.consignmentLoadingType,
        this.consignmentType,
        this.availableWarehouseType,
        this.createdAt,
        this.v,
    });

    factory WbsRequirement.fromJson(Map<String, dynamic> json) => WbsRequirement(
        id: json["_id"],
        cusId: json["cusId"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        requirementType: json["requirementType"],
        requirementNo: json["requirementNo"],
        bookingType: json["bookingType"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        materialType: json["materialType"],
        packagingType: json["packagingType"] == null ? [] : List<PackagingType>.from(json["packagingType"]!.map((x) => PackagingType.fromJson(x))),
        length: json["length"],
        width: json["width"],
        height: json["height"],
        uom: json["uom"],
        weight: json["weight"],
        weightType: json["weightType"],
        quantity: json["quantity"],
        reqSqft: json["reqSqft"],
        itemDescription: json["itemDescription"],
        consignmentLoadingType: json["consignmentLoadingType"],
        consignmentType: json["consignmentType"],
        availableWarehouseType: json["availableWarehouseType"],
        createdAt: json["createdAt"] == null ? null : DateTime.parse(json["createdAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "cusId": cusId,
        "customer": customer?.toJson(),
        "requirementType": requirementType,
        "requirementNo": requirementNo,
        "bookingType": bookingType,
        "city": city,
        "preferredLocation": preferredLocation,
        "fromDateTime": fromDateTime,
        "toDateTime": toDateTime,
        "materialType": materialType,
        "packagingType": packagingType == null ? [] : List<dynamic>.from(packagingType!.map((x) => x.toJson())),
        "length": length,
        "width": width,
        "height": height,
        "uom": uom,
        "weight": weight,
        "weightType": weightType,
        "quantity": quantity,
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
