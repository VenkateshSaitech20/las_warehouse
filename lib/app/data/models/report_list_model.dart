// To parse this JSON data, do
//
//     final whReportListModel = whReportListModelFromJson(jsonString);

import 'dart:convert';

WhReportListModel whReportListModelFromJson(String str) =>
    WhReportListModel.fromJson(json.decode(str));

String whReportListModelToJson(WhReportListModel data) =>
    json.encode(data.toJson());

class WhReportListModel {
  bool? result;
  List<WHReportL>? message;

  WhReportListModel({
    this.result,
    this.message,
  });

  factory WhReportListModel.fromJson(Map<String, dynamic> json) =>
      WhReportListModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<WHReportL>.from(
                json["message"]!.map((x) => WHReportL.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class WHReportL {
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
  String? requirementType;
  String? city;
  String? preferredLocation;
  String? fromDateTime;
  String? toDateTime;
  // List<MaterialTypeDatum>? materialTypeData;
  String? bidPrice;
  String? finalPrice;
  String? reqSqft;
  String? availableWarehouseType;
  String? paymentType;
  String? fullyPaid;
  String? advancePercent;
  String? advancePaid;
  String? termsConditions;
  String? biddingOn;
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
  String? acceptedOn;
  String? checkoutOn;
  String? totalQuantity;
  String? totalWeight;
  String? weightType;
  String? consignmentType;
  String? consignmentLoadingType;
  String? gstNo;
  String? panNo;
  String? aadharNo;
  String? workOrder;
  String? invoice;
  String? checkout;
  String? recurringType;
  String? weeklyType;
  String? monthlyType;
  String? monthlyDay;
  String? recurringDates;
  String? advancePaidOn;
  String? finalPriceConfirmedOn;
  String? changedOn;
  String? changedPrice;
  String? customerAcceptedOn;
  String? invoiceDoc;
  String? invoiceNo;
  String? invoicedOn;
  String? paymentResponse;
  String? rating;
  String? advancePrice;
  String? advanceResponse;
  String? materialType;

  WHReportL({
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
    this.requirementType,
    this.city,
    this.preferredLocation,
    this.fromDateTime,
    this.toDateTime,
    // this.materialTypeData,
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
    this.totalWeight,
    this.workOrder,
    this.invoice,
    this.checkout,
    this.recurringType,
    this.weeklyType,
    this.monthlyType,
    this.monthlyDay,
    this.recurringDates,
    this.finalPriceConfirmedOn,
    this.changedOn,
    this.changedPrice,
    this.customerAcceptedOn,
    this.invoiceDoc,
    this.invoiceNo,
    this.invoicedOn,
    this.paymentResponse,
    this.rating,
    this.advancePaidOn,
    this.advancePrice,
    this.advanceResponse,
    this.materialType,
    this.totalQuantity,
    this.weightType,
    this.consignmentType,
    this.consignmentLoadingType,
    this.gstNo,
    this.panNo,
    this.aadharNo,
  });

  factory WHReportL.fromJson(Map<String, dynamic> json) => WHReportL(
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
        requirementType: json["requirementType"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        // materialTypeData: json["materialTypeData"] == null
        //     ? []
        //     : List<MaterialTypeDatum>.from(json["materialTypeData"]!
        //         .map((x) => MaterialTypeDatum.fromJson(x))),
        bidPrice: json["bidPrice"],
        finalPrice: json["finalPrice"],
        reqSqft: json["reqSqft"],
        availableWarehouseType: json["availableWarehouseType"],
        paymentType: json["paymentType"],
        fullyPaid: json["fullyPaid"],
        advancePercent: json["advancePercent"],
        advancePaid: json["advancePaid"],
        termsConditions: json["termsConditions"],
        biddingOn: json["biddingOn"],
        paymentStatus: json["paymentStatus"],
        finalPriceConfirmed: json["finalPriceConfirmed"],
        isCustomerAccepted: json["isCustomerAccepted"],
        isAccepted: json["isAccepted"],
        isInvoiced: json["isInvoiced"],
        invoiceUploaded: json["invoiceUploaded"],
        isCancelled: json["isCancelled"],
        createdBy: json["createdBy"],
        isCheckout: json["isCheckout"],
        recurringType: json["recurringType"],
        weeklyType: json["weeklyType"],
        monthlyType: json["monthlyType"],
        monthlyDay: json["monthlyDay"],
        recurringDates: json["recurringDates"],
        v: json["__v"],
        acceptedOn: json["acceptedOn"],
        checkoutOn: json["checkoutOn"],
        totalWeight: json["totalWeight"],
        workOrder: json["workOrder"],
        invoice: json["invoice"],
        checkout: json["checkout"],
        finalPriceConfirmedOn: json["finalPriceConfirmedOn"],
        changedOn: json["changedOn"],
        changedPrice: json["changedPrice"],
        customerAcceptedOn: json["customerAcceptedOn"],
        invoiceDoc: json["invoiceDoc"],
        invoiceNo: json["invoiceNo"],
        invoicedOn: json["invoicedOn"],
        paymentResponse: json["paymentResponse"],
        rating: json["rating"],
        advancePaidOn: json["advancePaidOn"],
        advancePrice: json["advancePrice"],
        advanceResponse: json["advanceResponse"],
        materialType: json["materialType"],
        totalQuantity: json["totalQuantity"],
        weightType: json["weightType"],
        consignmentType: json["consignmentType"],
        consignmentLoadingType: json["consignmentLoadingType"],
        gstNo: json["gstNo"],
        panNo: json["panNo"],
        aadharNo: json["aadharNo"],
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
        "requirementType": requirementType,
        "city": city,
        "preferredLocation": preferredLocation,
        "fromDateTime": fromDateTime,
        "toDateTime": toDateTime,
        // "materialTypeData": materialTypeData == null
        //     ? []
        //     : List<dynamic>.from(materialTypeData!.map((x) => x.toJson())),
        "bidPrice": bidPrice,
        "finalPrice": finalPrice,
        "reqSqft": reqSqft,
        "availableWarehouseType": availableWarehouseType,
        "paymentType": paymentType,
        "fullyPaid": fullyPaid,
        "advancePercent": advancePercent,
        "advancePaid": advancePaid,
        "termsConditions": termsConditions,
        "biddingOn": biddingOn,
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
        "acceptedOn": acceptedOn,
        "checkoutOn": checkoutOn,
        "totalWeight": totalWeight,
        "workOrder": workOrder,
        "invoice": invoice,
        "checkout": checkout,
        "recurringType": recurringType,
        "weeklyType": weeklyType,
        "monthlyType": monthlyType,
        "monthlyDay": monthlyDay,
        "recurringDates": recurringDates,
        "finalPriceConfirmedOn": finalPriceConfirmedOn,
        "changedOn": changedOn,
        "changedPrice": changedPrice,
        "customerAcceptedOn": customerAcceptedOn,
        "invoiceDoc": invoiceDoc,
        "invoiceNo": invoiceNo,
        "invoicedOn": invoicedOn,
        "paymentResponse": paymentResponse,
        "rating": rating,
        "advancePaidOn": advancePaidOn,
        "advancePrice": advancePrice,
        "advanceResponse": advanceResponse,
        "materialType": materialType,
        "totalQuantity": totalQuantity,
        "weightType": weightType,
        "consignmentType": consignmentType,
        "consignmentLoadingType": consignmentLoadingType,
        "gstNo": gstNo,
        "panNo": panNo,
        "aadharNo": aadharNo,
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

class MaterialTypeDatum {
  String? materialType;
  String? quantity;
  String? weight;
  String? weightType;
  String? length;
  String? width;
  String? height;
  String? uom;
  String? packagingType;

  MaterialTypeDatum({
    this.materialType,
    this.quantity,
    this.weight,
    this.weightType,
    this.length,
    this.width,
    this.height,
    this.uom,
    this.packagingType,
  });

  factory MaterialTypeDatum.fromJson(Map<String, dynamic> json) =>
      MaterialTypeDatum(
        materialType: json["materialType"].toString(),
        quantity: json["quantity"].toString(),
        weight: json["weight"].toString(),
        weightType: json["weightType"].toString(),
        length: json["length"].toString(),
        width: json["width"].toString(),
        height: json["height"].toString(),
        uom: json["uom"].toString(),
        packagingType: json["packagingType"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "materialType": materialType,
        "quantity": quantity,
        "weight": weight,
        "weightType": weightType,
        "length": length,
        "width": width,
        "height": height,
        "uom": uom,
        "packagingType": packagingType,
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
