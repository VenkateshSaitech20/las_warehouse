// To parse this JSON data, do
//
//     final AmenityType = AmenityTypeFromJson(jsonString);

import 'dart:convert';

List<WHCategory> WHCategoryeFromJson(String str) =>
    List<WHCategory>.from(json.decode(str).map((x) => WHCategory.fromJson(x)));

String WHCategoryToJson(List<WHCategory> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WHCategory {
  String? id;
  String? category;
  int? v;

  WHCategory({
    this.id,
    this.category,
    this.v,
  });

  factory WHCategory.fromJson(Map<String, dynamic> json) => WHCategory(
        id: json["_id"],
        category: json["category"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "__v": v,
      };
}
