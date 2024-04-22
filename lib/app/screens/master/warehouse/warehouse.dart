// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/warehouse_controller.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/warehouselist_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';

class Warehousepage extends StatefulWidget {
  const Warehousepage({super.key});

  @override
  State<Warehousepage> createState() => _WarehousepageState();
}

class _WarehousepageState extends State<Warehousepage> {
  final GlobalKey<RefreshIndicatorState> _refreshMasWHKey =
      GlobalKey<RefreshIndicatorState>();

  final warehouseController = Get.put(WarehouseController());
  List<WarehouseListData> warehouseList = [];

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Scaffold(
          backgroundColor: MyColors.grey_1,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.grey.shade200,
            title: Text(
              "Warehouse List",
              style: MyText.customFormTitle18(context)!
                  .copyWith(color: Colors.black),
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
                    // Get.offAll(const Addwarehousepage());
                    Get.toNamed('/addwarehouse');
                  },
                  child: Row(
                    children: [
                      SvgPicture.asset(
                        Constant.addFrameSVG,
                        width: MediaQuery.of(context).size.width / 20,
                        height: MediaQuery.of(context).size.width / 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        "Warehouse",
                        style: MyText.customLabelText15(context)!
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          endDrawer: const DrawerMenu(),
          body: Obx(() {
            warehouseList = warehouseController.warehouseListData.value;
            return warehouseController.load.value
                ? LoaderWidget('')
                : RefreshIndicator(
                    key: _refreshMasWHKey,
                    onRefresh: () async {
                      await warehouseController.warehouselistAPI();
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            warehouseList.length > 0
                                ? ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    padding: const EdgeInsets.all(8),
                                    itemCount: warehouseList.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Card(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 1,
                                            color: Colors.grey,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () async {
                                                      await warehouseController
                                                          .warehouseDetailsAPI(
                                                        warehouseList[index]
                                                            .id!,
                                                      )
                                                          .then((value) {
                                                        if (value != null) {
                                                          Get.toNamed(
                                                            '/warehouseinfo',
                                                          );
                                                        }
                                                      });
                                                    },
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              6,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                              13,
                                                            ),
                                                            child:
                                                                Image.network(
                                                              height: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).size.width /
                                                                  7,
                                                              width: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).size.width /
                                                                  7,
                                                              fit: BoxFit.fill,
                                                              '${warehouseList[index].warehouseLogo}',
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: MediaQuery
                                                                      .of(
                                                                    context,
                                                                  ).size.width /
                                                                  1.50,
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                  top: 1,
                                                                ),
                                                                child: Text(
                                                                  '${warehouseList[index].warehouseName}',
                                                                  style: MyText
                                                                          .customLabelText15(
                                                                    context,
                                                                  )!
                                                                      .copyWith(),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                              height: 5,
                                                            ),
                                                            Text(
                                                              '${warehouseList[index].cityLocation}',
                                                              style: MyText
                                                                      .customHintText13(
                                                                context,
                                                              )!
                                                                  .copyWith(
                                                                color: MyColors
                                                                    .grey,
                                                                letterSpacing:
                                                                    0.0,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const Expanded(
                                                    child: SizedBox(
                                                      width: 3,
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      final action =
                                                          await Dialogs
                                                              .alertDialog(
                                                        context,
                                                        "",
                                                        "Do you want to delete this Warehouse?",
                                                        "Cancel",
                                                        "Confirm",
                                                      );
                                                      if (action ==
                                                          alertDialogAction
                                                              .save) {
                                                        Future.delayed(
                                                            Duration.zero, () {
                                                          Get.find<
                                                                  WarehouseController>()
                                                              .deleteWarehouseAPI(
                                                            warehouseList[index]
                                                                .id,
                                                          );
                                                        });
                                                      }

                                                      if (action ==
                                                          alertDialogAction
                                                              .cancel) {}
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
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      SvgPicture.asset(
                                                        'assets/icons/warehouse.svg',
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            20,
                                                        height: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            20,
                                                      ),
                                                      const SizedBox(
                                                        width: 3,
                                                      ),
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            2.0,
                                                        child: Text(
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          '${warehouseList[index].warehouseType}',
                                                          style: MyText
                                                                  .customHintText13(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  Text(
                                                    '${warehouseList[index].totalLand}' +
                                                        ' Sq.ft',
                                                    style:
                                                        MyText.customHintText13(
                                                      context,
                                                    )!
                                                            .copyWith(
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : SingleChildScrollView(
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    child: SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.25,
                                      child: Center(
                                        child: Text(
                                          Constant.messages.noWarehouses ??
                                              'Warehouse(s) unavailable. Please add ...',
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
                          ],
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
