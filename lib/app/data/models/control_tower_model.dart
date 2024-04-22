// To parse this JSON data, do
//
//     final controlTowerModel = controlTowerModelFromJson(jsonString);

import 'dart:convert';

ControlTowerModel controlTowerModelFromJson(String str) =>
    ControlTowerModel.fromJson(json.decode(str));

String controlTowerModelToJson(ControlTowerModel data) =>
    json.encode(data.toJson());

class ControlTowerModel {
  bool? result;
  List<ControlTower>? message;

  ControlTowerModel({
    this.result,
    this.message,
  });

  factory ControlTowerModel.fromJson(Map<String, dynamic> json) =>
      ControlTowerModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<ControlTower>.from(
                json["message"]!.map((x) => ControlTower.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class ControlTower {
  String? id;
  String? warehouseName;
  String? warehouseType;
  int? totalLand;
  int? builtUp;
  int? occupied;
  int? availableSpace;

  ControlTower({
    this.id,
    this.warehouseName,
    this.warehouseType,
    this.totalLand,
    this.builtUp,
    this.occupied,
    this.availableSpace,
  });

  factory ControlTower.fromJson(Map<String, dynamic> json) => ControlTower(
        id: json["_id"],
        warehouseName: json["warehouseName"],
        warehouseType: json["warehouseType"],
        totalLand: json["totalLand"],
        builtUp: json["builtUp"],
        occupied: json["occupied"],
        availableSpace: json["availableSpace"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "warehouseName": warehouseName,
        "warehouseType": warehouseType,
        "totalLand": totalLand,
        "builtUp": builtUp,
        "occupied": occupied,
        "availableSpace": availableSpace,
      };
}
