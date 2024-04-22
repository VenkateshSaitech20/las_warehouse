// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/data/models/workorder_chatmodel.dart';
import 'package:las_warehouse/app/data/models/workorders_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class WorkOrderController extends GetxController {
  String? token;
  RxBool load = true.obs;
  WorkOrdersModel workOrdersModel = WorkOrdersModel();
  RxList<List<WorkOrdersData>> workOrdersDataList =
      <List<WorkOrdersData>>[].obs;
  RxList<WorkorderChat> workorderchatHistory = <WorkorderChat>[].obs;

  @override
  void onInit() {
    workOrdersListAPI();
    super.onInit();
  }

  Future<WorkOrdersModel?> workOrdersListAPI() async {
    List<String> CityList = [];
    List<WorkOrdersData> tempBookingDataList = [];
    workOrdersDataList.value = [];
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.workorders),
        body: {'token': token},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        workOrdersModel = WorkOrdersModel.fromJson(responseBody);
        List<WorkOrdersData> tempBidsWorkorderList = workOrdersModel.message!;
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
          workOrdersDataList.value.add(tempBookingDataList);
        }
        load.value = false;

        return workOrdersModel;
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

  Future<Map?> checkoutAPI(String bidId) async {
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.checkoutOrder),
        body: {'token': token, 'bidId': bidId},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast(responseBody['message'].toString());
        await Get.put(WorkOrderController()).workOrdersListAPI();
        await Get.put(CompletedOrdersController()).completedOrdersAPI();

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

  Future<CommonModel?> downloadWorkorderAPI(String bidId) async {
    String token = await Preferences.getString(Preferences.accesstoken);
    Map<String, dynamic> bodyParams = {"token": token, "bidId": bidId};
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.downloadWorkorder),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        CommonModel commonData = CommonModel.fromJson(responseBody);

        load.value = false;

        return commonData;
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

  Future<CommonModel?> downloadInvoiceAPI(String bidId) async {
    String token = await Preferences.getString(Preferences.accesstoken);
    Map<String, dynamic> bodyParams = {"token": token, "bidId": bidId};
    try {
      load.value = true;

      final response = await http.post(
        Uri.parse(API.downloadInvoice),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        CommonModel commonData = CommonModel.fromJson(responseBody);

        load.value = false;

        return commonData;
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

  Future<WorkorderChatModel?> workorderBidNegotiationsAPI(String bidId) async {
    String token = await Preferences.getString('accesstoken');
    Map<String, dynamic> bodyParams = {"token": token, "bidId": bidId};
    workorderchatHistory.value = [];
    try {
      load.value = true;

      final response = await http.post(
        Uri.parse(API.workordersnegotiations),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.closeLoader();
        WorkorderChatModel chatModelData =
            WorkorderChatModel.fromJson(responseBody);
        workorderchatHistory.value = chatModelData.message!;

        load.value = false;
        return chatModelData;
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

  Future<CommonModel?> workorderBidNegotiationEntryAPI(
    String bidId,
    String message,
  ) async {
    String token = await Preferences.getString('accesstoken');
    Map<String, dynamic> bodyParams = {
      "token": token,
      "bidId": bidId,
      "message": message,
    };
    try {
      load.value = true;

      final response = await http.post(
        Uri.parse(API.workordersnegotiationsEntry),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        await Get.put(WorkOrderController()).workorderBidNegotiationsAPI(bidId);
        load.value = false;
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

  Future<CommonModel?> workorderBidPriceConfirmAPI(
    bidId,
    String finalPrice,
  ) async {
    String token = await Preferences.getString('accesstoken');
    Map<String, dynamic> bodyParams = {
      "token": token,
      "bidId": bidId,
      "finalPrice": finalPrice,
    };
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.workorderspriceConfirm),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast(responseBody['message']);

        await Get.put(WorkOrderController()).workOrdersListAPI();
        load.value = false;
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

  Future<CommonModel?> uploadWONegotiationAttachment(
    String? bidId,
    String? attachment,
  ) async {
    print(bidId);
    try {
      load.value = true;

      String token = await Preferences.getString('accesstoken');

      print(API.WOBidNegotiationsAttachmentUploadAPI);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(API.WOBidNegotiationsAttachmentUploadAPI),
      );

      request.headers['Content-type'] = "application/json; charset=utf-8";
      request.headers['Accept'] = "application/json";

      request.fields['token'] = token;
      request.fields['bidId'] = bidId!;

      request.fields['mobType'] = 'true';

      if (attachment != '') {
        request.files.add(
          http.MultipartFile(
            'attachment',
            File(attachment!).readAsBytes().asStream(),
            File(attachment).lengthSync(),
            filename: File(attachment).path.split("/").last,
          ),
        );
      }
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
        await Get.put(WorkOrderController()).workorderBidNegotiationsAPI(bidId);
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
