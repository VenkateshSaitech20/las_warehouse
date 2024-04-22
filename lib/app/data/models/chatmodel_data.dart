// To parse this JSON data, do
//
//     final chatModelData = chatModelDataFromJson(jsonString);

import 'dart:convert';

ChatModelData chatModelDataFromJson(String str) =>
    ChatModelData.fromJson(json.decode(str));

String chatModelDataToJson(ChatModelData data) => json.encode(data.toJson());

class ChatModelData {
  bool? result;
  List<Chat>? message;

  ChatModelData({
    this.result,
    this.message,
  });

  factory ChatModelData.fromJson(Map<String, dynamic> json) => ChatModelData(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<Chat>.from(json["message"]!.map((x) => Chat.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class Chat {
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

  Chat({
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

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
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
