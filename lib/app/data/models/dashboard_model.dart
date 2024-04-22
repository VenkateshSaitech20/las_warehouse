// To parse this JSON data, do
//
//     final dashboardModel = dashboardModelFromJson(jsonString);

import 'dart:convert';

DashboardModel dashboardModelFromJson(String str) =>
    DashboardModel.fromJson(json.decode(str));

String dashboardModelToJson(DashboardModel data) => json.encode(data.toJson());

class DashboardModel {
  bool? result;
  DashBoardDetails? message;

  DashboardModel({
    this.result,
    this.message,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        result: json["result"],
        message: json["message"] == null
            ? null
            : DashBoardDetails.fromJson(json["message"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message?.toJson(),
      };
}

class DashBoardDetails {
  int? reqCnt;
  int? pendingCnt;
  int? workOrderCnt;
  int? checkoutCnt;
  int? completedCnt;

  DashBoardDetails({
    this.reqCnt,
    this.pendingCnt,
    this.workOrderCnt,
    this.checkoutCnt,
    this.completedCnt,
  });

  factory DashBoardDetails.fromJson(Map<String, dynamic> json) =>
      DashBoardDetails(
        reqCnt: json["reqCnt"],
        pendingCnt: json["pendingCnt"],
        workOrderCnt: json["workOrderCnt"],
        checkoutCnt: json["checkoutCnt"],
        completedCnt: json["completedCnt"],
      );

  Map<String, dynamic> toJson() => {
        "reqCnt": reqCnt,
        "pendingCnt": pendingCnt,
        "workOrderCnt": workOrderCnt,
        "checkoutCnt": checkoutCnt,
        "completedCnt": completedCnt,
      };
}
