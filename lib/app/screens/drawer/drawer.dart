import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/controller/dashboard_controller.dart';
import 'package:las_warehouse/app/data/controller/login_controller.dart';
import 'package:las_warehouse/app/data/controller/master_controller.dart';
import 'package:las_warehouse/app/data/controller/message_controller.dart';
import 'package:las_warehouse/app/data/controller/order_bidding_controller.dart';
import 'package:las_warehouse/app/data/controller/pending_controller.dart';
import 'package:las_warehouse/app/data/controller/profile_controller.dart';
import 'package:las_warehouse/app/data/controller/termsnconditions_controller.dart';
import 'package:las_warehouse/app/data/controller/user_controller.dart';
import 'package:las_warehouse/app/data/controller/user_role_controller.dart';
import 'package:las_warehouse/app/data/controller/warehouse_controller.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';

class DrawerMenu extends StatefulWidget {
  const DrawerMenu({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DrawerMenuPage();
  }
}

class _DrawerMenuPage extends State<DrawerMenu> {
  _DrawerMenuPage();
  String? email;
  String? name;
  User userData1 = User();
  bool load = true;
  // final profileController = Get.put(ProfileController()).profileData.value;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  getCurrentUser() async {
    // final User user = firebaseAuth.currentUser!;
    userData1 = await Preferences.loadSharedPrefs();
    // print(userData.email);
    // final uid = user.uid;
    // email = user.email;
    // name = user.displayName;
    // return uid;
    setState(() {
      load = false;
    });
  }

