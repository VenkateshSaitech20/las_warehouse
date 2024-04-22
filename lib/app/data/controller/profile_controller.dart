import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class ProfileController extends GetxController {
  Rx<User> profileData = User().obs;
  RxBool load = false.obs;
  UserModel allUserData = UserModel();

  Future<UserModel?> getProfileDataAPI() async {
    print("getProfileDataAPI load");
    String token = await Preferences.getString(Preferences.accesstoken);
    Map<String, dynamic> bodyParams = {"token": token};
    print(API.viewProfile);
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.viewProfile),
        body: bodyParams,
      );

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody['result'] == true) {
        allUserData = UserModel.fromJson(responseBody);

        Preferences.save("userdata", allUserData.message!);
        Constant.userData = allUserData.message!;
        // example = await Preferences.loadSharedPrefs();

        profileData.value = allUserData.message!;

        load.value = false;
        ShowToastDialog.closeLoader();
        return allUserData;
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
