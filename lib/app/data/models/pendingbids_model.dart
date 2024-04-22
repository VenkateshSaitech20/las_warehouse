// To parse this JSON data, do
//
//     final pendingBidsModel = pendingBidsModelFromJson(jsonString);

import 'dart:convert';

PendingBidsModel pendingBidsModelFromJson(String str) => PendingBidsModel.fromJson(json.decode(str));

String pendingBidsModelToJson(PendingBidsModel data) => json.encode(data.toJson());

class PendingBidsModel {
    bool? result;
    List<PendingBidsData>? message;

    PendingBidsModel({
        this.result,
        this.message,
    });

    factory PendingBidsModel.fromJson(Map<String, dynamic> json) => PendingBidsModel(
        result: json["result"],
        message: json["message"] == null ? [] : List<PendingBidsData>.from(json["message"]!.map((x) => PendingBidsData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null ? [] : List<dynamic>.from(message!.map((x) => x.toJson())),
    };
}

class PendingBidsData {
    String? id;
    String? reqId;
    String? requirementNo;
    String? cusId;
    Customer? customer;
    String? vendorId;
    Customer? vendor;
    String? bookingType;
    String? city;
    String? preferredLocation;
    String? fromDateTime;
    String? toDateTime;
    String? materialType;
    String? bidPrice;
    String? finalPrice;
    String? reqSqft;
    String? availableWarehouseType;
    String? paymentType;
    String? termsConditions;
    DateTime? biddingOn;
    String? paymentStatus;
    String? finalPriceConfirmed;
    String? isAccepted;
    String? isInvoiced;
    String? isCancelled;
    int? v;

    PendingBidsData({
        this.id,
        this.reqId,
        this.requirementNo,
        this.cusId,
        this.customer,
        this.vendorId,
        this.vendor,
        this.bookingType,
        this.fromDateTime,
        this.city,
        this.preferredLocation,
        this.toDateTime,
        this.materialType,
        this.bidPrice,
        this.finalPrice,
        this.reqSqft,
        this.availableWarehouseType,
        this.paymentType,
        this.termsConditions,
        this.biddingOn,
        this.paymentStatus,
        this.finalPriceConfirmed,
        this.isAccepted,
        this.isInvoiced,
        this.isCancelled,
        this.v,
    });

    factory PendingBidsData.fromJson(Map<String, dynamic> json) => PendingBidsData(
        id: json["_id"],
        reqId: json["reqId"],
        requirementNo: json["requirementNo"],
        cusId: json["cusId"],
        customer: json["customer"] == null ? null : Customer.fromJson(json["customer"]),
        vendorId: json["vendorId"],
        vendor: json["vendor"] == null ? null : Customer.fromJson(json["vendor"]),
        bookingType: json["bookingType"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        materialType: json["materialType"],
        bidPrice: json["bidPrice"],
        finalPrice: json["finalPrice"],
        reqSqft: json["reqSqft"],
        availableWarehouseType: json["availableWarehouseType"],
        paymentType: json["paymentType"],
        termsConditions: json["termsConditions"],
        biddingOn: json["biddingOn"] == null ? null : DateTime.parse(json["biddingOn"]),
        paymentStatus: json["paymentStatus"],
        finalPriceConfirmed: json["finalPriceConfirmed"],
        isAccepted: json["isAccepted"],
        isInvoiced: json["isInvoiced"],
        isCancelled: json["isCancelled"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "reqId": reqId,
        "requirementNo": requirementNo,
        "cusId": cusId,
        "customer": customer?.toJson(),
        "vendorId": vendorId,
        "vendor": vendor?.toJson(),
        "bookingType": bookingType,
        "city": city,
        "preferredLocation": preferredLocation,
        "fromDateTime": fromDateTime,
        "toDateTime": toDateTime,
        "materialType": materialType,
        "bidPrice": bidPrice,
        "finalPrice": finalPrice,
        "reqSqft": reqSqft,
        "availableWarehouseType": availableWarehouseType,
        "paymentType": paymentType,
        "termsConditions": termsConditions,
        "biddingOn": biddingOn?.toIso8601String(),
        "paymentStatus": paymentStatus,
        "finalPriceConfirmed": finalPriceConfirmed,
        "isAccepted": isAccepted,
        "isInvoiced": isInvoiced,
        "isCancelled": isCancelled,
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
    String? vendorName;

    Customer({
        this.cusName,
        this.email,
        this.logo,
        this.phone,
        this.address1,
        this.address2,
        this.vendorName,
    });

    factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        cusName: json["cusName"],
        email: json["email"],
        logo: json["logo"],
        phone: json["phone"],
        address1: json["address1"],
        address2: json["address2"],
        vendorName: json["vendorName"],
    );

    Map<String, dynamic> toJson() => {
        "cusName": cusName,
        "email": email,
        "logo": logo,
        "phone": phone,
        "address1": address1,
        "address2": address2,
        "vendorName": vendorName,
    };
}
