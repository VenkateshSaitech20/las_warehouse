// To parse this JSON data, do
//
//     final warehousetypeModel = warehousetypeModelFromJson(jsonString);

import 'dart:convert';

List<WareHouseType> warehousetypeModelFromJson(String str) => List<WareHouseType>.from(json.decode(str).map((x) => WareHouseType.fromJson(x)));

String warehousetypeModelToJson(List<WareHouseType> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WareHouseType {
    String? id;
    String? warehouseType;

    WareHouseType({
        this.id,
        this.warehouseType,
    });

    factory WareHouseType.fromJson(Map<String, dynamic> json) => WareHouseType(
        id: json["_id"],
        warehouseType: json["warehouseType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "warehouseType": warehouseType,
    };
}
