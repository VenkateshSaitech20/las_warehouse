// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

CommonModel loginModelFromJson(String str) =>
    CommonModel.fromJson(json.decode(str));

String loginModelToJson(CommonModel data) => json.encode(data.toJson());

class CommonModel {
  bool? result;
  String? message;

  CommonModel({
    this.result,
    this.message,
  });

  factory CommonModel.fromJson(Map<String, dynamic> json) => CommonModel(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}
