// ignore_for_file: unused_element

// import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/wbs_report_controller.dart';
import 'package:las_warehouse/app/data/models/report_list_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';

class WBSReportsListScreen extends StatefulWidget {
  const WBSReportsListScreen({super.key});

  @override
  State<WBSReportsListScreen> createState() => _WBSReportsListScreenState();
}

class _WBSReportsListScreenState extends State<WBSReportsListScreen> {
  final wbsReportController = Get.put(WBSReportController());
  bool load = true;
  List<WHReportL> wbsReportList = [];

  @override
  void initState() {
    wbsReportController.getwbsReportList();
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
        backgroundColor: MyColors.grey_1,
        appBar: BaseAppBar(),
        // appBar: AppBar(
        //   backgroundColor: MyColors.primaryblue,
        //   title: Container(width: 120, child: Image.asset(Constant.logo2)),
        // ),
        endDrawer: const DrawerMenu(),

        body: RefreshIndicator(
          onRefresh: () async {
            await wbsReportController.getwbsReportList();
          },
          child: Obx(
            () {
              wbsReportList = wbsReportController.wbsReportList;

              return wbsReportController.load.value
                  ? LoaderWidget('')
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 0),
                            child: Text(
                              "Reports",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * MediaQuery.of(context).textScaleFactor,
                              ),
                            ),
                          ),
                          wbsReportList.length > 0
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: wbsReportList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color:
                                                          MyColors.primarywhite,
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 10,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  '${wbsReportList[index].customer?.cusName}',
                                                                  style: MyText
                                                                          .customText14(
                                                                    context,
                                                                  )!
                                                                      .copyWith(
                                                                    color: MyColors
                                                                        .darkblue,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          Container(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              left: 10.0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                SizedBox(
                                                                  width: MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).size.width -
                                                                      50,
                                                                  child: Text(
                                                                    '${wbsReportList[index].preferredLocation}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    maxLines: 2,
                                                                    style: MyText
                                                                            .customText14(
                                                                      context,
                                                                    )!
                                                                        .copyWith(
                                                                      color: MyColors
                                                                          .darkblue,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              bottom: 0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                ColumnDetail(
                                                                  "Warehouse Type",
                                                                  '${wbsReportList[index].availableWarehouseType}',
                                                                ),
                                                                ColumnDetail(
                                                                  "From",
                                                                  '${wbsReportList[index].fromDateTime}',
                                                                ),
                                                                ColumnDetail(
                                                                  "To Date",
                                                                  '${wbsReportList[index].toDateTime}',
                                                                ),
                                                                ColumnDetail(
                                                                  "Rating",
                                                                  '${wbsReportList[index].rating ?? ''}',
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          const Divider(
                                                            color: MyColors
                                                                .grey_30,
                                                            indent: 10,
                                                            endIndent: 10,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    ColumnDetail(
                                                                      "Work Order",
                                                                      '${wbsReportList[index].workOrder}',
                                                                    ),
                                                                    ColumnDetail(
                                                                      "Invoice",
                                                                      '${wbsReportList[index].invoice}',
                                                                    ),
                                                                    ColumnDetail(
                                                                      "Checkout",
                                                                      '${wbsReportList[index].checkout}',
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                          "Details",
                                                                          style:
                                                                              MyText.customText10(context)!.copyWith(
                                                                            color:
                                                                                MyColors.darkblue,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              5,
                                                                        ),
                                                                        InkWell(
                                                                          onTap:
                                                                              () {
                                                                            Get.toNamed(
                                                                              '/wbsreportdetailview',
                                                                              arguments: wbsReportList[index].id!,
                                                                            );
                                                                          },
                                                                          child:
                                                                              const Icon(
                                                                            Icons.remove_red_eye,
                                                                            color:
                                                                                MyColors.primaryblue,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                // const Divider(
                                                                //   color: MyColors
                                                                //       .grey_30,
                                                                //   indent:
                                                                //       10,
                                                                //   endIndent:
                                                                //       10,
                                                                // ),
                                                              ],
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
                                    );
                                  },
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.85,
                                  child: Center(
                                    child: Text(
                                      'No more bid available.',
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: 16 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Widget ColumnDetail(title, value) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4.5,
          child: Text(
            "$title",
            textAlign: TextAlign.center,
            softWrap: true,
            style: MyText.customText10(context)!.copyWith(
              color: MyColors.darkblue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        title != 'Rating'
            ? SizedBox(
                // width: MediaQuery.of(context).size.width / 5,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 4.5,
                      child: Text(
                        value ?? ' ',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: MyText.customText12(context)!.copyWith(
                          color: MyColors.grey_5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    title == 'Rating' && value != '' && value != null
                        ? const Icon(
                            Icons.star,
                            color: MyColors.primaryblue,
                            size: 15,
                          )
                        : Container(),
                  ],
                ),
              )
            : SizedBox(
                // width: MediaQuery.of(context).size.width / 5,
                child: Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 13,
                      child: Text(
                        value ?? ' ',
                        softWrap: true,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        style: MyText.customText12(context)!.copyWith(
                          color: MyColors.grey_5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    title == 'Rating' && value != '' && value != null
                        ? const Icon(
                            Icons.star,
                            color: MyColors.primaryblue,
                            size: 15,
                          )
                        : Container(),
                  ],
                ),
              ),
      ],
    );
  }
}
