import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/loginmodel.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class LoginController extends GetxController {
  RxBool load = false.obs;
  RxBool masterRes = true.obs;
  final ApiExceptionService apiExceptionService = ApiExceptionService();
  Future<LoginModel?> loginAPI(Map<String, dynamic> bodyParams) async {
    try {
      final response = await http.post(
        Uri.parse(API.userLogin),
        body: bodyParams,
      );

      print(response);
      print(response.body);

      Map<String, dynamic> responseBody = json.decode(response.body);
      print(responseBody['result']);
      print(responseBody['message']);

      if (responseBody['result'] == true) {
        ShowToastDialog.closeLoader();
        return LoginModel.fromJson(responseBody);
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
}
