// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/wbs_report_controller.dart';
import 'package:las_warehouse/app/data/models/report_detail_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/pdf_viewer.dart';
import 'package:las_warehouse/app/screens/widgets/zoom_image.dart';

class WBSReportDetailView extends StatefulWidget {
  final String? bidId;
  const WBSReportDetailView({super.key, this.bidId});

  @override
  WBSReportDetailViewState createState() => WBSReportDetailViewState();
}

class WBSReportDetailViewState extends State<WBSReportDetailView> {
  final wbsReportController = Get.put(WBSReportController());
  WhReporDetail? wbsReportDetail;
  bool showNegotiations = false;
  bool showWONegotiations = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    await wbsReportController.getWHReporDetail(widget.bidId!);
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
        endDrawer: DrawerMenu(),
        body: RefreshIndicator(
          onRefresh: () async {
            await wbsReportController.getWHReporDetail(widget.bidId!);
          },
          child: Obx(() {
            wbsReportDetail = wbsReportController.wbsReportDetailData.value;
            print(wbsReportDetail);
            return wbsReportController.load.value
                ? LoaderWidget('')
                : SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            '${wbsReportDetail?.customer?.cusName}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            'Requirement Details',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            'Req# : ${wbsReportDetail?.requirementNo}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          color: Colors.white,
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Requirement Type",
                                          "${wbsReportDetail?.requirementType}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        wbsReportDetail?.requirementType ==
                                                'Normal'
                                            ? Container()
                                            : doubleRowWidget(
                                                "Recurring Type",
                                                // '${DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse("${tmsReportDetail!.pickupDatetime}"))}',
                                                "${wbsReportDetail?.recurringType}",
                                                null,
                                              ),
                                      ],
                                    ),
                                    wbsReportDetail?.requirementType == 'Normal'
                                        ? Container()
                                        : Container(height: 10),
                                    wbsReportDetail?.requirementType == 'Normal'
                                        ? Container()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              doubleRowWidget(
                                                "Weekly Type",
                                                "${wbsReportDetail?.weeklyType}",
                                                null,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: 5,
                                                ),
                                              ),
                                              doubleRowWidget(
                                                "Monthly Type",
                                                // '${DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse("${tmsReportDetail!.pickupDatetime}"))}',
                                                "${wbsReportDetail?.monthlyType}",
                                                null,
                                              ),
                                            ],
                                          ),
                                    wbsReportDetail?.requirementType == 'Normal'
                                        ? Container()
                                        : Container(height: 10),
                                    wbsReportDetail?.requirementType == 'Normal'
                                        ? Container()
                                        : Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              doubleRowWidget(
                                                "Monthly Day",
                                                "${wbsReportDetail?.monthlyDay}",
                                                null,
                                              ),
                                              Expanded(
                                                child: SizedBox(
                                                  width: 5,
                                                ),
                                              ),
                                            ],
                                          ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Location",
                                          "${wbsReportDetail?.preferredLocation}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "City",
                                          // '${DateFormat("dd-MM-yyyy h:mm a").format(DateTime.parse("${tmsReportDetail!.pickupDatetime}"))}',
                                          "${wbsReportDetail?.city}",
                                          null,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Warehouse Type",
                                          "${wbsReportDetail?.warehouse?.warehouseType!}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Booking Type",
                                          "${wbsReportDetail?.bookingType}",
                                          null,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Req. SqFt",
                                          "${wbsReportDetail?.reqSqft} Sq. Ft.",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Advance Paid",
                                          wbsReportDetail?.advancePaid == 'Y'
                                              ? 'Yes'
                                              : 'No',
                                          null,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "From",
                                          "${wbsReportDetail?.fromDateTime}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "To",
                                          "${wbsReportDetail?.toDateTime}",
                                          null,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Bidding",
                                          "₹${wbsReportDetail?.bidPrice}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Bidding on",
                                          "${wbsReportDetail?.biddingOn}",
                                          null,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Final Price",
                                          "₹${wbsReportDetail?.finalPrice}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Payment Type",
                                          "${wbsReportDetail?.paymentType}",
                                          null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  // Container(
                                  //     child: Icon(
                                  //   Icons.precision_manufacturing,
                                  // )),
                                  Container(width: 15),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        "Products",
                                        style: MyText.title(context)!.copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              Container(height: 10),
                              wbsReportDetail!.materialTypeData != null &&
                                      wbsReportDetail!
                                              .materialTypeData!.length >
                                          0
                                  ? Padding(
                                      padding: const EdgeInsets.only(
                                        left: 4,
                                        right: 4,
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 6,
                                          vertical: 6,
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        color: MyColors.grey_90,
                                        child: ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          padding: const EdgeInsets.all(8),
                                          itemCount: wbsReportDetail
                                              ?.materialTypeData?.length,
                                          itemBuilder: (
                                            BuildContext context,
                                            int index,
                                          ) {
                                            final productDat = wbsReportDetail!
                                                .materialTypeData![index];
                                            print(
                                              '${productDat.materialType}',
                                            );
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Material Type",
                                                          style: MyText.body1(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color: MyColors
                                                                .primaryblue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 2,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              2,
                                                          child: Text(
                                                            "${productDat.materialType}",
                                                            style:
                                                                MyText.caption(
                                                              context,
                                                            )!
                                                                    .copyWith(
                                                              color: MyColors
                                                                  .grey_5,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          "Quantity",
                                                          style: MyText.body1(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color: MyColors
                                                                .primaryblue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          "${productDat.quantity}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: MyText.caption(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color:
                                                                MyColors.grey_5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(height: 10),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: <Widget>[
                                                        Text(
                                                          "Packaging Type",
                                                          style: MyText.body1(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color: MyColors
                                                                .primaryblue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 2,
                                                        ),
                                                        SizedBox(
                                                          width: MediaQuery.of(
                                                                context,
                                                              ).size.width /
                                                              2,
                                                          child: Text(
                                                            "${productDat.packagingType}",
                                                            style:
                                                                MyText.caption(
                                                              context,
                                                            )!
                                                                    .copyWith(
                                                              color: MyColors
                                                                  .grey_5,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: <Widget>[
                                                        Text(
                                                          "Weight",
                                                          style: MyText.body1(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color: MyColors
                                                                .primaryblue,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 2,
                                                        ),
                                                        Text(
                                                          "${productDat.weight}${productDat.weightType}",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: MyText.caption(
                                                            context,
                                                          )!
                                                              .copyWith(
                                                            color:
                                                                MyColors.grey_5,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Container(height: 10),
                                                const Divider(
                                                  height: 1,
                                                  color: Colors.black,
                                                ),
                                              ],
                                            );
                                          },
                                        ),
                                      ),
                                    )
                                  : Container(),
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          child: const Icon(
                                            Icons.grading_outlined,
                                            color: MyColors.primaryblue,
                                            size: 20,
                                          ),
                                        ),
                                        Container(width: 15),
                                        InkWell(
                                          onTap: wbsReportDetail!.workOrder ==
                                                  'Yes'
                                              ? () async {
                                                  await Get.to(
                                                    PDFViewerPage(
                                                      title: 'Work Order',
                                                      bidId:
                                                          wbsReportDetail!.id,
                                                      podUrl: '',
                                                      retRef: 'reportDetail',
                                                    ),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                            "Work Order",
                                            style: MyText.body1(
                                              context,
                                            )!
                                                .copyWith(
                                              fontSize: 16 *
                                                  MediaQuery.of(
                                                    context,
                                                  ).textScaleFactor,
                                              color:
                                                  wbsReportDetail!.workOrder ==
                                                          'Yes'
                                                      ? MyColors.primaryblue
                                                      : MyColors.grey_40,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    Container(height: 20),
                                    Row(
                                      children: <Widget>[
                                        Container(
                                          width: 50,
                                          child: const Icon(
                                            Icons.description_outlined,
                                            color: MyColors.primaryblue,
                                            size: 20,
                                          ),
                                        ),
                                        Container(width: 15),
                                        InkWell(
                                          onTap: wbsReportDetail!.invoice ==
                                                  'Yes'
                                              ? () async {
                                                  await Get.to(
                                                    PDFViewerPage(
                                                      title: 'Proforma Invoice',
                                                      bidId:
                                                          wbsReportDetail!.id,
                                                      podUrl: '',
                                                      retRef: 'reportDetail',
                                                    ),
                                                  );
                                                }
                                              : null,
                                          child: Text(
                                            "Proforma Invoice",
                                            style:
                                                MyText.body1(context)!.copyWith(
                                              fontSize: 16 *
                                                  MediaQuery.of(
                                                    context,
                                                  ).textScaleFactor,
                                              color: wbsReportDetail!.invoice ==
                                                      'Yes'
                                                  ? MyColors.primaryblue
                                                  : MyColors.grey_40,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    Container(height: 20),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          showNegotiations = !showNegotiations;
                                        });
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 50,
                                            child: SvgPicture.asset(
                                              Constant.negoSVG,
                                              color: MyColors.primaryblue,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ),
                                          Container(width: 15),
                                          Text(
                                            "Negotiations",
                                            style: MyText.body1(
                                              context,
                                            )!
                                                .copyWith(
                                              fontSize: 16 *
                                                  MediaQuery.of(
                                                    context,
                                                  ).textScaleFactor,
                                              color:
                                                  wbsReportDetail!.workOrder ==
                                                          'Yes'
                                                      ? MyColors.primaryblue
                                                      : MyColors.grey_40,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            child: showNegotiations
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showNegotiations
                                        ? Column(
                                            children: [
                                              wbsReportDetail!.negotiations !=
                                                          null &&
                                                      wbsReportDetail!
                                                              .negotiations!
                                                              .length >
                                                          0
                                                  ? ListView.builder(
                                                      primary: false,
                                                      reverse: false,
                                                      // controller: _scrollController,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                        8,
                                                      ),
                                                      itemCount:
                                                          wbsReportDetail!
                                                              .negotiations!
                                                              .length,
                                                      itemBuilder: (
                                                        BuildContext context,
                                                        int index,
                                                      ) {
                                                        return wbsReportDetail!
                                                                    .negotiations![
                                                                        index]
                                                                    .senderType !=
                                                                'vendor'
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 13,
                                                                  ),
                                                                  Text(
                                                                    "${wbsReportDetail!.negotiations![index].senderData!.cusName}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                20,
                                                                        width: MediaQuery.of(context).size.height /
                                                                            20,
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            "${wbsReportDetail!.negotiations![index].senderData!.logo}",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      wbsReportDetail!.negotiations![index].message !=
                                                                              null
                                                                          ? Card(
                                                                              color: Colors.grey.shade300,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                                                child: Text(
                                                                                  "${wbsReportDetail!.negotiations![index].message}",
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      wbsReportDetail!.negotiations![index].attachment !=
                                                                              null
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                Get.to(ZoomImage(wbsReportDetail!.negotiations![index].attachment));
                                                                              },
                                                                              child: Container(
                                                                                height: 100,
                                                                                width: 100,
                                                                                child: Card(
                                                                                  color: Colors.grey.shade300,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
                                                                                    child: Image.network(
                                                                                      "${wbsReportDetail!.negotiations![index].attachment}",
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                      "MMM dd, h:mm a",
                                                                    ).format(
                                                                      DateTime
                                                                          .parse(
                                                                        "${wbsReportDetail!.negotiations![index].sentAt!}",
                                                                      ).toLocal(),
                                                                    ),
                                                                    // "${GetTimeAgo.parse(wbsReportDetail!.negotiations![index].sentAt!)}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 13,
                                                                  ),
                                                                  Text(
                                                                    "${wbsReportDetail!.negotiations![index].senderData!.cusName ?? ''}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      wbsReportDetail!.negotiations![index].message !=
                                                                              null
                                                                          ? Card(
                                                                              color: Colors.blue.shade800,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                                                child: Text(
                                                                                  "${wbsReportDetail!.negotiations![index].message}",
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      wbsReportDetail!.negotiations![index].attachment !=
                                                                              null
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                Get.to(ZoomImage(wbsReportDetail!.negotiations![index].attachment));
                                                                              },
                                                                              child: Container(
                                                                                width: 100,
                                                                                height: 100,
                                                                                child: Card(
                                                                                  color: Colors.blue.shade800,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
                                                                                    child: Image.network(
                                                                                      "${wbsReportDetail!.negotiations![index].attachment}",
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                20,
                                                                        width: MediaQuery.of(context).size.height /
                                                                            20,
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            "${wbsReportDetail!.negotiations![index].senderData!.logo}",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                      "MMM dd, h:mm a",
                                                                    ).format(
                                                                      DateTime
                                                                          .parse(
                                                                        "${wbsReportDetail!.negotiations![index].sentAt!}",
                                                                      ).toLocal(),
                                                                    ),
                                                                    // "${GetTimeAgo.parse(wbsReportDetail!.negotiations![index].sentAt!)}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                      },
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'There are no chat(s)',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: MyText.caption(
                                                          context,
                                                        )!
                                                            .copyWith(
                                                          fontSize: 16 *
                                                              MediaQuery.of(
                                                                context,
                                                              ).textScaleFactor,
                                                          color:
                                                              MyColors.grey_5,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        : Container(),
                                    Container(height: 20),
                                    InkWell(
                                      onTap: () async {
                                        setState(() {
                                          showWONegotiations =
                                              !showWONegotiations;
                                        });
                                      },
                                      child: Row(
                                        children: <Widget>[
                                          Container(
                                            width: 50,
                                            child: SvgPicture.asset(
                                              Constant.negoSVG,
                                              color: MyColors.primaryblue,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                          ),
                                          Container(width: 15),
                                          Text(
                                            "WO Negotiations",
                                            style: MyText.body1(
                                              context,
                                            )!
                                                .copyWith(
                                              fontSize: 16 *
                                                  MediaQuery.of(
                                                    context,
                                                  ).textScaleFactor,
                                              color:
                                                  wbsReportDetail!.workOrder ==
                                                          'Yes'
                                                      ? MyColors.primaryblue
                                                      : MyColors.grey_40,
                                              decoration:
                                                  TextDecoration.underline,
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            child: showWONegotiations
                                                ? Icon(
                                                    Icons.keyboard_arrow_up,
                                                  )
                                                : Icon(
                                                    Icons.keyboard_arrow_down,
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    showWONegotiations
                                        ? Column(
                                            children: [
                                              wbsReportDetail!.wOnegotiations !=
                                                          null &&
                                                      wbsReportDetail!
                                                              .wOnegotiations!
                                                              .length >
                                                          0
                                                  ? ListView.builder(
                                                      primary: false,
                                                      reverse: false,
                                                      // controller: _scrollController,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      shrinkWrap: true,
                                                      padding:
                                                          const EdgeInsets.all(
                                                        8,
                                                      ),
                                                      itemCount:
                                                          wbsReportDetail!
                                                              .wOnegotiations!
                                                              .length,
                                                      itemBuilder: (
                                                        BuildContext context,
                                                        int index,
                                                      ) {
                                                        return wbsReportDetail!
                                                                    .wOnegotiations![
                                                                        index]
                                                                    .senderType !=
                                                                'vendor'
                                                            ? Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 13,
                                                                  ),
                                                                  Text(
                                                                    "${wbsReportDetail!.wOnegotiations![index].senderData!.cusName}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                20,
                                                                        width: MediaQuery.of(context).size.height /
                                                                            20,
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            "${wbsReportDetail!.wOnegotiations![index].senderData!.logo}",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      wbsReportDetail!.wOnegotiations![index].message !=
                                                                              null
                                                                          ? Card(
                                                                              color: Colors.grey.shade300,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                                                child: Text(
                                                                                  "${wbsReportDetail!.wOnegotiations![index].message}",
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      wbsReportDetail!.wOnegotiations![index].attachment !=
                                                                              null
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                Get.to(ZoomImage(wbsReportDetail!.wOnegotiations![index].attachment));
                                                                              },
                                                                              child: Container(
                                                                                height: 100,
                                                                                width: 100,
                                                                                child: Card(
                                                                                  color: Colors.grey.shade300,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
                                                                                    child: Image.network(
                                                                                      "${wbsReportDetail!.wOnegotiations![index].attachment}",
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                      "MMM dd, h:mm a",
                                                                    ).format(
                                                                      DateTime
                                                                          .parse(
                                                                        "${wbsReportDetail!.wOnegotiations![index].sentAt!}",
                                                                      ).toLocal(),
                                                                    ),
                                                                    // "${GetTimeAgo.parse(wbsReportDetail!.wOnegotiations![index].sentAt!)}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            : Column(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .end,
                                                                children: [
                                                                  const SizedBox(
                                                                    height: 13,
                                                                  ),
                                                                  Text(
                                                                    "${wbsReportDetail!.wOnegotiations![index].senderData!.cusName ?? ''}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                  Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .end,
                                                                    children: [
                                                                      wbsReportDetail!.wOnegotiations![index].message !=
                                                                              null
                                                                          ? Card(
                                                                              color: Colors.blue.shade800,
                                                                              shape: RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(10),
                                                                              ),
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
                                                                                child: Text(
                                                                                  "${wbsReportDetail!.wOnegotiations![index].message}",
                                                                                  textAlign: TextAlign.right,
                                                                                  style: TextStyle(color: Colors.white),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      wbsReportDetail!.wOnegotiations![index].attachment !=
                                                                              null
                                                                          ? InkWell(
                                                                              onTap: () {
                                                                                Get.to(ZoomImage(wbsReportDetail!.wOnegotiations![index].attachment));
                                                                              },
                                                                              child: Container(
                                                                                width: 100,
                                                                                height: 100,
                                                                                child: Card(
                                                                                  color: Colors.blue.shade800,
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(5),
                                                                                  ),
                                                                                  child: Padding(
                                                                                    padding: const EdgeInsets.only(left: 2, right: 2, bottom: 2, top: 2),
                                                                                    child: Image.network(
                                                                                      "${wbsReportDetail!.wOnegotiations![index].attachment}",
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            )
                                                                          : Container(),
                                                                      const SizedBox(
                                                                        width:
                                                                            10,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            MediaQuery.of(context).size.height /
                                                                                20,
                                                                        width: MediaQuery.of(context).size.height /
                                                                            20,
                                                                        child:
                                                                            CircleAvatar(
                                                                          backgroundImage:
                                                                              NetworkImage(
                                                                            "${wbsReportDetail!.wOnegotiations![index].senderData!.logo}",
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Text(
                                                                    DateFormat(
                                                                      "MMM dd, h:mm a",
                                                                    ).format(
                                                                      DateTime
                                                                          .parse(
                                                                        "${wbsReportDetail!.wOnegotiations![index].sentAt!}",
                                                                      ).toLocal(),
                                                                    ),
                                                                    // "${GetTimeAgo.parse(wbsReportDetail!.wOnegotiations![index].sentAt!)}",
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .grey
                                                                          .shade800,
                                                                    ),
                                                                  ),
                                                                ],
                                                              );
                                                      },
                                                    )
                                                  : Container(
                                                      padding:
                                                          EdgeInsets.all(8.0),
                                                      child: Text(
                                                        'There are no chat(s)',
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: MyText.caption(
                                                          context,
                                                        )!
                                                            .copyWith(
                                                          fontSize: 16 *
                                                              MediaQuery.of(
                                                                context,
                                                              ).textScaleFactor,
                                                          color:
                                                              MyColors.grey_5,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          )
                                        : Container(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2),
                          ),
                          margin: const EdgeInsets.symmetric(
                            horizontal: 15,
                            vertical: 10,
                          ),
                          color: Colors.white,
                          elevation: 2,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Column(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 25,
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        SvgPicture.asset(
                                          'assets/icons/accept.svg',
                                          width: 30,
                                          height: 30,
                                        ),
                                        Container(width: 15),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                              "Checkout",
                                              style: MyText.title(context)!
                                                  .copyWith(
                                                color: MyColors.grey_80,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Is Checkout",
                                          wbsReportDetail?.isCheckout == 'Y'
                                              ? 'Yes'
                                              : 'No',
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Checkout on",
                                          "${wbsReportDetail?.checkoutOn}",
                                          null,
                                        ),
                                      ],
                                    ),
                                    Container(height: 10),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        doubleRowWidget(
                                          "Consignment Type",
                                          "${wbsReportDetail?.consignmentType}",
                                          null,
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: 5,
                                          ),
                                        ),
                                        doubleRowWidget(
                                          "Consignment Loading Type",
                                          "${wbsReportDetail?.consignmentLoadingType}",
                                          null,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
          }),
        ),
      ),
    );
  }

  Widget doubleRowWidget(title, content, iconw) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width / 2.5,
            child: Text(
              "$title",
              textAlign: TextAlign.center,
              style: MyText.body1(context)!.copyWith(
                color: MyColors.primaryblue,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Container(height: 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              iconw != null
                  ? Icon(
                      iconw,
                      color: MyColors.grey_30,
                      size: 20,
                    )
                  : Container(),
              iconw != null ? Container(width: 5) : Container(),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                child: Text(
                  "$content",
                  textAlign: TextAlign.center,
                  style:
                      MyText.caption(context)!.copyWith(color: MyColors.grey_5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
