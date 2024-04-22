// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  bool? result;
  User? message;

  UserModel({
    this.result,
    this.message,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        result: json["result"],
        message:
            json["message"] == null ? null : User.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class User {
  String? id;
  String? vendorName;
  String? doe;
  String? gstNo;
  String? panNo;
  String? aadharNo;
  String? email;
  String? password;
  String? phone;
  String? address1;
  String? address2;
  String? pincode;
  String? country;
  String? state;
  String? city;
  String? termsAgree;
  String? isDeleted;
  DateTime? createdAt;
  String? logo;
  String? gstFile;
  String? panFile;
  String? aadharFile;
  String? cinNo;
  int? v;
  int? roleId;
  int? roleType;
  String? menus;
  String? actorName;
  String? actorId;

  User({
    this.id,
    this.vendorName,
    this.doe,
    this.gstNo,
    this.panNo,
    this.aadharNo,
    this.email,
    this.password,
    this.phone,
    this.address1,
    this.address2,
    this.pincode,
    this.country,
    this.state,
    this.city,
    this.termsAgree,
    this.isDeleted,
    this.createdAt,
    this.logo,
    this.gstFile,
    this.panFile,
    this.aadharFile,
    this.cinNo,
    this.v,
    this.roleId,
    this.roleType,
    this.menus,
    this.actorId,
    this.actorName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["_id"],
        vendorName: json["vendorName"],
        doe: json["doe"],
        gstNo: json["gstNo"],
        panNo: json["panNo"],
        aadharNo: json["aadharNo"],
        email: json["email"],
        password: json["password"],
        phone: json["phone"],
        address1: json["address1"],
        address2: json["address2"],
        pincode: json["pincode"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        termsAgree: json["termsAgree"],
        isDeleted: json["isDeleted"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        logo: json["logo"],
        gstFile: json["gstFile"],
        panFile: json["panFile"],
        aadharFile: json["aadharFile"],
        cinNo: json["cinNo"],
        v: json["__v"],
        roleId: json["roleId"],
        roleType: json["roleType"],
        menus: json["menus"],
        actorId: json["actorId"],
        actorName: json["actorName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendorName": vendorName,
        "doe": doe,
        "gstNo": gstNo,
        "panNo": panNo,
        "aadharNo": aadharNo,
        "email": email,
        "password": password,
        "phone": phone,
        "address1": address1,
        "address2": address2,
        "pincode": pincode,
        "country": country,
        "state": state,
        "city": city,
        "termsAgree": termsAgree,
        "isDeleted": isDeleted,
        "createdAt": createdAt?.toIso8601String(),
        "logo": logo,
        "gstFile": gstFile,
        "panFile": panFile,
        "aadharFile": aadharFile,
        "cinNo": cinNo,
        "__v": v,
        "roleId": roleId,
        "roleType": roleType,
        "menus": menus,
        "actorId": actorId,
        "actorName": actorName,
      };
}
