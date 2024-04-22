import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/data/models/internal_user_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class UserController extends GetxController {
  RxList<InterUser> interUsersList = <InterUser>[].obs;
  RxBool load = true.obs;

  @override
  void onInit() {
    getInterUsersListAPI();
    super.onInit();
  }

  Future<List<InterUser>?> getInterUsersListAPI() async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {"token": token};
    try {
      print(API.getInterUsersAPI);
      final response = await http.post(
        Uri.parse(API.getInterUsersAPI),
        body: bodyParams,
      );

      print(response);
      print(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        InterUserModel commonListData = InterUserModel.fromJson(responseBody);
        interUsersList.value = commonListData.message!;
        load.value = false;
        ShowToastDialog.closeLoader();
        return commonListData.message!;
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

  Future<CommonModel?> addUserAPI(
    String userId,
    String actorName,
    String phone,
    String email,
    String userRoleId,
  ) async {
    Map<String, dynamic> bodyParams = {};
    String token = await Preferences.getString('accesstoken');
    print(token);
    bodyParams = {
      "token": token,
      "userId": userId,
      "actorName": actorName,
      "phone": phone,
      "email": email,
      "userRoleId ": userRoleId,
    };

    try {
      print(API.addUserAPI);
      final response = await http.post(
        Uri.parse(API.addUserAPI),
        body: bodyParams,
      );

      print(response);
      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody['result']);
      print(responseBody['message']);

      if (responseBody['result'] == true) {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(responseBody['message']);
        await Get.put(UserController()).getInterUsersListAPI();
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

  Future<CommonModel?> removeUserAPI(String userId) async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {"token": token, "userId": userId};
    try {
      print(API.deleteUserAPI);
      final response = await http.post(
        Uri.parse(API.deleteUserAPI),
        body: bodyParams,
      );

      print(response);
      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody['result']);
      print(responseBody['message']);

      if (responseBody['result'] == true) {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(responseBody['message']);
        await Get.put(UserController()).getInterUsersListAPI();
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
