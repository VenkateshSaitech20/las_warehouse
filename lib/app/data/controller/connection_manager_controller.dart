import 'package:get/get.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';

class ConnectionManagerController extends GetxController {
  RxInt connectionStatus = 0.obs;

  @override
  void onInit() {
    super.onInit();

    InternetConnection().onStatusChange.listen(_updateConnectionStatus);
  }

  void _updateConnectionStatus(InternetStatus? iStatus) {
    if (iStatus == InternetStatus.disconnected) {
      connectionStatus = 0.obs;
      update();
      // ShowToastDialog.showInternetError(
      //     'No internet connections found. Check your connection or Restart the App.');
    } else {
      connectionStatus = 1.obs;
      update();
      ShowToastDialog.closeLoader();
      // ShowToastDialog.showToast('Your internet connection has been restored.');
    }
  }
}
