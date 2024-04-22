// ignore_for_file: deprecated_member_use, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/controller/dashboard_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/dashboard_model.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool roadways = true;
  bool seaways = true;
  bool airways = true;
  bool railways = true;

  @override
  void initState() {
    super.initState();
  }

  void hideWidget() {
    setState(() {
      roadways = !roadways;
    });
  }

  void hideWidget1() {
    setState(() {
      seaways = !seaways;
    });
  }

  void hideWidget2() {
    setState(() {
      airways = !airways;
    });
  }

  void hideWidget3() {
    setState(() {
      railways = !railways;
    });
  }

  final completedOrderController = Get.put(CompletedOrdersController());

  Future<bool> _onWillPop() async {
    bool result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Align(
              //   alignment: Alignment.center,
              //   child: Container(
              //       padding: EdgeInsets.all(5.0),
              //       height: 40,
              //       width: double.infinity,
              //       child: Image.asset(Constant.logo)),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 10.0,
                ),
                width: double.infinity,
                // height: 50,
                color: Colors.white,
                child: const Text(
                  "Confirm Exit?",
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: const Text(
                  'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.',
                  style: TextStyle(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(5.0),
                      backgroundColor: MyColors.primaryblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () async {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(
                        color: MyColors.primaryblue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: const Text(
                      "No",
                      style: TextStyle(
                        color: MyColors.primaryblue,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return result;
  }

  final dashboardDataController = Get.put(DashboardDataController());

  DashBoardDetails dashBoardDetails = DashBoardDetails();
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onWillPop(),
      child: Scaffold(
        backgroundColor: MyColors.grey_1,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Obx(() {
          dashBoardDetails = dashboardDataController.DashData.value;
          return dashboardDataController.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await dashboardDataController.getDashDataAPI();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 10,
                            top: 20,
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9.2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: MyColors.grey, //<-- SEE HERE
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 10,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/total-booking.svg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  //color: Colors.blue,
                                                ),
                                                // Icon(
                                                //   Icons.calendar_month_outlined,
                                                //   size: 40,
                                                //   color: MyColors.primarypurple,
                                                // ),
                                              ),
                                              Center(
                                                // padding: const EdgeInsets.only(
                                                //     top: 0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${dashBoardDetails.pendingCnt}",
                                                      style:
                                                          MyText.customText18(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "TOTAL PENDING",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9.2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: MyColors.grey, //<-- SEE HERE
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 10,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/delivery.svg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  color: MyColors.primaryblue,
                                                ),
                                                // Icon(
                                                //   Icons.local_shipping_outlined,
                                                //   size: 40,
                                                //   color: MyColors.primaryLight,
                                                // ),
                                              ),
                                              Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${dashBoardDetails.checkoutCnt}",
                                                      style:
                                                          MyText.customText18(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "READY FOR",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "CHECKOUT",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9.2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: MyColors.grey, //<-- SEE HERE
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 10,
                                                ),
                                                // child: Icon(
                                                //   Icons.map,
                                                //   size: 40,
                                                //   color: MyColors.primaryGreen,
                                                // ),booking-transit.svg
                                                child: SvgPicture.asset(
                                                  'assets/icons/active-bid.svg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  color: Colors.green,
                                                ),
                                              ),
                                              Center(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${dashBoardDetails.workOrderCnt}",
                                                      style:
                                                          MyText.customText18(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "WORK ORDERS",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              9.2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            color: MyColors.grey, //<-- SEE HERE
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 5,
                                                  right: 5,
                                                  bottom: 10,
                                                ),
                                                child: SvgPicture.asset(
                                                  'assets/icons/completed-booking.svg',
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width /
                                                      12,
                                                ),
                                                //  Icon(
                                                //   Icons.assignment_turned_in_outlined,
                                                //   size: 40,
                                                //   color: MyColors.grey,
                                                // ),
                                              ),
                                              Center(
                                                // padding: const EdgeInsets.only(
                                                //     top: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      "${dashBoardDetails.completedCnt}",
                                                      style:
                                                          MyText.customText18(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "COMPLETED ",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 2,
                                                    ),
                                                    Text(
                                                      "BOOKINGS",
                                                      style:
                                                          MyText.customText13(
                                                        context,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}

class ChartData {
  const ChartData(this.x, this.y, this.y1, this.y2, this.y3);
  final String x;
  final int y;
  final int y1;
  final int y2;
  final int y3;
}
