import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

class ShowToastDialog {
  static showToast(
    String? message, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.top,
  }) {
    EasyLoading.instance
      ..radius = 0.0
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..textColor = Colors.white
      ..backgroundColor = MyColors.primaryGreen
      ..indicatorColor = MyColors.primaryblue
      ..maskColor = MyColors.primaryblue
      ..dismissOnTap = false;

    EasyLoading.showToast(message!, toastPosition: position);
  }

  static showError(
    String? message, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.top,
  }) {
    EasyLoading.instance
      ..radius = 0.0
      ..displayDuration = const Duration(milliseconds: 2000)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..textColor = Colors.white
      ..backgroundColor = MyColors.primaryred
      ..indicatorColor = Colors.red
      ..maskColor = Colors.red
      ..dismissOnTap = false;

    EasyLoading.showToast(message!, toastPosition: position);
  }

  static showInternetError(
    String? message, {
    EasyLoadingToastPosition position = EasyLoadingToastPosition.top,
  }) {
    EasyLoading.instance
      ..radius = 0.0
      ..displayDuration = const Duration(seconds: 100)
      ..loadingStyle =
          EasyLoadingStyle.custom //This was missing in earlier code
      ..textColor = Colors.white
      ..backgroundColor = MyColors.primaryred
      ..indicatorColor = Colors.red
      ..maskColor = Colors.red
      ..dismissOnTap = true;

    EasyLoading.showToast(message!, toastPosition: position);
  }

  static showLoader(String message) {
    // EasyLoading.show(status: message);
    SvgPicture.asset('assets/json/loading_circle.json');
  }

  static closeLoader() {
    EasyLoading.dismiss();
  }
}
