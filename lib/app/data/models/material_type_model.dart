// To parse this JSON data, do
//
//     final materialTypeModel = materialTypeModelFromJson(jsonString);

import 'dart:convert';

List<MaterialTypeModel> materialTypeModelFromJson(String str) => List<MaterialTypeModel>.from(json.decode(str).map((x) => MaterialTypeModel.fromJson(x)));

String materialTypeModelToJson(List<MaterialTypeModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MaterialTypeModel {
    String? id;
    String? materialType;

    MaterialTypeModel({
        this.id,
        this.materialType,
    });

    factory MaterialTypeModel.fromJson(Map<String, dynamic> json) => MaterialTypeModel(
        id: json["_id"],
        materialType: json["materialType"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "materialType": materialType,
    };
}
