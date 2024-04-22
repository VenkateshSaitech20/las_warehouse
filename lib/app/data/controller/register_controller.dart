// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/screens/authentications/login_screen.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:http/http.dart' as http;
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class RegisterController extends GetxController {
  RxBool load = true.obs;
  Future<Map?> registerAPI(
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
      // print(companyName);
      // print(doe);
      // print(gstNo);
      // print(panNo);
      // print(aadharNo);
      // print(email);
      // print(password);
      // print(cpassword);
      // print(mobile);
      // print(address1);
      // print(address2);
      // print(pincode);
      // print(country);
      // print(stateName);
      // print(cityName);
      // print(_logoImage);
      // print(_gstImage);
      // print(_panImage);
      // print(_aadharImage);
      // print(agree);
      // print(cinNo);
      load.value = true;
      var request = http.MultipartRequest('POST', Uri.parse(API.register));
      request.headers['Content-type'] = "application/json; charset=utf-8";
      request.headers['Accept'] = "application/json";
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

      request.files.add(
        http.MultipartFile(
          'logo',
          File(_logoImage).readAsBytes().asStream(),
          File(_logoImage).lengthSync(),
          filename: File(_logoImage).path.split("/").last,
        ),
      );
      request.files.add(
        http.MultipartFile(
          'gstFile',
          File(_gstImage).readAsBytes().asStream(),
          File(_gstImage).lengthSync(),
          filename: File(_gstImage).path.split("/").last,
        ),
      );
      request.files.add(
        http.MultipartFile(
          'panFile',
          File(_panImage).readAsBytes().asStream(),
          File(_panImage).lengthSync(),
          filename: File(_panImage).path.split("/").last,
        ),
      );
      request.files.add(
        http.MultipartFile(
          'aadharFile',
          File(_aadharImage).readAsBytes().asStream(),
          File(_aadharImage).lengthSync(),
          filename: File(_aadharImage).path.split("/").last,
        ),
      );

      final responseReq = await request.send();
      final response = await responseReq.stream.bytesToString();

      // print(response);

      Map<String, dynamic> responseBody =
          json.decode(response) as Map<String, dynamic>;
      // print(responseBody['result']);
      // print(responseBody['message']);

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast("${responseBody['message']}");
        Get.offAll(LoginScreen());
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
