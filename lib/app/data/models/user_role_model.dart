// To parse this JSON data, do
//
//     final userRoleModel = userRoleModelFromJson(jsonString);

import 'dart:convert';

UserRoleModel userRoleModelFromJson(String str) =>
    UserRoleModel.fromJson(json.decode(str));

String userRoleModelToJson(UserRoleModel data) => json.encode(data.toJson());

class UserRoleModel {
  bool? result;
  List<UserRole>? message;

  UserRoleModel({
    this.result,
    this.message,
  });

  factory UserRoleModel.fromJson(Map<String, dynamic> json) => UserRoleModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<UserRole>.from(
                json["message"]!.map((x) => UserRole.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class UserRole {
  String? id;
  String? vendorId;
  String? userRole;
  Menus? menus;
  String? createdAt;
  int? v;

  UserRole({
    this.id,
    this.vendorId,
    this.userRole,
    this.menus,
    this.createdAt,
    this.v,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        id: json["_id"],
        vendorId: json["vendorId"],
        userRole: json["userRole"],
        menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
        createdAt: json["createdAt"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "vendorId": vendorId,
        "userRole": userRole,
        "menus": menus?.toJson(),
        "createdAt": createdAt,
        "__v": v,
      };
}

class Menus {
  List<String>? hasRead;

  Menus({
    this.hasRead,
  });

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        hasRead: json["hasRead"] == null
            ? []
            : List<String>.from(json["hasRead"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "hasRead":
            hasRead == null ? [] : List<dynamic>.from(hasRead!.map((x) => x)),
      };
}
