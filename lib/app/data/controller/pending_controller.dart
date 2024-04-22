// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/chatmodel_data.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/data/models/pendingbids_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class PendingBidsController extends GetxController {
  String? token;
  RxBool load = true.obs;
  PendingBidsModel pendingBidsModel = PendingBidsModel();
  RxList<PendingBidsData> pendingBidsData = <PendingBidsData>[].obs;
  RxList<Chat> chatHistory = <Chat>[].obs;
  RxList<List<PendingBidsData>> pendingBidsDataList =
      <List<PendingBidsData>>[].obs;

  @override
  void onInit() {
    pendingBidsAPI();
    super.onInit();
  }

  Future<PendingBidsModel?> pendingBidsAPI() async {
    List<String> CityList = [];
    List<PendingBidsData> tempBookingDataList = [];
    pendingBidsDataList.value = [];
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.pendingBids),
        body: {'token': token},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        pendingBidsModel = PendingBidsModel.fromJson(responseBody);
        List<PendingBidsData> tempBidsWorkorderList = pendingBidsModel.message!;
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
          pendingBidsDataList.value.add(tempBookingDataList);
        }
        load.value = false;
        return pendingBidsModel;
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

  Future<dynamic>? cancelBidAPI(String? bidId) async {
    try {
      load.value = true;
      token = await Preferences.getString(Preferences.accesstoken);

      final response = await http.post(
        Uri.parse(API.cancelBid),
        body: {'token': token, 'bidId': bidId},
      );
      Map<String, dynamic> responsejson = json.decode(response.body);
      if (responsejson['result'] == true) {
        ShowToastDialog.showToast(responsejson['message'].toString());
        await Get.put(PendingBidsController()).pendingBidsAPI();
        load.value = false;
        return responsejson;
      } else if (responsejson['result'] == false) {
        load.value = false;
        ShowToastDialog.showError(
          json.encode(responsejson['message']).toString(),
        );
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return null;
  }

  Future<ChatModelData?> BidNegotiationsAPI(String bidId) async {
    String token = await Preferences.getString('accesstoken');
    Map<String, dynamic> bodyParams = {"token": token, "bidId": bidId};
    chatHistory.value = [];
    try {
      load.value = true;
      load.value = true;
      final response = await http.post(
        Uri.parse(API.wbsBidNegotiations),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.closeLoader();
        ChatModelData chatModelData = ChatModelData.fromJson(responseBody);
        chatHistory.value = chatModelData.message!;
        await Get.put(PendingBidsController()).pendingBidsAPI();
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

  Future<CommonModel?> bidNegotiationEntryAPI(
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
        Uri.parse(API.negotiationsEntry),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        await Get.put(PendingBidsController()).BidNegotiationsAPI(bidId);
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

  Future<CommonModel?> bidPriceConfirmAPI(bidId, String finalPrice) async {
    String token = await Preferences.getString('accesstoken');
    Map<String, dynamic> bodyParams = {
      "token": token,
      "bidId": bidId,
      "finalPrice": finalPrice,
    };
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.bidPriceConfirm),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast(responseBody['message']);

        await Get.put(PendingBidsController()).pendingBidsAPI();
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

  Future<CommonModel?> uploadNegotiationAttachment(
    String? bidId,
    String? attachment,
  ) async {
    print(bidId);
    try {
      load.value = true;

      String token = await Preferences.getString('accesstoken');

      print(API.BidNegotiationsAttachmentUploadAPI);

      var request = http.MultipartRequest(
        'POST',
        Uri.parse(API.BidNegotiationsAttachmentUploadAPI),
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
        await Get.put(PendingBidsController()).BidNegotiationsAPI(bidId);
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
