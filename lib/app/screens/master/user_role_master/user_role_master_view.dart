import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/user_role_controller.dart';
import 'package:las_warehouse/app/data/models/user_role_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';

class UsersRoleMasterView extends StatefulWidget {
  const UsersRoleMasterView({super.key});

  @override
  State<UsersRoleMasterView> createState() => _UsersRoleMasterViewState();
}

class _UsersRoleMasterViewState extends State<UsersRoleMasterView> {
  List<UserRole> userRolesList = [];
  final userRoleController = Get.put(UserRoleController());
  final GlobalKey<RefreshIndicatorState> _refreshUserRoleKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    // Get.offAll(DashboardScreen());
    Get.offNamed('/dashboard');
  }

  void _trySubmitForm(String roleId) async {
    await userRoleController.removeUserRoleAPI(roleId);
  }

  @override
  Widget build(BuildContext context) {
    userRolesList = userRoleController.interUsersRoleList;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Scaffold(
          backgroundColor: MyColors.grey_1,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: MyColors.grey_3,
            title: const Text(
              "User Role",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 8,
                  bottom: 8,
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.primaryblue,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/adduserrole');
                  },
                  child: const Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline,
                        size: 20,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "User Role",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          body: Obx(
            () => userRoleController.load.value
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xff297BC0),
                    ),
                  )
                : RefreshIndicator(
                    key: _refreshUserRoleKey,
                    onRefresh: () async {
                      await userRoleController.getUserRolesListAPI();
                    },
                    child: userRolesList.length > 0
                        ? SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 10,
                                right: 10,
                                top: 10,
                                bottom: 10,
                              ),
                              child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: userRolesList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: const BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          right: 20,
                                          bottom: 20,
                                          left: 20,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                userRolesList[index].userRole!,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  letterSpacing: 0.5,
                                                ),
                                                softWrap: false,
                                                //maxLines: 2,
                                                overflow: TextOverflow
                                                    .ellipsis, // new
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Get.toNamed(
                                                      '/edituserrole',
                                                      arguments:
                                                          userRolesList[index],
                                                    );
                                                  },
                                                  child: const Icon(
                                                    Icons.edit_note_rounded,
                                                    color:
                                                        MyColors.primaryGreen,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    final action = await Dialogs
                                                        .alertDialog(
                                                      context,
                                                      "",
                                                      Constant.messages
                                                              .delUser ??
                                                          "Are you sure to delete this user role?",
                                                      "Cancel",
                                                      "Confirm",
                                                    );
                                                    //cancel and save are the button text for cancel and save operation
                                                    if (action ==
                                                        alertDialogAction
                                                            .save) {
                                                      //do something
                                                      print('Saved');
                                                      await userRoleController
                                                          .removeUserRoleAPI(
                                                        userRolesList[index]
                                                            .id!,
                                                      );
                                                    }

                                                    if (action ==
                                                        alertDialogAction
                                                            .cancel) {
                                                      print('canceled');
                                                      //do something
                                                    }
                                                  },
                                                  child: SvgPicture.asset(
                                                    Constant.cancelSVG,
                                                    width: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        20,
                                                    height: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          )
                        : SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height / 1.25,
                              width: MediaQuery.of(context).size.width,
                              child: Center(
                                child: Text(
                                  Constant.messages.noMtType ??
                                      'User Roles List is Empty. \n Please Add...',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: MyColors.grey_100_,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                          ),
                  ),
          ),
        ),
      ),
    );
  }
}
