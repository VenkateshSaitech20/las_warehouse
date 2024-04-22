import 'package:get/get.dart';
import 'package:las_warehouse/app/data/bindings/dashboard_binding.dart';
import 'package:las_warehouse/app/data/models/internal_user_model.dart';
import 'package:las_warehouse/app/data/models/user_role_model.dart';
import 'package:las_warehouse/app/screens/authentications/change_pwd.dart';
import 'package:las_warehouse/app/screens/authentications/login_screen.dart';
import 'package:las_warehouse/app/screens/authentications/register_screen.dart';
import 'package:las_warehouse/app/screens/completed_orders/completed.dart';
import 'package:las_warehouse/app/screens/completed_orders/customerdetails.dart';
import 'package:las_warehouse/app/screens/control_tower/control_tower_screen.dart';
import 'package:las_warehouse/app/screens/dashboard/dashboard_screen.dart';
import 'package:las_warehouse/app/screens/master/termsnconditions/terms_and_conditions.dart';
import 'package:las_warehouse/app/screens/master/user/add_user_master.dart';
import 'package:las_warehouse/app/screens/master/user/edit_user_master.dart';
import 'package:las_warehouse/app/screens/master/user/users_master_view.dart';
import 'package:las_warehouse/app/screens/master/user_role_master/add_user_role_master.dart';
import 'package:las_warehouse/app/screens/master/user_role_master/edit_user_role_master.dart';
import 'package:las_warehouse/app/screens/master/user_role_master/user_role_master_view.dart';
import 'package:las_warehouse/app/screens/master/warehouse/add_warehouse.dart';
import 'package:las_warehouse/app/screens/master/warehouse/warehouse.dart';
import 'package:las_warehouse/app/screens/master/warehouse/warehouse_details.dart';
import 'package:las_warehouse/app/screens/order_bidding/customer_requirement.dart';
import 'package:las_warehouse/app/screens/order_bidding/order_bidding.dart';
import 'package:las_warehouse/app/screens/pending_bids/chat.dart';
import 'package:las_warehouse/app/screens/pending_bids/pending_active_bids.dart';
import 'package:las_warehouse/app/screens/profile/profile_edit_screen.dart';
import 'package:las_warehouse/app/screens/profile/profile_screen.dart';
import 'package:las_warehouse/app/screens/reports/wbs_report_detail_view.dart';
import 'package:las_warehouse/app/screens/reports/wbs_report_list.dart';
import 'package:las_warehouse/app/screens/widgets/homepage.dart';
import 'package:las_warehouse/app/screens/work_orders/work_orders.dart';
import 'package:las_warehouse/app/screens/work_orders/workorder_chatscreen.dart';
import 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const Homepage(),
      // binding: (),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.AUTH,
      page: () => const LoginScreen(),
      // binding: AuthBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: Routes.WBSREGISTRATION,
      page: () => const WarehouseRegisterScreen(),
      // binding: AuthBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 250),
    ),
    GetPage(
      name: Routes.DASHBOARD,
      page: () => const DashboardPage(),
      binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.CONTROLTOWER,
      page: () => const ControlTowerScreen(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.ORDERBIDDING,
      page: () => const Orderbiddingpage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.PENDINGORDERS,
      page: () => const PendingActiveBidsPage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.WORKORDERS,
      page: () => const WorkOrdersPage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.COMPLETEDORDERS,
      page: () => const Completedpage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: Routes.INVOICEDETAILVIEW,
    //   page: () => InvoiceDetails(bidId: Get.arguments),
    //   arguments: (String bidId) => InvoiceDetails(bidId: bidId),
    //   // binding: DashBoardBinding(),
    //   transition: Transition.leftToRight,
    //   transitionDuration: const Duration(milliseconds: 500),
    // ),
    GetPage(
      name: Routes.REPORTS,
      page: () => const WBSReportsListScreen(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.WBSREPORTSDETAILVIEW,
      page: () => WBSReportDetailView(bidId: Get.arguments),
      arguments: (String bidId) => WBSReportDetailView(bidId: bidId),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.CUSTOMERINFO,
      page: () => Customerdetails(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    // GetPage(
    //   name: Routes.INVOICEINFO,
    //   page: () => InvoiceDetails(bidId: Get.arguments),
    //   arguments: (String bidId) => InvoiceDetails(bidId: bidId),
    //   // binding: DashBoardBinding(),
    //   transition: Transition.leftToRight,
    //   transitionDuration: Duration(milliseconds: 500),
    // ),
    GetPage(
      name: Routes.CUSTOMERREQ,
      page: () => const CustomerRequirements(),
      arguments: (String bidId) => const CustomerRequirements(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.USERROLES,
      page: () => const UsersRoleMasterView(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.ADDUSERROLE,
      page: () => const AddUserRoleMaster(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.EDITUSERROLE,
      page: () => EditUserRoleMaster(userRoleData: Get.arguments),
      arguments: (UserRole arguments) =>
          EditUserRoleMaster(userRoleData: arguments),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.USERS,
      page: () => const UsersMasterView(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.ADDUSER,
      page: () => const AddUserMaster(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.EDITUSER,
      page: () => EditUserMaster(Get.arguments),
      arguments: (InterUser arguments) => EditUserMaster(arguments),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.WAREHOUSES,
      page: () => const Warehousepage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.ADDWAREHOUSE,
      page: () => const Addwarehousepage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.WAREHOUSEDETAILINFO,
      page: () => const WarehouseDetails(),
      // arguments: (Vehicle arguments) =>
      //     VehicleInfoMaster(vehicleinfo: arguments),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.TERMSNCONDITION,
      page: () => const TermsnConditions(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const Profilepage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.EDITPROFILE,
      page: () => const EditProfilePage(),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.CHANGEPASSWORD,
      page: () => const ChangePasswordView(),

      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.NEGOTIATIONS,
      page: () => ChatScreen(bidId: Get.arguments),
      arguments: (String arguments) => ChatScreen(bidId: arguments),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: Routes.WONEGOTIATIONS,
      page: () => WorkOrderChatScreen(bidId: Get.arguments),
      arguments: (String arguments) => WorkOrderChatScreen(bidId: arguments),
      // binding: DashBoardBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
