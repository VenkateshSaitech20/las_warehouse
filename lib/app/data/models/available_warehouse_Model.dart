// To parse this JSON data, do
//
//     final availableWarehousesModel = availableWarehousesModelFromJson(jsonString);

// ignore_for_file: file_names

import 'dart:convert';

AvailableWarehousesModel availableWarehousesModelFromJson(String str) =>
    AvailableWarehousesModel.fromJson(json.decode(str));

String availableWarehousesModelToJson(AvailableWarehousesModel data) =>
    json.encode(data.toJson());

class AvailableWarehousesModel {
  bool? result;
  List<AvailableWarehouseName>? message;

  AvailableWarehousesModel({
    this.result,
    this.message,
  });

  factory AvailableWarehousesModel.fromJson(Map<String, dynamic> json) =>
      AvailableWarehousesModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<AvailableWarehouseName>.from(
                json["message"]!.map((x) => AvailableWarehouseName.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class AvailableWarehouseName {
  String? id;
  String? warehouseName;
  String? cityLocation;

  AvailableWarehouseName({
    this.id,
    this.warehouseName,
    this.cityLocation,
  });

  factory AvailableWarehouseName.fromJson(Map<String, dynamic> json) =>
      AvailableWarehouseName(
        id: json["_id"],
        warehouseName: json["warehouseName"],
        cityLocation: json["cityLocation"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "warehouseName": warehouseName,
        "cityLocation": cityLocation,
      };
}
