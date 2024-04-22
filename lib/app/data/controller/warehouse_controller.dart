import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/warehouseDetail_model.dart';
import 'package:las_warehouse/app/data/models/warehouselist_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class WarehouseController extends GetxController {
  RxBool load = true.obs;
  WarehouseListModel warehouseListModel = WarehouseListModel();
  RxList<WarehouseListData> warehouseListData = <WarehouseListData>[].obs;
  Rx<WarehouseDetailModel> warehouseDetailModel = WarehouseDetailModel().obs;
  @override
  void onInit() {
    warehouselistAPI();
    super.onInit();
  }

  Future<Map?> addWarehouseAPI(
    String? whName,
    String? WhshortName,
    String? WhTypes,
    String? whcategory,
    num? totLand,
    String? storageCharges,
    String? handlingCharges,
    int? yearBuilt,
    int? builtup,
    String? matTypes,
    String? location,
    String? amenities,
    String? services,
    String? workdays,
    String? Latitude,
    String? longitude,
    String? whlogo,
    String? leasecertificate,
    String? firesafecertificate,
    String? buildcertificate,
    String? envcertificate,
    String? insucertificate,
    String? shopcertificate,
    String? labourcertificate,
    List<String>? yardfiles,
    List<String>? gatefiles,
    List<String>? dockfiles,
    List<String>? equipmentsfiles,
  ) async {
    String token = await Preferences.getString(Preferences.accesstoken);

    print(API.addWarehouse);
    print(whName);
    print(WhshortName);
    print(WhTypes);
    print(whcategory);
    print(totLand);
    print(storageCharges);
    print(handlingCharges);
    print(yearBuilt);
    print(builtup);
    print(matTypes);
    print(location);
    print(amenities);
    print(services);
    print(workdays);
    print(Latitude);
    print(longitude);
    print(whlogo);
    print(leasecertificate);
    print(firesafecertificate);
    print(buildcertificate);
    print(envcertificate);
    print(insucertificate);
    print(shopcertificate);
    print(labourcertificate);
    print(yardfiles);
    print(gatefiles);
    print(dockfiles);
    print(equipmentsfiles);
    try {
      load.value = true;
      var request = http.MultipartRequest('POST', Uri.parse(API.addWarehouse));
      request.headers['Content-type'] = "application/json; charset=utf-8";
      request.headers['Accept'] = "application/json";
      request.fields['token'] = token;
      request.fields['warehouseName'] = whName!;
      request.fields['shortName'] = WhshortName!;
      request.fields['warehouseType'] = WhTypes!;
      request.fields['totalLand'] = totLand!.toString();
      request.fields['storageCharges'] = storageCharges!;
      request.fields['handlingCharges'] = handlingCharges!;
      request.fields['yearBuilt'] = yearBuilt.toString();
      request.fields['workingDays'] = workdays!.toString();
      request.fields['cityLocation'] = location!;
      request.fields['builtUp'] = builtup.toString();
      request.fields['warehouseCategory'] = whcategory!;
      request.fields['materialTypes'] = matTypes!;
      request.fields['amenities'] = amenities!.toString();
      request.fields['warehouseServices'] = services!.toString();
      request.fields['workingDays'] = workdays;
      request.fields['latitude'] = Latitude!;
      request.fields['longitude'] = longitude!;
      request.fields['mobType'] = 'true';

      request.files.add(
        http.MultipartFile(
          'warehouseLogo',
          File(whlogo!).readAsBytes().asStream(),
          File(whlogo).lengthSync(),
          filename: File(whlogo).path.split("/").last,
        ),
      );
      if (leasecertificate != null) {
        request.files.add(
          http.MultipartFile(
            'leaseRentalAgreement',
            File(leasecertificate).readAsBytes().asStream(),
            File(leasecertificate).lengthSync(),
            filename: File(leasecertificate).path.split("/").last,
          ),
        );
      }
      if (firesafecertificate != null) {
        request.files.add(
          http.MultipartFile(
            'fireSafetyCertificate',
            File(firesafecertificate).readAsBytes().asStream(),
            File(firesafecertificate).lengthSync(),
            filename: File(firesafecertificate).path.split("/").last,
          ),
        );
      }
      if (buildcertificate != null) {
        request.files.add(
          http.MultipartFile(
            'buildingPlanApproved',
            File(buildcertificate).readAsBytes().asStream(),
            File(buildcertificate).lengthSync(),
            filename: File(buildcertificate).path.split("/").last,
          ),
        );
      }
      if (envcertificate != null) {
        request.files.add(
          http.MultipartFile(
            'environmentalClearance',
            File(envcertificate).readAsBytes().asStream(),
            File(envcertificate).lengthSync(),
            filename: File(envcertificate).path.split("/").last,
          ),
        );
      }
      if (insucertificate != null) {
        request.files.add(
          http.MultipartFile(
            'insuranceDocument',
            File(insucertificate).readAsBytes().asStream(),
            File(insucertificate).lengthSync(),
            filename: File(insucertificate).path.split("/").last,
          ),
        );
      }
      if (shopcertificate != null) {
        request.files.add(
          http.MultipartFile(
            'shopLicenseDocument',
            File(shopcertificate).readAsBytes().asStream(),
            File(shopcertificate).lengthSync(),
            filename: File(shopcertificate).path.split("/").last,
          ),
        );
      }
      if (labourcertificate != null) {
        request.files.add(
          http.MultipartFile(
            'labourLicenseDocument',
            File(labourcertificate).readAsBytes().asStream(),
            File(labourcertificate).lengthSync(),
            filename: File(labourcertificate).path.split("/").last,
          ),
        );
      }

      if (yardfiles != []) {
        for (int i = 0; i < yardfiles!.length; i++) {
          var file = await http.MultipartFile.fromPath(
            'yardPhotos',
            yardfiles[i],
          );
          request.files.add(file);
        }
      }
      if (gatefiles != []) {
        for (int i = 0; i < gatefiles!.length; i++) {
          var file = await http.MultipartFile.fromPath(
            'gatePhotos',
            gatefiles[i],
          );
          request.files.add(file);
        }
      }
      if (dockfiles != []) {
        for (int i = 0; i < dockfiles!.length; i++) {
          var file = await http.MultipartFile.fromPath(
            'dockingArea',
            dockfiles[i],
          );
          request.files.add(file);
        }
      }
      if (equipmentsfiles != []) {
        for (int i = 0; i < equipmentsfiles!.length; i++) {
          var file = await http.MultipartFile.fromPath(
            'whEquipmentPhotos',
            equipmentsfiles[i],
          );
          request.files.add(file);
        }
      }

      print('request.files');

      for (var fil in request.files) {
        print(fil.contentType);
        print(fil.filename);
        print(fil.field);
        print(fil.length);
      }
      final responseReq = await request.send();
      final response = await responseReq.stream.bytesToString();
      print('add wH response');
      print(response);

      Map<String, dynamic> responseBody =
          json.decode(response) as Map<String, dynamic>;

      if (responseBody['result'] == true) {
        ShowToastDialog.showToast("${responseBody['message']}");
        await Get.find<WarehouseController>().warehouselistAPI();

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
      print(error.toString());
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return null;
  }

  Future<List<WarehouseListData>> warehouselistAPI() async {
    String token = await Preferences.getString(Preferences.accesstoken);
    try {
      load.value = true;
      var response =
          await http.post(Uri.parse(API.warehouseList), body: {'token': token});
      var responsejson = json.decode(response.body);
      if (responsejson['result'] == true) {
        warehouseListModel = WarehouseListModel.fromJson(responsejson);
        warehouseListData.value = warehouseListModel.message!;

        load.value = false;

        return warehouseListData;
      } else if (responsejson['result'] == false) {
        load.value = false;
        ShowToastDialog.showError(
          json.encode(responsejson['message']).toString(),
        );
      }
    } catch (e) {
      load.value = false;

      ApiExceptionService().handleSocketException(e);
    }
    return [];
  }

  Future<WarehouseDetailModel?> warehouseDetailsAPI(String whId) async {
    final String token = await Preferences.getString(Preferences.accesstoken);
    try {
      load.value = true;

      var response = await http.post(
        Uri.parse(API.warehouseDetails),
        body: {'token': token, 'whId': whId},
      );
      var responsejson = json.decode(response.body);
      if (responsejson['result'] == true) {
        warehouseDetailModel.value =
            WarehouseDetailModel.fromJson(responsejson);
        load.value = false;

        return warehouseDetailModel.value;
      } else if (responsejson['result'] == false) {
        load.value = false;

        ShowToastDialog.showToast(
          json.encode(responsejson['message']).toString(),
        );
      }
    } catch (e) {
      load.value = false;
      ApiExceptionService().handleSocketException(e);
    }
    return null;
  }

  Future<dynamic>? deleteWarehouseAPI(String? whId) async {
    String token = await Preferences.getString(Preferences.accesstoken);
    try {
      load.value = true;
      final response = await http.post(
        Uri.parse(API.deleteWarehouse),
        body: {'token': token, 'whId': whId},
      );
      Map<String, dynamic> responsejson = json.decode(response.body);
      if (responsejson['result'] == true) {
        ShowToastDialog.showToast(responsejson['message'].toString());
        await Get.put(WarehouseController()).warehouselistAPI();
        load.value = false;

        return responsejson;
      } else if (responsejson['result'] == false) {
        load.value = false;
        ShowToastDialog.showError(
          json.encode(responsejson['message']).toString(),
        );
      }
    } catch (e) {
      load.value = false;
      ApiExceptionService().handleSocketException(e);
    }
    return null;
  }
}
