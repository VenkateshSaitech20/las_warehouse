import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart' hide Response, FormData, MultipartFile;
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/models/cities_model.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class Citiescontroller extends GetxController {
  RxList<Citiesmodel> citiesData = <Citiesmodel>[].obs;

  RxBool load = true.obs;

  @override
  void onInit() {
    stateCityAPI();
    super.onInit();
  }

  Future stateCityAPI() async {
    try {
      //ShowToastDialog.showLoader("Please wait");

      var url = Uri.parse(
        API.cities,
      );
      var response = await http.get(url);
      final responseJson = json.decode(response.body);
      if (response.statusCode == 200) {
        ShowToastDialog.showToast('Registration Successful');
        citiesData.value = List<Citiesmodel>.from(
          responseJson.map((i) => Citiesmodel.fromJson(i)),
        );
        ShowToastDialog.closeLoader();
        load.value = false;
        return null;
      } else if (responseJson['result'] == 'update') {
        ShowToastDialog.showToast(responseJson['message']);
      } else if (responseJson['result'] == "false") {
        ShowToastDialog.showError(responseJson['message']);
      }
    } catch (error) {
      load.value = false;
      ApiExceptionService().handleSocketException(error);
    }
  }
}
