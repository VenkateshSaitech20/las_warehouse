import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/data/models/user_role_master_model.dart';
import 'package:las_warehouse/app/data/models/user_role_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class UserRoleController extends GetxController {
  RxList<UserRole> interUsersRoleList = <UserRole>[].obs;
  RxList<UserRoleMaster> userRoleMenusList = <UserRoleMaster>[].obs;

  RxBool load = true.obs;

  @override
  void onInit() {
    getUserRolesListAPI();
    getUserRoleMasterAPI();
    super.onInit();
  }

  Future<List<UserRoleMaster>?> getUserRoleMasterAPI() async {
    try {
      load.value = true;

      var url = Uri.parse(API.getInterUserRoleMenusAPI);
      print("fn inside");
      print(url);
      var response = await http.get(url);

      print("Response status  User Role Menu: ${response.statusCode}");
      print('Response status  User Role Menu: ${response.body}\n\n');

      final responseJson = json.decode(response.body);
      if (responseJson['result'] == true) {
        UserRoleMasterModel commonMenuListData =
            UserRoleMasterModel.fromJson(responseJson);
        userRoleMenusList.value = commonMenuListData.message!;
        load.value = false;
        ShowToastDialog.closeLoader();
        return userRoleMenusList;
      } else if (responseJson['result'] == false) {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return null;
  }

  Future<List<UserRole>?> getUserRolesListAPI() async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {"token": token};
    try {
      ShowToastDialog.showLoader("Please wait");
      print(API.getInterUserRolesAPI);
      final response = await http.post(
        Uri.parse(API.getInterUserRolesAPI),
        body: bodyParams,
      );

      print(response);
      print(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        UserRoleModel commonListData = UserRoleModel.fromJson(responseBody);
        interUsersRoleList.value = commonListData.message!;
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

  Future<CommonModel?> addUserRoleAPI(
    String userRoleId,
    String userRole,
    String menuString,
  ) async {
    Map<String, dynamic> bodyParams = {};
    String token = await Preferences.getString('accesstoken');
    print(token);
    if (userRoleId != '') {
      bodyParams = {
        "token": token,
        "userRoleId": userRoleId,
        "userRole": userRole,
        "menus": menuString,
      };
    } else {
      bodyParams = {
        "token": token,
        "userRoleId": userRoleId,
        "userRole": userRole,
        "menus": menuString,
      };
    }

    try {
      ShowToastDialog.showLoader("Please wait");
      print(API.addUserRoleAPI);
      final response = await http.post(
        Uri.parse(API.addUserRoleAPI),
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
        await Get.put(UserRoleController()).getUserRolesListAPI();
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

  Future<CommonModel?> removeUserRoleAPI(String userRoleId) async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {
      "token": token,
      "userRoleId": userRoleId,
    };
    try {
      ShowToastDialog.showLoader("Please wait");
      print(API.deleteUserRoleAPI);
      final response = await http.post(
        Uri.parse(API.deleteUserRoleAPI),
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
        await Get.put(UserRoleController()).getUserRolesListAPI();
        ShowToastDialog.showToast(responseBody['message']);
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
