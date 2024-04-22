// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/user_controller.dart';
import 'package:las_warehouse/app/data/models/internal_user_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';

class UsersMasterView extends StatefulWidget {
  const UsersMasterView({super.key});

  @override
  State<UsersMasterView> createState() => _UsersMasterViewState();
}

class _UsersMasterViewState extends State<UsersMasterView> {
  List<InterUser> interUsersList = [];
  final userController = Get.put(UserController());
  final GlobalKey<RefreshIndicatorState> _refreshMasUserKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.offAndToNamed('/dashboard');
  }

  @override
  Widget build(BuildContext context) {
    print(interUsersList.length);
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: DrawerMenu(),
        body: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade200,
            title: Text(
              "Users",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
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
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.horizontal(),
                    ),
                  ),
                  onPressed: () {
                    Get.toNamed('/adduser');
                    // Get.offAll(AddUserMaster());
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Constant.addFrameSVG,
                        width: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.width / 20,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        "User",
                        style: MyText.customLabelText15(context)!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          backgroundColor: MyColors.grey_1,
          body: Obx(() {
            interUsersList = userController.interUsersList.value;
            return userController.load.value
                ? LoaderWidget('')
                : RefreshIndicator(
                    key: _refreshMasUserKey,
                    onRefresh: () async {
                      await userController.getInterUsersListAPI();
                    },
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 10,
                          right: 10,
                          bottom: 10,
                          left: 10,
                        ),
                        child: interUsersList.length > 0
                            ? ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: interUsersList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          width: 1,
                                          color: Colors.grey,
                                        ),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 10,
                                          right: 10,
                                          bottom: 10,
                                          left: 10,
                                        ),
                                        child: Row(
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            7,
                                                        child: Text(
                                                          'Name',
                                                          style: TextStyle(
                                                            fontSize: 15 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                            color:
                                                                MyColors.grey_5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            // decoration: TextDecoration
                                                            //     .underline
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        ': ${interUsersList[index].actorName}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                        softWrap: false,
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis, // new
                                                      ),
                                                      Expanded(
                                                        child: SizedBox(
                                                          width: 5,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.toNamed(
                                                            '/edituser',
                                                            arguments:
                                                                interUsersList[
                                                                    index],
                                                          );
                                                          // Get.offAll(
                                                          //     EditUserMaster(
                                                          //         interUsersList[
                                                          //             index]));
                                                        },
                                                        child: SvgPicture.asset(
                                                          Constant.editSVG,
                                                          width: MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              15,
                                                          height: MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              15,
                                                          semanticsLabel:
                                                              'Edit',
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          final action =
                                                              await Dialogs
                                                                  .alertDialog(
                                                            context,
                                                            "",
                                                            Constant.messages
                                                                    .delUser ??
                                                                "Are you sure to delete this user?",
                                                            "Cancel",
                                                            "Confirm",
                                                          );
                                                          //cancel and save are the button text for cancel and save operation
                                                          if (action ==
                                                              alertDialogAction
                                                                  .save) {
                                                            //do something
                                                            print('Saved');
                                                            userController
                                                                .removeUserAPI(
                                                              interUsersList[
                                                                      index]
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
                                                          semanticsLabel:
                                                              'Delete',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            7,
                                                        child: Text(
                                                          'Mobile',
                                                          style: TextStyle(
                                                            fontSize: 15 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                            color:
                                                                MyColors.grey_5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            // decoration: TextDecoration
                                                            //     .underline
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        ': ${interUsersList[index].phone}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                        softWrap: false,
                                                        //maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis, // new
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            7,
                                                        child: Text(
                                                          'EMail',
                                                          style: TextStyle(
                                                            fontSize: 15 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                            color:
                                                                MyColors.grey_5,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            // decoration: TextDecoration
                                                            //     .underline
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        ': ${interUsersList[index].email}',
                                                        style: TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                        softWrap: false,
                                                        //maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis, // new
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(height: 10.0),
                                                  Text(
                                                    interUsersList[index]
                                                                .userRole !=
                                                            null
                                                        ? 'User Role:'
                                                        : '',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                      color:
                                                          MyColors.primaryblue,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.0),
                                                  Text(
                                                    '${interUsersList[index].userRole ?? ''}',
                                                    style: TextStyle(
                                                      fontSize: 14,
                                                    ),
                                                    softWrap: false,
                                                    maxLines: 3,
                                                    overflow: TextOverflow
                                                        .ellipsis, // new
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(),
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.25,
                                  width: MediaQuery.of(context).size.width,
                                  child: Center(
                                    child: Text(
                                      Constant.messages.noUser ??
                                          'User List is Empty. \n Please Add...',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: MyColors.grey_100_,
                                        fontSize: 16 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                  );
          }),
        ),
      ),
    );
  }
}
