import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/termsnConditions_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class TermsnConditionsController extends GetxController {
  String? token;
  RxBool load = true.obs;
  Rx<TermsDetails> termsDetails = TermsDetails().obs;

  @override
  void onInit() {
    getTermsnConditionsAPI();
    super.onInit();
  }

  Future<TermsnConditionsModel?> getTermsnConditionsAPI() async {
    try {
      load.value = true;
      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.getTermsnConditions),
        body: {'token': token},
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        TermsnConditionsModel termsnConditionsModel =
            TermsnConditionsModel.fromJson(responseBody);
        termsDetails.value = termsnConditionsModel.message ?? TermsDetails();

        load.value = false;

        return termsnConditionsModel;
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
    } catch (e) {
      load.value = false;
      ShowToastDialog.closeLoader();
      ApiExceptionService().handleSocketException(e);
    }
    return null;
  }

  Future<dynamic> addTermsnConditionsAPI(String termsConditions) async {
    try {
      load.value = true;
      token = await Preferences.getString(Preferences.accesstoken);
      final response = await http.post(
        Uri.parse(API.addTermsnConditions),
        body: {'token': token, 'termsConditions': termsConditions},
      );
      Map<String, dynamic> responseBody = json.decode(response.body);
      if (responseBody['result'] == true) {
        Get.put(TermsnConditionsController()).getTermsnConditionsAPI();
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
}
