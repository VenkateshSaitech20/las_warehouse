// ignore_for_file: invalid_use_of_protected_member

import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/control_tower_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class ControlTowerController {
  RxList<ControlTower> controlTowerWHList = <ControlTower>[].obs;
  RxBool load = true.obs;

  Future<List<ControlTower>?> getControlTowerWarehouseList() async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {"token": token};
    try {
      print(API.controlTowerAPI);
      final response = await http.post(
        Uri.parse(API.controlTowerAPI),
        body: bodyParams,
      );

      print(response);
      print(response.body);
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        ControlTowerModel commoncontrolTowerData =
            ControlTowerModel.fromJson(responseBody);
        controlTowerWHList.value = commoncontrolTowerData.message!;
        load.value = false;
        ShowToastDialog.closeLoader();
        return controlTowerWHList.value;
      } else if (responseBody['result'] == false) {
        controlTowerWHList.value = [];
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
      controlTowerWHList.value = [];
      ApiExceptionService().handleSocketException(error);
    }
    return null;
  }
}
