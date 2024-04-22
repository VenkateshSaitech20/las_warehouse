// To parse this JSON data, do
//
//     final whReporDetailModel = whReporDetailModelFromJson(jsonString);

// To parse this JSON data, do
//
//     final whReportListModel = whReportListModelFromJson(jsonString);

import 'dart:convert';

WhReporDetailModel whReportDetailModelFromJson(String str) =>
    WhReporDetailModel.fromJson(json.decode(str));

String whReportDetailModelToJson(WhReporDetailModel data) =>
    json.encode(data.toJson());

class WhReporDetailModel {
  bool? result;
  WhReporDetail? message;

  WhReporDetailModel({
    this.result,
    this.message,
  });

  factory WhReporDetailModel.fromJson(Map<String, dynamic> json) =>
      WhReporDetailModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : WhReporDetail.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class WhReporDetail {
  String? id;
  String? reqId;
  String? warehouseId;
  Warehouse? warehouse;
  String? requirementNo;
  String? cusId;
  Customer? customer;
  String? vendorId;
  Vendor? vendor;
  String? requirementType;
  String? bookingType;
  String? city;
  String? preferredLocation;
  String? fromDateTime;
  String? toDateTime;
  List<MaterialTypeDatum>? materialTypeData;
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
  String? endDatetime;
  String? totalQuantity;
  String? totalWeight;
  String? weightType;
  String? consignmentType;
  String? consignmentLoadingType;
  String? gstNo;
  String? panNo;
  String? aadharNo;
  String? workOrder;
  String? checkout;
  String? invoice;
  List<Negotiation>? negotiations;
  List<Negotiation>? wOnegotiations;
  String? advancePaidOn;
  String? finalPriceConfirmedOn;
  String? recurringType;
  String? weeklyType;
  String? monthlyType;
  String? monthlyDay;
  String? recurringDates;

  WhReporDetail({
    this.id,
    this.reqId,
    this.warehouseId,
    this.warehouse,
    this.requirementNo,
    this.cusId,
    this.customer,
    this.vendorId,
    this.vendor,
    this.requirementType,
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
    this.endDatetime,
    this.totalQuantity,
    this.totalWeight,
    this.weightType,
    this.consignmentType,
    this.consignmentLoadingType,
    this.gstNo,
    this.panNo,
    this.aadharNo,
    this.workOrder,
    this.checkout,
    this.invoice,
    this.negotiations,
    this.wOnegotiations,
    this.advancePaidOn,
    this.finalPriceConfirmedOn,
    this.recurringType,
    this.weeklyType,
    this.monthlyType,
    this.monthlyDay,
    this.recurringDates,
  });

  factory WhReporDetail.fromJson(Map<String, dynamic> json) => WhReporDetail(
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
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        requirementType: json["requirementType"],
        bookingType: json["bookingType"],
        city: json["city"],
        preferredLocation: json["preferredLocation"],
        fromDateTime: json["fromDateTime"],
        toDateTime: json["toDateTime"],
        materialTypeData: json["materialTypeData"] == null
            ? []
            : List<MaterialTypeDatum>.from(
                json["materialTypeData"]!
                    .map((x) => MaterialTypeDatum.fromJson(x)),
              ),
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
        v: json["__v"],
        acceptedOn: json["acceptedOn"],
        checkoutOn: json["checkoutOn"],
        endDatetime: json["endDatetime"],
        totalQuantity: json["totalQuantity"],
        totalWeight: json["totalWeight"],
        weightType: json["weightType"],
        consignmentType: json["consignmentType"],
        consignmentLoadingType: json["consignmentLoadingType"],
        gstNo: json["gstNo"],
        panNo: json["panNo"],
        aadharNo: json["aadharNo"],
        workOrder: json["workOrder"],
        checkout: json["checkout"],
        invoice: json["invoice"],
        negotiations: json["negotiations"] == null
            ? []
            : List<Negotiation>.from(
                json["negotiations"]!.map((x) => Negotiation.fromJson(x)),
              ),
        wOnegotiations: json["WOnegotiations"] == null
            ? []
            : List<Negotiation>.from(
                json["WOnegotiations"]!.map((x) => Negotiation.fromJson(x)),
              ),
        advancePaidOn: json["advancePaidOn"],
        finalPriceConfirmedOn: json["finalPriceConfirmedOn"],
        recurringType: json["recurringType"],
        weeklyType: json["weeklyType"],
        monthlyType: json["monthlyType"],
        monthlyDay: json["monthlyDay"],
        recurringDates: json["recurringDates"],
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
        "requirementType": requirementType,
        "bookingType": bookingType,
        "city": city,
        "preferredLocation": preferredLocation,
        "fromDateTime": fromDateTime,
        "toDateTime": toDateTime,
        "materialTypeData": materialTypeData == null
            ? []
            : List<dynamic>.from(materialTypeData!.map((x) => x.toJson())),
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
        "endDatetime": endDatetime,
        "totalQuantity": totalQuantity,
        "totalWeight": totalWeight,
        "weightType": weightType,
        "consignmentType": consignmentType,
        "consignmentLoadingType": consignmentLoadingType,
        "gstNo": gstNo,
        "panNo": panNo,
        "aadharNo": aadharNo,
        "workOrder": workOrder,
        "checkout": checkout,
        "invoice": invoice,
        "negotiations": negotiations == null
            ? []
            : List<dynamic>.from(negotiations!.map((x) => x.toJson())),
        "WOnegotiations": wOnegotiations == null
            ? []
            : List<dynamic>.from(wOnegotiations!.map((x) => x.toJson())),
        "advancePaidOn": advancePaidOn,
        "finalPriceConfirmedOn": finalPriceConfirmedOn,
        "recurringType": recurringType,
        "weeklyType": weeklyType,
        "monthlyType": monthlyType,
        "monthlyDay": monthlyDay,
        "recurringDates": recurringDates,
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

class MaterialTypeDatum {
  String? materialType;
  String? weight;
  String? weightType;
  String? quantity;
  String? length;
  String? width;
  String? height;
  String? uom;
  String? packagingType;

  MaterialTypeDatum({
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

  factory MaterialTypeDatum.fromJson(Map<String, dynamic> json) =>
      MaterialTypeDatum(
        materialType: json["materialType"],
        weight: json["weight"].toString(),
        weightType: json["weightType"],
        quantity: json["quantity"].toString(),
        length: json["length"].toString(),
        width: json["width"].toString(),
        height: json["height"].toString(),
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

class Negotiation {
  String? id;
  String? bidId;
  String? reqId;
  String? senderId;
  String? senderType;
  SenderData? senderData;
  String? message;
  String? createdBy;
  String? sentAt;
  int? v;
  String? attachment;

  Negotiation({
    this.id,
    this.bidId,
    this.reqId,
    this.senderId,
    this.senderType,
    this.senderData,
    this.message,
    this.createdBy,
    this.sentAt,
    this.v,
    this.attachment,
  });

  factory Negotiation.fromJson(Map<String, dynamic> json) => Negotiation(
        id: json["_id"],
        bidId: json["bidId"],
        reqId: json["reqId"],
        senderId: json["senderId"],
        senderType: json["senderType"],
        senderData: json["senderData"] == null
            ? null
            : SenderData.fromJson(json["senderData"]),
        message: json["message"],
        createdBy: json["createdBy"],
        sentAt: json["sentAt"],
        v: json["__v"],
        attachment: json["attachment"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bidId": bidId,
        "reqId": reqId,
        "senderId": senderId,
        "senderType": senderType,
        "senderData": senderData?.toJson(),
        "message": message,
        "createdBy": createdBy,
        "sentAt": sentAt,
        "__v": v,
        "attachment": attachment,
      };
}

class SenderData {
  String? vendorName;
  String? email;
  String? logo;
  String? cusName;

  SenderData({
    this.vendorName,
    this.email,
    this.logo,
    this.cusName,
  });

  factory SenderData.fromJson(Map<String, dynamic> json) => SenderData(
        vendorName: json["vendorName"],
        email: json["email"],
        logo: json["logo"],
        cusName: json["cusName"],
      );

  Map<String, dynamic> toJson() => {
        "vendorName": vendorName,
        "email": email,
        "logo": logo,
        "cusName": cusName,
      };
}

class Vendor {
  String? vendorName;
  String? email;
  String? logo;
  String? phone;
  String? overallRating;
  String? address1;
  String? address2;

  Vendor({
    this.vendorName,
    this.email,
    this.logo,
    this.phone,
    this.overallRating,
    this.address1,
    this.address2,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
        vendorName: json["vendorName"],
        email: json["email"],
        logo: json["logo"],
        phone: json["phone"],
        overallRating: json["overallRating"],
        address1: json["address1"],
        address2: json["address2"],
      );

  Map<String, dynamic> toJson() => {
        "vendorName": vendorName,
        "email": email,
        "logo": logo,
        "phone": phone,
        "overallRating": overallRating,
        "address1": address1,
        "address2": address2,
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
