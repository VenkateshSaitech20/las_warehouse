// To parse this JSON data, do
//
//     final paymentType = paymentTypeFromJson(jsonString);

import 'dart:convert';

List<PaymentType> paymentTypeFromJson(String str) => List<PaymentType>.from(
      json.decode(str).map((x) => PaymentType.fromJson(x)),
    );

String paymentTypeToJson(List<PaymentType> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PaymentType {
  String? id;
  String? paymentType;

  PaymentType({
    this.id,
    this.paymentType,
  });

  factory PaymentType.fromJson(Map<String, dynamic> json) => PaymentType(
        id: json["_id"],
        paymentType: json["paymentType"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "paymentType": paymentType,
      };
}
