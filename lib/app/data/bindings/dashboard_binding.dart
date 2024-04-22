import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/controller/dashboard_controller.dart';
import 'package:las_warehouse/app/data/controller/order_bidding_controller.dart';
import 'package:las_warehouse/app/data/controller/pending_controller.dart';
import 'package:las_warehouse/app/data/controller/termsnconditions_controller.dart';
import 'package:las_warehouse/app/data/controller/user_controller.dart';
import 'package:las_warehouse/app/data/controller/user_role_controller.dart';
import 'package:las_warehouse/app/data/controller/warehouse_controller.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';

class DashBoardBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(DashboardDataController());
    Get.put(OrderBiddingController());
    Get.put(PendingBidsController());
    Get.put(WorkOrderController());
    Get.put(CompletedOrdersController());
    Get.put(UserRoleController());
    Get.put(UserController());
    Get.put(WarehouseController());
    Get.put(TermsnConditionsController());
  }
}
