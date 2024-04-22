// To parse this JSON data, do
//
//     final interUserModel = interUserModelFromJson(jsonString);

import 'dart:convert';

InterUserModel interUserModelFromJson(String str) =>
    InterUserModel.fromJson(json.decode(str));

String interUserModelToJson(InterUserModel data) => json.encode(data.toJson());

class InterUserModel {
  bool? result;
  List<InterUser>? message;

  InterUserModel({
    this.result,
    this.message,
  });

  factory InterUserModel.fromJson(Map<String, dynamic> json) => InterUserModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<InterUser>.from(
                json["message"]!.map((x) => InterUser.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class InterUser {
  String? id;
  String? actorName;
  String? vendorId;
  String? vendorName;
  int? roleType;
  int? roleId;
  String? cinNo;
  String? tanNo;
  String? gstNo;
  String? panNo;
  String? aadharNo;
  String? userRole;
  String? userRoleId;
  String? email;
  String? password;
  String? phone;
  String? isApproved;
  String? isDeleted;
  DateTime? createdAt;
  int? v;

  InterUser({
    this.id,
    this.actorName,
    this.vendorId,
    this.vendorName,
    this.roleType,
    this.roleId,
    this.cinNo,
    this.tanNo,
    this.gstNo,
    this.panNo,
    this.aadharNo,
    this.userRole,
    this.userRoleId,
    this.email,
    this.password,
    this.phone,
    this.isApproved,
    this.isDeleted,
    this.createdAt,
    this.v,
  });

  factory InterUser.fromJson(Map<String, dynamic> json) => InterUser(
        id: json["_id"],
        actorName: json["actorName"],
        vendorId: json["vendorId"],
        vendorName: json["vendorName"],
        roleType: json["roleType"],
        roleId: json["roleId"],
        cinNo: json["cinNo"],
        tanNo: json["tanNo"],
        gstNo: json["gstNo"],
        panNo: json["panNo"],
        aadharNo: json["aadharNo"],
        userRole: json["userRole"],
        userRoleId: json["userRoleId"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        isApproved: json["isApproved"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "actorName": actorName,
        "vendorId": vendorId,
        "vendorName": vendorName,
        "roleType": roleType,
        "roleId": roleId,
        "cinNo": cinNo,
        "tanNo": tanNo,
        "gstNo": gstNo,
        "panNo": panNo,
        "aadharNo": aadharNo,
        "userRole": userRole,
        "userRoleId": userRoleId,
        "email": email,
        "password": password,
        "phone": phone,
        "isApproved": isApproved,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "__v": v,
      };
}