  final List<dynamic> pages = [
    SubMenuItem("Dashboard", '/dashboard', Icons.verified_user_sharp),
    SubMenuItem("Control Tower", '/controltower', Icons.store),
    SubMenuItem("Order Bidding", '/orderbidding', Icons.store),
    SubMenuItem("Pending", '/pendingorders', Icons.assignment),
    SubMenuItem("Work Orders", '/workorders', Icons.store),
    SubMenuItem("Completed", '/completedorders', Icons.assignment),
    SubMenuItem("Report", '/reports', Icons.assignment),
    MenuItem(
      title: 'Master',
      icon: Icons.assignment,
      items: [
        SubMenuItem("User Roles", '/userroles', Icons.assignment),
        SubMenuItem("Users", '/users', Icons.assignment),
        SubMenuItem("Warehouse", '/warehouses', Icons.assignment),
        SubMenuItem(
          "Terms and Conditions",
          '/termsnconditions',
          Icons.assignment,
        ),
      ],
    ),
    // SubMenuItem("Launch TMS App", 'launch tms app', Icons.logout),
    SubMenuItem("Profile", '/profile', Icons.logout),
    // SubMenuItem("Change Password", '/changepassword', Icons.logout),
    SubMenuItem("Logout", 'logout', Icons.logout),
  ];
  bool showOrder = false;
  bool showMaster = false;
  @override
  Widget build(BuildContext context) {
    // userData1 = Get.put(ProfileController()).profileData.value;
    return Container(
      color: MyColors.grey_10,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Drawer(
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(userData1.roleId == 2 ? 155 : 136),
            child: Container(
              padding: const EdgeInsets.only(top: 22.0, left: 0.0),
              width: MediaQuery.of(context).size.width,
              height: 155,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: MyColors.grey_100_,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(height: 7),
                        userData1.roleId == 2
                            ? SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  '${userData1.actorName}',
                                  style: TextStyle(
                                    color: MyColors.grey_100_,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18 *
                                        MediaQuery.of(context).textScaleFactor,
                                  ),
                                ),
                              )
                            : Container(),
                        Container(height: 2),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '${userData1.vendorName}',
                            style: TextStyle(
                              color: MyColors.grey_100_,
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        Container(height: 2),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Text(
                            '${userData1.email}',
                            style: TextStyle(
                              color: MyColors.grey_100_,
                              fontSize:
                                  16 * MediaQuery.of(context).textScaleFactor,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Container(height: 5),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 3.0,
                    color: MyColors.grey_100_,
                  ),
                  Container(height: 5),
                ],
              ),
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  ListView.separated(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    separatorBuilder: (context, index) {
                      return Container();
                    },
                    itemBuilder: (BuildContext context, int index) {
                      dynamic page = pages[index];
                      return page is MenuItem
                          ? _buildExpandableMenu(page, context)
                          : _buildSubMenu(page, context);
                    },
                    itemCount: pages.length,
                  ),
                  //Divider(),
                ],
              ),
            ),
          ),
        ),
        // ),
      ),
    );
  }

  Widget _buildExpandableMenu(MenuItem page, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            if (page.title == 'Orders') {
              setState(() {
                showOrder = !showOrder;
              });
            } else if (page.title == 'Master') {
              setState(() {
                showMaster = !showMaster;
              });
            }
          },
          child: Container(
            padding: const EdgeInsets.only(
              left: 20,
              right: 20,
              top: 8.0,
              bottom: 8.0,
            ),
            child: Row(
              children: [
                Text(
                  page.title!,
                  style: TextStyle(
                    fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                    letterSpacing: 1.0,
                    color: MyColors.grey_100_,
                  ),
                ),
                // style: TextStyle(
                //     letterSpacing: 1.0,
                //     fontSize: 14,
                //     color: MyColors.grey_90)),
                const Expanded(
                  child: SizedBox(
                    width: 5,
                  ),
                ),
                !showOrder && page.title == 'Orders'
                    ? const Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.grey_40,
                        size: 25,
                      )
                    : showOrder && page.title == 'Orders'
                        ? const Icon(
                            Icons.keyboard_arrow_up,
                            color: MyColors.primaryblue,
                            size: 25,
                          )
                        : Container(),
                !showMaster && page.title == 'Master'
                    ? const Icon(
                        Icons.keyboard_arrow_down,
                        color: MyColors.grey_40,
                        size: 25,
                      )
                    : showMaster && page.title == 'Master'
                        ? const Icon(
                            Icons.keyboard_arrow_up,
                            color: MyColors.primaryblue,
                            size: 25,
                          )
                        : Container(),
              ],
            ),
          ),
        ),
        showOrder && page.title == 'Orders'
            ? Column(
                children: _buildSubMenus(page.items!, context),
              )
            : Container(),
        showMaster && page.title == 'Master'
            ? Column(
                children: _buildSubMenus(page.items!, context),
              )
            : Container(),
      ],
    );
  }

  List<Widget> _buildSubMenus(List<SubMenuItem> items, BuildContext context) {
    final List<Widget> subMenus = [];
    items.forEach(
      (item) => subMenus.add(
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: _buildSubMenu(item, context),
        ),
      ),
    );
    return subMenus;
  }

  // _callAppWms() async {
  //   await DeviceApps.openApp('com.laastransport');
  // }

  Widget _buildSubMenu(SubMenuItem item, BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          onTap: () async {
            if (item.title == "Logout") {
              await Preferences.remove('userdata');
              await Preferences.setBoolean(Preferences.isLogin, false);
              await Preferences.setString(Preferences.accesstoken, "");
              Get.put(LoginController()).load.value = false;
              Get.delete<MasterController>();
              Get.delete<MessageController>();
              Get.delete<DashboardDataController>();
              Get.delete<ProfileController>();
              Get.delete<OrderBiddingController>();
              Get.delete<UserController>();
              Get.delete<UserRoleController>();
              Get.delete<PendingBidsController>();
              Get.delete<WorkOrderController>();
              Get.delete<CompletedOrdersController>();
              Get.delete<WarehouseController>();
              Get.delete<TermsnConditionsController>();

              Get.offAndToNamed('/auth');
            } else {
              Get.offAndToNamed(item.page);
            }

            // if (item.page == 'users') {
            //   Get.offAll(const UsersMasterView());
            // } else if (item.page == 'dashboard') {
            //   Get.offAll(const DashboardPage());
            // } else if (item.page == 'order-bidding') {
            //   Get.offAll(const Orderbiddingpage());
            // } else if (item.page == 'pending') {
            //   Get.offAll(const PendingActiveBidsPage());
            // } else if (item.page == 'completed') {
            //   Get.offAll(const Completedpage());
            // } else if (item.page == 'report') {
            //   Get.offAll(const WBSReportsListScreen());
            // } else if (item.page == 'warehouse') {
            //   Get.offAll(const Warehousepage());
            // } else if (item.page == 'terms-conditions') {
            //   Get.offAll(TermsnConditions());
            // } else if (item.page == 'work-orders') {
            //   Get.offAll(const WorkOrdersPage());
            // } else if (item.page == 'profile') {
            //   Get.offAll(Profilepage());
            // } else if (item.page == 'change-password') {
            //   Get.offAll(const ChangePasswordView());
            // } else if (item.page == 'control-tower') {
            //   Get.offAll(const ControlTowerScreen());
            // }
          },
          child: (userData1.roleId == 1) ||
                  ((userData1.roleId == 2 &&
                          userData1.menus != null &&
                          userData1.menus!.contains(item.page.toLowerCase())) ||
                      (item.page.toLowerCase() == '/dashboard') ||
                      (item.page.toLowerCase() == 'logout') ||
                      (item.page.toLowerCase() == '/changepassword'))
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 18,
                  padding: const EdgeInsets.only(
                    left: 20.0,
                    right: 20.0,
                    bottom: 10,
                    top: 10,
                  ),
                  child: Row(
                    children: [
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                          letterSpacing: 1.0,
                          color: MyColors.grey_100_,
                        ),
                      ),
                      const Expanded(
                        child: SizedBox(
                          width: 10,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        color: MyColors.grey_40,
                        size: 18,
                      ),
                    ],
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}

class MenuItem {
  final String? title;
  final IconData? icon;
  final List<SubMenuItem>? items;
  MenuItem({Key? key, @required this.title, this.icon, this.items});
}

class SubMenuItem {
  final String title;
  final IconData icon;
  final String page;
  SubMenuItem(this.title, this.page, this.icon);
}
