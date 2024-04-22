import 'dart:async';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/settings_model.dart';

class SettingsController extends GetxController {
  @override
  Future<void> onInit() async {
    await getSettingsData().then((value) {
      if (value!.success == 'success') {}
    });
    super.onInit();
  }

  Future<SettingsModel?> getSettingsData() async {
    return SettingsModel(
      success: 'success',
      error: 'false',
      message: 'Successs',
      data: Data(),
    );
  }
}
