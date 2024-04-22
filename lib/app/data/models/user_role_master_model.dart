// To parse this JSON data, do
//
//     final userRoleMasterModel = userRoleMasterModelFromJson(jsonString);

import 'dart:convert';

UserRoleMasterModel userRoleMasterModelFromJson(String str) =>
    UserRoleMasterModel.fromJson(json.decode(str));

String userRoleMasterModelToJson(UserRoleMasterModel data) =>
    json.encode(data.toJson());

class UserRoleMasterModel {
  bool? result;
  List<UserRoleMaster>? message;

  UserRoleMasterModel({
    this.result,
    this.message,
  });

  factory UserRoleMasterModel.fromJson(Map<String, dynamic> json) =>
      UserRoleMasterModel(
        result: json["result"],
        message: json["message"] == null
            ? []
            : List<UserRoleMaster>.from(
                json["message"]!.map((x) => UserRoleMaster.fromJson(x)),
              ),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message == null
            ? []
            : List<dynamic>.from(message!.map((x) => x.toJson())),
      };
}

class UserRoleMaster {
  String? id;
  String? menuId;
  String? menu;
  String? hasRead;
  String? sequence;
  String? name;

  UserRoleMaster({
    this.id,
    this.menuId,
    this.menu,
    this.hasRead,
    this.sequence,
    this.name,
  });

  factory UserRoleMaster.fromJson(Map<String, dynamic> json) => UserRoleMaster(
        id: json["_id"],
        menuId: json["menuId"],
        menu: json["menu"],
        hasRead: json["hasRead"],
        sequence: json["sequence"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "menuId": menuId,
        "menu": menu,
        "hasRead": hasRead,
        "sequence": sequence,
        "name": name,
      };
}
