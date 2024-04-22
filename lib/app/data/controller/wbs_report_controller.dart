// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/report_detail_model.dart';
import 'package:las_warehouse/app/data/models/report_list_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class WBSReportController {
  RxList<WHReportL> wbsReportList = <WHReportL>[].obs;
  Rx<WhReporDetail> wbsReportDetailData = WhReporDetail().obs;
  RxBool load = true.obs;

  Future<List<WHReportL>?> getwbsReportList() async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {"token": token};
    try {
      print(API.getWHReportList);
      final response = await http.post(
        Uri.parse(API.getWHReportList),
        body: bodyParams,
      );

      print(response);
      print(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      if (responseBody['result'] == true) {
        WhReportListModel commonWBSReportData =
            WhReportListModel.fromJson(responseBody);
        print(commonWBSReportData);
        wbsReportList.value = commonWBSReportData.message!;
        load.value = false;
        ShowToastDialog.closeLoader();
        return wbsReportList.value;
      } else if (responseBody['result'] == false) {
        if (responseBody['message'] is String) {
          load.value = false;
          ShowToastDialog.showError(responseBody['message']);
        } else {
          Map<String, dynamic> myMap = {};
          myMap = responseBody['message'];
          Iterable<dynamic> allValues = myMap.values;
          String resultMessage =
              allValues.join(', \n').replaceAll('false,', '');
          load.value = false;
          ShowToastDialog.showError(resultMessage);
        }
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return [];
  }

  Future getWHReporDetail(String bidId) async {
    print('getWHReportDetail  $bidId');
    String token = await Preferences.getString(Preferences.accesstoken);
    Map<String, dynamic> bodyParams = {"token": token, 'bidId': bidId};
    print(token);
    wbsReportDetailData.value = WhReporDetail();
    try {
      load.value = true;

      print(API.getWHReportDetailData);
      final response = await http.post(
        Uri.parse(API.getWHReportDetailData),
        body: bodyParams,
      );

      print(response);
      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody['result']);
      print(responseBody['message']);

      if (responseBody['result'] == true) {
        WhReporDetailModel reportDetailData =
            WhReporDetailModel.fromJson(responseBody);
        print(reportDetailData.message!.aadharNo!);
        wbsReportDetailData.value = reportDetailData.message!;

        load.value = false;
      } else if (responseBody['result'] == false) {
        if (responseBody['message'] is String) {
          load.value = false;
          ShowToastDialog.showError(responseBody['message']);
        } else {
          Map<String, dynamic> myMap = {};
          myMap = responseBody['message'];
          Iterable<dynamic> allValues = myMap.values;
          String resultMessage =
              allValues.join(', \n').replaceAll('false,', '');
          load.value = false;
          ShowToastDialog.showError(resultMessage);
        }
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }
}
