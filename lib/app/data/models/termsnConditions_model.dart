import 'dart:convert';

TermsnConditionsModel termsnConditionsModelFromJson(String str) =>
    TermsnConditionsModel.fromJson(json.decode(str));

String termsnConditionsModelToJson(TermsnConditionsModel data) =>
    json.encode(data.toJson());

class TermsnConditionsModel {
  bool? result;
  TermsDetails? message;

  TermsnConditionsModel({
    this.result,
    this.message,
  });

  factory TermsnConditionsModel.fromJson(Map<String, dynamic> json) =>
      TermsnConditionsModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : TermsDetails.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class TermsDetails {
  String? id;
  String? vendorId;
  String? termsConditions;
  int? v;

  TermsDetails({
    this.id,
    this.vendorId,
    this.termsConditions,
    this.v,
  });

  factory TermsDetails.fromJson(Map<String, dynamic> json) => TermsDetails(
        id: json["_id"],
        vendorId: json["vendorId"],
        termsConditions: json["termsConditions"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendorId": vendorId,
        "termsConditions": termsConditions,
        "__v": v,
      };
}
