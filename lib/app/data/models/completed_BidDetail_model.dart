// To parse this JSON data, do
//
//     final completedBidDetailModel = completedBidDetailModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

CompletedBidDetailModel completedBidDetailModelFromJson(String str) =>
    CompletedBidDetailModel.fromJson(json.decode(str));

String completedBidDetailModelToJson(CompletedBidDetailModel data) =>
    json.encode(data.toJson());

class CompletedBidDetailModel {
  bool? result;
  CompletedBidDetailData? message;

  CompletedBidDetailModel({
    this.result,
    this.message,
  });

  factory CompletedBidDetailModel.fromJson(Map<String, dynamic> json) =>
      CompletedBidDetailModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : CompletedBidDetailData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class CompletedBidDetailData {
  String? id;
  String? reqId;
  String? warehouseId;
  Warehouse? warehouse;
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
  String? materialTypeData;
  String? bidPrice;
  String? finalPrice;
  String? reqSqft;
  String? availableWarehouseType;
  String? paymentType;
  String? fullyPaid;
  String? advancePercent;
  String? advancePaid;
  String? termsConditions;
  DateTime? biddingOn;
  String? paymentStatus;
  String? finalPriceConfirmed;
  String? isCustomerAccepted;
  String? isAccepted;
  String? isInvoiced;
  String? invoiceUploaded;
  String? isCancelled;
  String? createdBy;
  String? isCheckout;
  int? v;
  DateTime? acceptedOn;
  DateTime? checkoutOn;
  DateTime? customerAcceptedOn;
  String? itemDescription;
  String? consignmentLoadingType;
  String? consignmentType;
  int? totalWeight;
  String? weightType;
  String? totalQuantity;
  String? advanceToPay;
  String? amountInWords;
  String? advancePrice;
  String? price;
  String? advanceResponse;
  String? finalPriceConfirmedOn;
  String? advancePaidOn;

  CompletedBidDetailData({
    this.id,
    this.reqId,
    this.warehouseId,
    this.warehouse,
    this.requirementNo,
    this.cusId,
    this.customer,
    this.vendorId,
    this.vendor,
    this.bookingType,
    this.city,
    this.preferredLocation,
    this.fromDateTime,
    this.toDateTime,
    this.materialTypeData,
    this.bidPrice,
    this.finalPrice,
    this.reqSqft,
    this.availableWarehouseType,
    this.paymentType,
    this.fullyPaid,
    this.advancePercent,
    this.advancePaid,
    this.termsConditions,
    this.biddingOn,
    this.paymentStatus,
    this.finalPriceConfirmed,
    this.isCustomerAccepted,
    this.isAccepted,
    this.isInvoiced,
    this.invoiceUploaded,
    this.isCancelled,
    this.createdBy,
    this.isCheckout,
    this.v,
    this.acceptedOn,
    this.checkoutOn,
    this.customerAcceptedOn,
    this.itemDescription,
    this.consignmentLoadingType,
    this.consignmentType,
    this.totalWeight,
    this.weightType,
    this.totalQuantity,
    this.advanceToPay,
    this.amountInWords,
    this.price,
    this.advancePrice,
    this.advanceResponse,
    this.finalPriceConfirmedOn,
    this.advancePaidOn,
  });

  factory CompletedBidDetailData.fromJson(Map<String, dynamic> json) =>
      CompletedBidDetailData(
        id: json["_id"],
        reqId: json["reqId"],
        warehouseId: json["warehouseId"],
        warehouse: json["warehouse"] == null
            ? null
            : Warehouse.fromJson(json["warehouse"]),
        requirementNo: json["requirementNo"],
        cusId: json["cusId"],
        customer: json["customer"] == null
            ? null
            : Customer.fromJson(json["customer"]),
        vendorId: json["vendorId"],
        vendor:
            json["vendor"] == null ? null : Customer.fromJson(json["vendor"]),
        bookingType: json["bookingType"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        materialTypeData: json["materialTypeData"],
        bidPrice: json["bidPrice"],
        finalPrice: json["finalPrice"],
        reqSqft: json["reqSqft"],
        availableWarehouseType: json["availableWarehouseType"],
        paymentType: json["paymentType"],
        fullyPaid: json["fullyPaid"],
        advancePercent: json["advancePercent"],
        advancePaid: json["advancePaid"],
        termsConditions: json["termsConditions"],
        biddingOn: json["biddingOn"] == null
            ? null
            : DateTime.parse(json["biddingOn"]),
        paymentStatus: json["paymentStatus"],
        finalPriceConfirmed: json["finalPriceConfirmed"],
        isCustomerAccepted: json["isCustomerAccepted"],
        isAccepted: json["isAccepted"],
        isInvoiced: json["isInvoiced"],
        invoiceUploaded: json["invoiceUploaded"],
        isCancelled: json["isCancelled"],
        createdBy: json["createdBy"],
        isCheckout: json["isCheckout"],
        v: json["__v"],
        acceptedOn: json["acceptedOn"] == null
            ? null
            : DateTime.parse(json["acceptedOn"]),
        checkoutOn: json["checkoutOn"] == null
            ? null
            : DateTime.parse(json["checkoutOn"]),
        customerAcceptedOn: json["customerAcceptedOn"] == null
            ? null
            : DateTime.parse(json["customerAcceptedOn"]),
        itemDescription: json["itemDescription"],
        consignmentLoadingType: json["consignmentLoadingType"],
        consignmentType: json["consignmentType"],
        totalWeight: json["totalWeight"],
        weightType: json["weightType"],
        totalQuantity: json["totalQuantity"],
        advanceToPay: json["advanceToPay"],
        amountInWords: json["amountInWords"],
        price: json["price"].toString(),
        advancePrice: json["advancePrice"],
        advanceResponse: json["advanceResponse"],
        finalPriceConfirmedOn: json["finalPriceConfirmedOn"].toString(),
        advancePaidOn: json["advancePaidOn"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "reqId": reqId,
        "warehouseId": warehouseId,
        "warehouse": warehouse?.toJson(),
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
        "materialTypeData": materialTypeData,
        "bidPrice": bidPrice,
        "finalPrice": finalPrice,
        "reqSqft": reqSqft,
        "availableWarehouseType": availableWarehouseType,
        "paymentType": paymentType,
        "fullyPaid": fullyPaid,
        "advancePercent": advancePercent,
        "advancePaid": advancePaid,
        "termsConditions": termsConditions,
        "biddingOn": biddingOn?.toIso8601String(),
        "paymentStatus": paymentStatus,
        "finalPriceConfirmed": finalPriceConfirmed,
        "isCustomerAccepted": isCustomerAccepted,
        "isAccepted": isAccepted,
        "isInvoiced": isInvoiced,
        "invoiceUploaded": invoiceUploaded,
        "isCancelled": isCancelled,
        "createdBy": createdBy,
        "isCheckout": isCheckout,
        "__v": v,
        "acceptedOn": acceptedOn?.toIso8601String(),
        "checkoutOn": checkoutOn?.toIso8601String(),
        "customerAcceptedOn": customerAcceptedOn?.toIso8601String(),
        "itemDescription": itemDescription,
        "consignmentLoadingType": consignmentLoadingType,
        "consignmentType": consignmentType,
        "totalWeight": totalWeight,
        "weightType": weightType,
        "totalQuantity": totalQuantity,
        "advanceToPay": advanceToPay,
        "amountInWords": amountInWords,
        "advancePrice": advancePrice,
        "price": price,
        "advanceResponse": advanceResponse,
        "finalPriceConfirmedOn": finalPriceConfirmedOn,
        "advancePaidOn": advancePaidOn,
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

class Warehouse {
  String? warehouseName;
  String? warehouseType;

  Warehouse({
    this.warehouseName,
    this.warehouseType,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        warehouseName: json["warehouseName"],
        warehouseType: json["warehouseType"],
      );

  Map<String, dynamic> toJson() => {
        "warehouseName": warehouseName,
        "warehouseType": warehouseType,
      };
}
