// To parse this JSON data, do
//
//     final completedOrdersModel = completedOrdersModelFromJson(jsonString);

import 'dart:convert';

CompletedOrdersModel completedOrdersModelFromJson(String str) =>
    CompletedOrdersModel.fromJson(json.decode(str));

String completedOrdersModelToJson(CompletedOrdersModel data) =>
    json.encode(data.toJson());

class CompletedOrdersModel {
  bool? result;
  List<CompletedOrdersData>? message;

  CompletedOrdersModel({
    this.result,
    this.message,
  });

  factory CompletedOrdersModel.fromJson(Map<String, dynamic> json) =>
      CompletedOrdersModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<CompletedOrdersData>.from(
                json["message"]!.map((x) => CompletedOrdersData.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class CompletedOrdersData {
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
  String? isCustomerAccepted;
  String? isAccepted;
  String? isInvoiced;
  String? invoiceUploaded;
  String? invoiceDoc;
  String? isCancelled;
  String? isCheckout;
  String? rating;
  int? v;
  DateTime? finalPriceConfirmedOn;
  DateTime? acceptedOn;
  DateTime? checkoutOn;
  DateTime? changedOn;
  String? changedPrice;
  DateTime? customerAcceptedOn;

  CompletedOrdersData({
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
    this.isCustomerAccepted,
    this.isAccepted,
    this.isInvoiced,
    this.invoiceUploaded,
    this.invoiceDoc,
    this.isCancelled,
    this.isCheckout,
    this.v,
    this.finalPriceConfirmedOn,
    this.acceptedOn,
    this.checkoutOn,
    this.changedOn,
    this.changedPrice,
    this.customerAcceptedOn,
    this.rating,
  });

  factory CompletedOrdersData.fromJson(Map<String, dynamic> json) =>
      CompletedOrdersData(
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
        rating: json["rating"],
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
        biddingOn: json["biddingOn"] == null
            ? null
            : DateTime.parse(json["biddingOn"]),
        paymentStatus: json["paymentStatus"],
        finalPriceConfirmed: json["finalPriceConfirmed"],
        isCustomerAccepted: json["isCustomerAccepted"],
        isAccepted: json["isAccepted"],
        isInvoiced: json["isInvoiced"],
        invoiceUploaded: json["invoiceUploaded"],
        invoiceDoc: json["invoiceDoc"],
        isCancelled: json["isCancelled"],
        isCheckout: json["isCheckout"],
        v: json["__v"],
        finalPriceConfirmedOn: json["finalPriceConfirmedOn"] == null
            ? null
            : DateTime.parse(json["finalPriceConfirmedOn"]),
        acceptedOn: json["acceptedOn"] == null
            ? null
            : DateTime.parse(json["acceptedOn"]),
        checkoutOn: json["checkoutOn"] == null
            ? null
            : DateTime.parse(json["checkoutOn"]),
        changedOn: json["changedOn"] == null
            ? null
            : DateTime.parse(json["changedOn"]),
        changedPrice: json["changedPrice"],
        customerAcceptedOn: json["customerAcceptedOn"] == null
            ? null
            : DateTime.parse(json["customerAcceptedOn"]),
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
        "isCustomerAccepted": isCustomerAccepted,
        "isAccepted": isAccepted,
        "isInvoiced": isInvoiced,
        "invoiceUploaded": invoiceUploaded,
        "invoiceDoc": invoiceDoc,
        "isCancelled": isCancelled,
        "isCheckout": isCheckout,
        "rating": rating,
        "__v": v,
        "finalPriceConfirmedOn": finalPriceConfirmedOn?.toIso8601String(),
        "acceptedOn": acceptedOn?.toIso8601String(),
        "checkoutOn": checkoutOn?.toIso8601String(),
        "changedOn": changedOn?.toIso8601String(),
        "changedPrice": changedPrice,
        "customerAcceptedOn": customerAcceptedOn?.toIso8601String(),
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

class Warehouse {
  String? warehouseName;
  String? shortName;
  String? warehouseType;
  String? latitude;
  String? longitude;

  Warehouse({
    this.warehouseName,
    this.shortName,
    this.warehouseType,
    this.latitude,
    this.longitude,
  });

  factory Warehouse.fromJson(Map<String, dynamic> json) => Warehouse(
        warehouseName: json["warehouseName"],
        shortName: json["shortName"],
        warehouseType: json["warehouseType"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "warehouseName": warehouseName,
        "shortName": shortName,
        "warehouseType": warehouseType,
        "latitude": latitude,
        "longitude": longitude,
      };
}
