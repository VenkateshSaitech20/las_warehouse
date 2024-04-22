// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/completedOrders_model.dart';
import 'package:las_warehouse/app/data/models/completed_BidDetail_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class CompletedOrdersController extends GetxController {
  String? token;
  RxBool load = true.obs;
  CompletedOrdersModel completedOrdersModel = CompletedOrdersModel();
  RxList<List<CompletedOrdersData>> completedOrdersDataList =
      <List<CompletedOrdersData>>[].obs;
  Rx<CompletedBidDetailData> completedBidDetailData =
      Rx(CompletedBidDetailData());

  @override
  void onInit() {
    completedOrdersAPI();
    super.onInit();
  }

  Future<CompletedBidDetailModel?> completedBidDetailsAPI(String reqId) async {
    try {
      load.value = true;
      token = await Preferences.getString(Preferences.accesstoken);
      print(API.completedbidDetail);
      final response = await http.post(
        Uri.parse(API.completedbidDetail),
        body: {'token': token, 'bidId': reqId},
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        CompletedBidDetailModel completedBidDetailModel =
            CompletedBidDetailModel.fromJson(responseBody);
        completedBidDetailData.value = completedBidDetailModel.message!;
        load.value = false;

        return completedBidDetailModel;
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
    return null;
  }

  Future<Map?> confirmInvoiceAPI(String bidId) async {
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.confirmInvoice),
        body: {'token': token, 'bidId': bidId},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast(responseBody['message'].toString());

        load.value = false;

        return responseBody;
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

    return null;
  }

  Future<CompletedOrdersModel?> completedOrdersAPI() async {
    List<String> CityList = [];
    List<CompletedOrdersData> tempBookingDataList = [];
    completedOrdersDataList.value = [];
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.completedorders),
        body: {'token': token},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        completedOrdersModel = CompletedOrdersModel.fromJson(responseBody);
        List<CompletedOrdersData> tempBidsWorkorderList =
            completedOrdersModel.message!;
        for (int n = 0; n < tempBidsWorkorderList.length; n++) {
          if (CityList.contains(tempBidsWorkorderList[n].city)) {
          } else {
            CityList.add(tempBidsWorkorderList[n].city!);
          }
        }

        for (int n = 0; n < CityList.length; n++) {
          tempBookingDataList = [];
          for (int i = 0; i < tempBidsWorkorderList.length; i++) {
            tempBookingDataList = tempBidsWorkorderList
                .where((i) => i.city == CityList[n])
                .toList();
          }
          completedOrdersDataList.value.add(tempBookingDataList);
        }
        load.value = false;
        return completedOrdersModel;
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
    return null;
  }

  Future<CommonModel?> uploadInvoicePdfAPI(
    String? bidId,
    String? podFile,
  ) async {
    print(bidId);
    try {
      load.value = true;

      String token = await Preferences.getString('accesstoken');

      print(API.uploadInvoice);

      var request = http.MultipartRequest('POST', Uri.parse(API.uploadInvoice));

      request.headers['Content-type'] = "application/json; charset=utf-8";
      request.headers['Accept'] = "application/json";

      request.fields['token'] = token;
      request.fields['bidId'] = bidId!;

      request.fields['mobType'] = 'true';

      if (podFile != '') {
        request.files.add(
          http.MultipartFile(
            'invoiceDoc',
            File(podFile!).readAsBytes().asStream(),
            File(podFile).lengthSync(),
            filename: File(podFile).path.split("/").last,
          ),
        );
      }
      ;
      //url now changed right

      print(request);
      final responseReq = await request.send();
      final response = await responseReq.stream.bytesToString();

      Map<String, dynamic> responseBody =
          json.decode(response) as Map<String, dynamic>;
      print(responseBody['result']);
      print(responseBody['message']);

      if (responseBody['result'] == true) {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(responseBody['message']);

        await Get.put(CompletedOrdersController()).completedOrdersAPI();
        return CommonModel.fromJson(responseBody);
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
    return null;
  }
}
