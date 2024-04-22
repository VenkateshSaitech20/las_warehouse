// To parse this JSON data, do
//
//     final workorderChatModel = workorderChatModelFromJson(jsonString);

import 'dart:convert';

WorkorderChatModel workorderChatModelFromJson(String str) =>
    WorkorderChatModel.fromJson(json.decode(str));

String workorderChatModelToJson(WorkorderChatModel data) =>
    json.encode(data.toJson());

class WorkorderChatModel {
  bool? result;
  List<WorkorderChat>? message;

  WorkorderChatModel({
    this.result,
    this.message,
  });

  factory WorkorderChatModel.fromJson(Map<String, dynamic> json) =>
      WorkorderChatModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<WorkorderChat>.from(
                json["message"]!.map((x) => WorkorderChat.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class WorkorderChat {
  String? id;
  String? bidId;
  String? reqId;
  String? senderId;
  String? senderType;
  SenderData? senderData;
  String? message;
  String? attachment;
  DateTime? sentAt;
  int? v;

  WorkorderChat({
    this.id,
    this.bidId,
    this.reqId,
    this.senderId,
    this.senderType,
    this.senderData,
    this.message,
    this.attachment,
    this.sentAt,
    this.v,
  });

  factory WorkorderChat.fromJson(Map<String, dynamic> json) => WorkorderChat(
        id: json["_id"],
        bidId: json["bidId"],
        reqId: json["reqId"],
        senderId: json["senderId"],
        senderType: json["senderType"],
        senderData: json["senderData"] == null
            ? null
            : SenderData.fromJson(json["senderData"]),
        message: json["message"],
        attachment: json["attachment"],
        sentAt: json["sentAt"] == null ? null : DateTime.parse(json["sentAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "bidId": bidId,
        "reqId": reqId,
        "senderId": senderId,
        "senderType": senderType,
        "senderData": senderData?.toJson(),
        "message": message,
        "attachment": attachment,
        "sentAt": sentAt?.toIso8601String(),
        "__v": v,
      };
}

class SenderData {
  String? vendorName;
  String? email;
  String? logo;
  String? cusName;

  SenderData({
    this.vendorName,
    this.email,
    this.logo,
    this.cusName,
  });

  factory SenderData.fromJson(Map<String, dynamic> json) => SenderData(
        vendorName: json["vendorName"],
        email: json["email"],
        logo: json["logo"],
        cusName: json["cusName"],
      );

  Map<String, dynamic> toJson() => {
        "vendorName": vendorName,
        "email": email,
        "logo": logo,
        "cusName": cusName,
      };
}
