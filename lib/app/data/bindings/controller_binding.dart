import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/connection_manager_controller.dart';
import 'package:las_warehouse/app/data/controller/master_controller.dart';
import 'package:las_warehouse/app/data/controller/message_controller.dart';
import 'package:las_warehouse/app/data/controller/version_manager_controller.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
      () => ConnectionManagerController(),
    );
    Get.put(MessageController());
    Get.put(VersionManagerController());
    Get.put(MasterController());
  }
}
