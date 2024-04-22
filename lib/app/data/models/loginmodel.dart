// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) =>
    LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? result;
  String? message;
  MasterResp? masterResp;

  LoginModel({
    this.result,
    this.message,
    this.masterResp,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        result: json["result"],
        message: json["message"],
        masterResp: json["masterResp"] == null
            ? null
            : MasterResp.fromJson(json["masterResp"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
        "masterResp": masterResp?.toJson(),
      };
}

class MasterResp {
  String? page;
  Company? company;

  MasterResp({
    this.page,
    this.company,
  });

  factory MasterResp.fromJson(Map<String, dynamic> json) => MasterResp(
        page: json["page"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "company": company?.toJson(),
      };
}

class Company {
  String? companyName;
  String? logo;
  int? roleId;

  Company({
    this.companyName,
    this.logo,
    this.roleId,
  });

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        companyName: json["companyName"],
        logo: json["logo"],
        roleId: json["roleId"],
      );

  Map<String, dynamic> toJson() => {
        "companyName": companyName,
        "logo": logo,
        "roleId": roleId,
      };
}
