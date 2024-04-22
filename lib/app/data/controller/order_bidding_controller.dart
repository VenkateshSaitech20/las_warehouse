// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/pending_controller.dart';
import 'package:las_warehouse/app/data/models/available_warehouse_Model.dart';
import 'package:las_warehouse/app/data/models/orderbidding_details_model.dart';
import 'package:las_warehouse/app/data/models/wbs_customer_requirement_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class OrderBiddingController extends GetxController {
  String? token;
  RxBool load = true.obs;
  WbsRequirementModel wbsRequirementModel = WbsRequirementModel();
  AvailableWarehousesModel availableWarehousesModel =
      AvailableWarehousesModel();
  RxList<AvailableWarehouseName> avaibleWarehouseNames =
      <AvailableWarehouseName>[].obs;
  RxList<MaterialTypeData> materialTypeList = <MaterialTypeData>[].obs;
  RxList<List<WbsRequirement>> WbsRequirementList =
      <List<WbsRequirement>>[].obs;

  OrderBiddingDetailModel orderBiddingDetailModel = OrderBiddingDetailModel();

  @override
  void onInit() {
    orderBiddingAPI();
    super.onInit();
  }
//List<WbsRequirement> getRequirementsData ()=> wbsRequirement.value;

  Future<WbsRequirementModel?> orderBiddingAPI() async {
    List<String> CityList = [];
    List<WbsRequirement> tempBookingDataList = [];
    WbsRequirementList.value = [];
    try {
      load.value = true;
      print(API.wbsCustomerRequirements);
      token = await Preferences.getString(Preferences.accesstoken);
      print(token);
      final response = await http.post(
        Uri.parse(API.wbsCustomerRequirements),
        body: {'token': token},
      );
      print(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        wbsRequirementModel = WbsRequirementModel.fromJson(responseBody);
        List<WbsRequirement> tempBidsWorkorderList =
            wbsRequirementModel.message!;
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
          WbsRequirementList.value.add(tempBookingDataList);
        }
        load.value = false;

        return wbsRequirementModel;
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
      print(error);
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return null;
  }

  Future<OrderBiddingDetailModel?> orderBiddingDetailsAPI(String reqId) async {
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.getWbsRequirements),
        body: {'token': token, 'reqId': reqId},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        orderBiddingDetailModel =
            OrderBiddingDetailModel.fromJson(responseBody);

        materialTypeList.value = List<MaterialTypeData>.from(
          json
              .decode(orderBiddingDetailModel.message!.materialTypeData!)
              .map((i) => MaterialTypeData.fromJson(i)),
        );

        load.value = false;

        return orderBiddingDetailModel;
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

  Future<Map?> confirmbidAPI(Map<String, dynamic> bodyParams) async {
    try {
      load.value = true;

      final response =
          await http.post(Uri.parse(API.vendorBid), body: bodyParams);

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast("${responseBody['message']}");
        await Get.put(OrderBiddingController()).orderBiddingAPI();
        await Get.put(PendingBidsController()).pendingBidsAPI();

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

  Future<dynamic>? deleteOrderedBidAPI(String? reqId) async {
    try {
      load.value = true;
      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.notinterestBid),
        body: {'token': token, 'reqId': reqId},
      );
      Map<String, dynamic> responsejson = json.decode(response.body);
      if (responsejson['result'] == true) {
        ShowToastDialog.showToast(responsejson['message'].toString());
        await Get.put(OrderBiddingController()).orderBiddingAPI();
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

  Future<void> reachedEntryAPI(String reqId) async {
    try {
      token = await Preferences.getString(Preferences.accesstoken);
      await http.post(
        Uri.parse(API.reachedEntry),
        body: {'token': token, 'reqId': reqId},
      );
    } catch (e) {
      load.value = false;
      ApiExceptionService().handleSocketException(e);
    }
    //return null;
  }

  Future<AvailableWarehousesModel?> avaibleWarehouseAPI(
    String? city,
    String? matType,
    String? availableWarehouse,
  ) async {
    try {
      load.value = true;

      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.availableWarehouse),
        body: {
          'token': token,
          'city': city!,
          'materialType': matType!,
          'warehouseType': availableWarehouse!,
        },
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        availableWarehousesModel =
            AvailableWarehousesModel.fromJson(responseBody);
        avaibleWarehouseNames.value = availableWarehousesModel.message!;

        load.value = false;

        return availableWarehousesModel;
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
