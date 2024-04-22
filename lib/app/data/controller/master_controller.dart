import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:las_warehouse/app/data/models/warehouse_category_model.dart';
import 'package:las_warehouse/app/data/models/warehouse_services_model.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/amenity_model.dart';
import 'package:las_warehouse/app/data/models/material_type_model.dart';
import 'package:las_warehouse/app/data/models/payment_type_model.dart';
import 'package:las_warehouse/app/data/models/timing_model.dart';
import 'package:las_warehouse/app/data/models/warehouse_types_model.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class MasterController extends GetxController {
  RxBool load = true.obs;
  RxList<WareHouseType> wareHouseTypeData = <WareHouseType>[].obs;
  RxList<MaterialTypeModel> materialTypeData = <MaterialTypeModel>[].obs;

  RxList<AmenityType> amenityType = <AmenityType>[].obs;

  RxList<WHCategory> whCategoriesList = <WHCategory>[].obs;
  RxList<WHService> whServicesList = <WHService>[].obs;

  RxList<Timings> timingType = <Timings>[].obs;

  RxList<String> amenitylist = <String>[].obs;
  RxList<String> timinglist = <String>[].obs;

  RxList<String> cityLocationList = <String>[].obs;
  RxList<PaymentType> paymentTypesList = <PaymentType>[].obs;

  @override
  void onInit() {
    warehousetypeAPI();
    materialtypeAPI();
    amenityAPI();
    timingAPI();
    cityLocationAPI();
    paymentTypesAPI();
    warehouseCategoriesAPI();
    warehouseServicesAPI();
    super.onInit();
  }

  Future warehousetypeAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.warehousetypes,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        wareHouseTypeData.value = List<WareHouseType>.from(
          responseJson.map((i) => WareHouseType.fromJson(i)),
        );

        load.value = false;
        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;
        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future materialtypeAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.materialtypes,
      );
      var response = await http.get(url);
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        materialTypeData.value = List<MaterialTypeModel>.from(
          responseJson.map((i) => MaterialTypeModel.fromJson(i)),
        );
        load.value = false;
        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;
        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;
        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future amenityAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.amenity,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        amenityType.value = List<AmenityType>.from(
          responseJson.map((i) => AmenityType.fromJson(i)),
        );
        amenityType.forEach((element) {
          amenitylist.add(element.amenity!);
        });
        load.value = false;

        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;

        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future timingAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.timing,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        timingType.value = List<Timings>.from(
          responseJson.map((i) => Timings.fromJson(i)),
        );

        timingType.sort(
          (a, b) => int.parse(a.sequence!).compareTo(int.parse(b.sequence!)),
        );
        timingType.forEach((element) {
          timinglist.add(element.timing!);
        });
        load.value = false;

        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;

        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future cityLocationAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.cityLocation,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        cityLocationList.value =
            (jsonDecode(response.body) as List<dynamic>).cast<String>();

        load.value = false;

        return null;
      } else if (responseJson['result'] == 'update') {
        //load.value = false;

        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        ///load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future<List<PaymentType>?> paymentTypesAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.paymentTypes,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        paymentTypesList.value = List<PaymentType>.from(
          responseJson.map((i) => PaymentType.fromJson(i)),
        );

        load.value = false;
        ShowToastDialog.closeLoader();
        return paymentTypesList;
      } else if (responseJson['result'] == 'update') {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;
        ShowToastDialog.closeLoader();
        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    return [];
  }

  Future warehouseCategoriesAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.wbsCategoriesList,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        whCategoriesList.value = List<WHCategory>.from(
          responseJson.map((i) => WHCategory.fromJson(i)),
        );

        load.value = false;

        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;

        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }

  Future warehouseServicesAPI() async {
    try {
      load.value = true;
      var url = Uri.parse(
        API.wbsServicesList,
      );
      var response = await http.get(url);

      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        whServicesList.value = List<WHService>.from(
          responseJson.map((i) => WHService.fromJson(i)),
        );

        load.value = false;

        return null;
      } else if (responseJson['result'] == 'update') {
        load.value = false;

        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        load.value = false;

        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }
}
