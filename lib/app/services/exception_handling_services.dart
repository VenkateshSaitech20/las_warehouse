import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/authentications/login_screen.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/services/Preferences.dart';

class ApiExceptionService extends GetxService {
  // RxStrings to hold different types of error messages
  final RxString socketErrorMessage = ''.obs;
  final RxString serverErrorMessage = ''.obs;
  final RxString networkErrorMessage = ''.obs;

  // Function to handle socket exceptions
  void handleSocketException(dynamic error) {
    socketErrorMessage.value = '$error';
    if (socketErrorMessage.value.toLowerCase().contains('socket')) {
      ShowToastDialog.showError('Socket Error');
    } else if (socketErrorMessage.value
        .toLowerCase()
        .contains('subtype of type')) {
      ShowToastDialog.showError('Format type convertion error');
    } else {
      ShowToastDialog.showError('Please, Try again later');
    }
  }

  // Function to handle server exceptions
  void handleServerException(dynamic error) {
    serverErrorMessage.value = 'Server Error: $error';
    ShowToastDialog.showError(serverErrorMessage.value);
  }

  // Function to handle network exceptions
  void handleNetworkException(dynamic error) {
    networkErrorMessage.value = 'Network Error: $error';
  }

  void handleSessionExpire() async {
    ShowToastDialog.showError('Session Expired');
    await Preferences.remove('userdata');
    await Preferences.setBoolean(Preferences.isLogin, false);
    await Preferences.setString(Preferences.accesstoken, "");

    Get.offAll(const LoginScreen());
  }
}
