import 'dart:convert';

WarehouseDetailModel warehouseDetailModelFromJson(String str) =>
    WarehouseDetailModel.fromJson(json.decode(str));

String warehouseDetailModelToJson(WarehouseDetailModel data) =>
    json.encode(data.toJson());

class WarehouseDetailModel {
  bool? result;
  WarehouseDetailsData? message;

  WarehouseDetailModel({
    this.result,
    this.message,
  });

  factory WarehouseDetailModel.fromJson(Map<String, dynamic> json) =>
      WarehouseDetailModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : WarehouseDetailsData.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class WarehouseDetailsData {
  String? id;
  String? vendorId;
  String? warehouseName;
  String? shortName;
  String? warehouseType;
  int? totalLand;
  String? storageCharges;
  String? handlingCharges;
  int? yearBuilt;
  int? builtUp;
  String? materialTypes;
  String? cityLocation;
  String? amenities;
  String? workingDays;
  String? latitude;
  String? longitude;
  String? isDeleted;
  String? createdAt;
  String? warehouseLogo;
  String? leaseRentalAgreement;
  String? fireSafetyCertificate;
  String? buildingPlanApproved;
  String? environmentalClearance;
  String? insuranceDocument;
  String? shopLicenseDocument;
  String? labourLicenseDocument;
  List<String>? yardPhotos;
  List<String>? gatePhotos;
  List<String>? dockingArea;
  List<String>? whEquipmentPhotos;
  int? v;

  WarehouseDetailsData({
    this.id,
    this.vendorId,
    this.warehouseName,
    this.shortName,
    this.warehouseType,
    this.totalLand,
    this.storageCharges,
    this.handlingCharges,
    this.yearBuilt,
    this.builtUp,
    this.materialTypes,
    this.cityLocation,
    this.amenities,
    this.workingDays,
    this.latitude,
    this.longitude,
    this.isDeleted,
    this.createdAt,
    this.warehouseLogo,
    this.leaseRentalAgreement,
    this.fireSafetyCertificate,
    this.buildingPlanApproved,
    this.environmentalClearance,
    this.insuranceDocument,
    this.shopLicenseDocument,
    this.labourLicenseDocument,
    this.yardPhotos,
    this.gatePhotos,
    this.dockingArea,
    this.whEquipmentPhotos,
    this.v,
  });

  factory WarehouseDetailsData.fromJson(Map<String, dynamic> json) =>
      WarehouseDetailsData(
        id: json["_id"],
        vendorId: json["vendorId"],
        warehouseName: json["warehouseName"],
        shortName: json["shortName"],
        warehouseType: json["warehouseType"],
        totalLand: json["totalLand"],
        storageCharges: json["storageCharges"],
        handlingCharges: json["handlingCharges"],
        yearBuilt: json["yearBuilt"],
        builtUp: json["builtUp"],
        materialTypes: json["materialTypes"],
        cityLocation: json["cityLocation"],
        amenities: json["amenities"],
        workingDays: json["workingDays"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"],
        warehouseLogo: json["warehouseLogo"],
        leaseRentalAgreement: json["leaseRentalAgreement"],
        fireSafetyCertificate: json["fireSafetyCertificate"],
        buildingPlanApproved: json["buildingPlanApproved"],
        environmentalClearance: json["environmentalClearance"],
        insuranceDocument: json["insuranceDocument"],
        shopLicenseDocument: json["shopLicenseDocument"],
        labourLicenseDocument: json["labourLicenseDocument"],
        yardPhotos: json["yardPhotos"] == null
            ? []
            : List<String>.from(json["yardPhotos"]!.map((x) => x)),
        gatePhotos: json["gatePhotos"] == null
            ? []
            : List<String>.from(json["gatePhotos"]!.map((x) => x)),
        dockingArea: json["dockingArea"] == null
            ? []
            : List<String>.from(json["dockingArea"]!.map((x) => x)),
        whEquipmentPhotos: json["whEquipmentPhotos"] == null
            ? []
            : List<String>.from(json["whEquipmentPhotos"]!.map((x) => x)),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendorId": vendorId,
        "warehouseName": warehouseName,
        "shortName": shortName,
        "warehouseType": warehouseType,
        "totalLand": totalLand,
        "storageCharges": storageCharges,
        "handlingCharges": handlingCharges,
        "yearBuilt": yearBuilt,
        "builtUp": builtUp,
        "materialTypes": materialTypes,
        "cityLocation": cityLocation,
        "amenities": amenities,
        "workingDays": workingDays,
        "latitude": latitude,
        "longitude": longitude,
        "isDeleted": isDeleted,
        "createdAt": createdAt,
        "warehouseLogo": warehouseLogo,
        "leaseRentalAgreement": leaseRentalAgreement,
        "fireSafetyCertificate": fireSafetyCertificate,
        "buildingPlanApproved": buildingPlanApproved,
        "environmentalClearance": environmentalClearance,
        "insuranceDocument": insuranceDocument,
        "shopLicenseDocument": shopLicenseDocument,
        "labourLicenseDocument": labourLicenseDocument,
        "yardPhotos": yardPhotos == null
            ? []
            : List<dynamic>.from(yardPhotos!.map((x) => x)),
        "gatePhotos": gatePhotos == null
            ? []
            : List<dynamic>.from(gatePhotos!.map((x) => x)),
        "dockingArea": dockingArea == null
            ? []
            : List<dynamic>.from(dockingArea!.map((x) => x)),
        "whEquipmentPhotos": whEquipmentPhotos == null
            ? []
            : List<dynamic>.from(whEquipmentPhotos!.map((x) => x)),
        "__v": v,
      };
}
