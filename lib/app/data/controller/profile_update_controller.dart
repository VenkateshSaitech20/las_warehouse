import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/common_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class ProfileUpdateController extends GetxController {
  RxBool load = true.obs;
  Future<Map?> updateProfileDataAPI(
    companyName,
    doe,
    gstNo,
    panNo,
    aadharNo,
    email,
    password,
    cpassword,
    mobile,
    address1,
    address2,
    pincode,
    country,
    stateName,
    cityName,
    String _logoImage,
    String _gstImage,
    String _panImage,
    String _aadharImage,
    String agree,
    String cinNo,
  ) async {
    try {
      load.value = true;
      final String token = await Preferences.getString(Preferences.accesstoken);
      var request = http.MultipartRequest('POST', Uri.parse(API.updateProfile));
      request.headers['Content-type'] = "application/json; charset=utf-8";
      request.headers['Accept'] = "application/json";

      request.fields['token'] = token;
      request.fields['vendorName'] = companyName;
      request.fields['doe'] = doe;
      request.fields['gstNo'] = gstNo;
      request.fields['panNo'] = panNo;
      request.fields['aadharNo'] = aadharNo;
      request.fields['email'] = email;
      request.fields['password'] = password;
      request.fields['confirmPassword'] = cpassword;
      request.fields['phone'] = mobile;
      request.fields['address1'] = address1;
      request.fields['address2'] = address2;
      request.fields['pincode'] = pincode;
      request.fields['country'] = country;
      request.fields['state'] = stateName;
      request.fields['city'] = cityName;
      request.fields['mobType'] = "true";
      request.fields['termsAgree'] = agree;
      request.fields['cinNo'] = cinNo;

      if (_logoImage != '') {
        request.files.add(
          http.MultipartFile(
            'logo',
            File(_logoImage).readAsBytes().asStream(),
            File(_logoImage).lengthSync(),
            filename: File(_logoImage).path.split("/").last,
          ),
        );
      }
      if (_gstImage != '') {
        request.files.add(
          http.MultipartFile(
            'gstFile',
            File(_gstImage).readAsBytes().asStream(),
            File(_gstImage).lengthSync(),
            filename: File(_gstImage).path.split("/").last,
          ),
        );
      }
      if (_panImage != '') {
        request.files.add(
          http.MultipartFile(
            'panFile',
            File(_panImage).readAsBytes().asStream(),
            File(_panImage).lengthSync(),
            filename: File(_panImage).path.split("/").last,
          ),
        );
      }
      if (_aadharImage != '') {
        request.files.add(
          http.MultipartFile(
            'aadharFile',
            File(_aadharImage).readAsBytes().asStream(),
            File(_aadharImage).lengthSync(),
            filename: File(_aadharImage).path.split("/").last,
          ),
        );
      }
      final responseReq = await request.send();
      final response = await responseReq.stream.bytesToString();
      Map<String, dynamic> responseBody =
          json.decode(response) as Map<String, dynamic>;
      if (responseBody['result'] == true) {
        ShowToastDialog.showToast(
          json.encode(responseBody['message']).toString(),
        );
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

  Future<CommonModel?> changePasswordAPI(currentPass, newPass, confPass) async {
    String token = await Preferences.getString('accesstoken');
    print(token);
    Map<String, dynamic> bodyParams = {
      "token": token,
      "curPassword": currentPass,
      "password": newPass,
      "confirmPassword": confPass,
    };
    try {
      load.value = true;
      print(API.changePassword);
      final response = await http.post(
        Uri.parse(API.changePassword),
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
