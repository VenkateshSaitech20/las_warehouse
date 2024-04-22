import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/dashboard_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class DashboardDataController extends GetxController {
  Rx<DashBoardDetails> DashData = DashBoardDetails().obs;
  RxBool load = true.obs;

  @override
  void onInit() {
    getDashDataAPI();
    super.onInit();
  }

  Future<DashBoardDetails?> getDashDataAPI() async {
    String token = await Preferences.getString(Preferences.accesstoken);
    Map<String, dynamic> bodyParams = {"token": token};
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.dashboard),
        body: bodyParams,
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        DashboardModel allDashData = DashboardModel.fromJson(responseBody);

        DashData.value = allDashData.message!;
        load.value = false;
        ShowToastDialog.closeLoader();
        return allDashData.message;
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
