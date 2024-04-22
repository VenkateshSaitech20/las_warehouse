// To parse this JSON data, do
//
//     final AmenityType = AmenityTypeFromJson(jsonString);

import 'dart:convert';

List<WHService> WHServiceFromJson(String str) =>
    List<WHService>.from(json.decode(str).map((x) => WHService.fromJson(x)));

String WHServiceToJson(List<WHService> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WHService {
  String? id;
  String? service;
  int? v;

  WHService({
    this.id,
    this.service,
    this.v,
  });

  factory WHService.fromJson(Map<String, dynamic> json) => WHService(
        id: json["_id"],
        service: json["service"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "service": service,
        "__v": v,
      };
}
