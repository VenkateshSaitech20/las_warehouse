// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors_in_immutables
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/models/completed_BidDetail_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';

class Customerdetails extends StatefulWidget {
  Customerdetails({super.key, required});

  @override
  State<Customerdetails> createState() => _CustomerdetailsState();
}

class _CustomerdetailsState extends State<Customerdetails> {
  CompletedBidDetailData completedOrders = CompletedBidDetailData();
  final completedOrdersController = Get.put(CompletedOrdersController());
  var productData;

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    completedOrders = completedOrdersController.completedBidDetailData.value;
    productData = json.decode(completedOrders.materialTypeData!);
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        body: Obx(
          () => completedOrdersController.load.value
              ? LoaderWidget('')
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 15,
                      right: 15,
                      top: 15,
                      bottom: 15,
                    ),
                    child: SafeArea(
                      child: Column(
                        children: [
                          Text(
                            "Customer Details ",
                            style: TextStyle(
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${completedOrders.customer?.cusName}",
                            style: TextStyle(
                              color: MyColors.primaryblue,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.height,
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
                                  left: 10,
                                  right: 10,
                                  top: 10,
                                  bottom: 10,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 10),
                                    Text(
                                      "Booking Type",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.bookingType}",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "From Date",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                          color: MyColors.primaryblue,
                                        ),
                                        Text(
                                          " ${completedOrders.fromDateTime}",
                                          style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "To Date",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.calendar_month_outlined,
                                          size: 15,
                                          color: MyColors.primaryblue,
                                        ),
                                        Text(
                                          " ${completedOrders.toDateTime}",
                                          style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "City",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/locator.svg',
                                          height: 20,
                                          width: 20,
                                          color: MyColors.primaryblue,
                                        ),
                                        Text(
                                          "${completedOrders.city}",
                                          softWrap: true,
                                          style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Preferred Location",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        // SvgPicture.asset(
                                        //   'assets/icons/locator.svg',
                                        //   height: 20,
                                        //   width: 20,
                                        //   color: MyColors.primaryblue,
                                        // ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width -
                                              80,
                                          child: Text(
                                            "${completedOrders.preferredLocation}",
                                            softWrap: true,
                                            maxLines: 2,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 14 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    productData.length > 0 &&
                                            productData != null
                                        ? ListView.builder(
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemCount: productData.length,
                                            itemBuilder: (
                                              BuildContext context,
                                              int index,
                                            ) {
                                              return Column(
                                                children: [
                                                  Text(
                                                    "Material Type",
                                                    style: TextStyle(
                                                      fontSize: 14 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                      color:
                                                          MyColors.primaryblue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      // Icon(Icons
                                                      //     .spatial_tracking_outlined),
                                                      Text(
                                                        "${productData[index]['materialType']}",
                                                        style: TextStyle(
                                                          fontSize: 14 *
                                                              MediaQuery.of(
                                                                context,
                                                              ).textScaleFactor,
                                                          color: Colors.black,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Packaging Type",
                                                    style: TextStyle(
                                                      fontSize: 14 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                      color:
                                                          MyColors.primaryblue,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    "${productData[index]['packagingType']}",
                                                    style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    color: MyColors
                                                        .background_grey,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                        top: 8,
                                                        bottom: 8,
                                                        left: 4,
                                                        right: 4,
                                                      ),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Length",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "(${productData[index]['uom']})",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                "${productData[index]['length']}",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Width",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "(${productData[index]['uom']})",
                                                                style:
                                                                    const TextStyle(
                                                                  fontSize: 14,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                "${productData[index]['width']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Height",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "(${productData[index]['uom']})",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                "${productData[index]['height']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Weight",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "(${productData[index]['weightType']})",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                "${productData[index]['weight']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Column(
                                                            children: [
                                                              Text(
                                                                "Quantity",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              Text(
                                                                "",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: MyColors
                                                                      .primaryblue,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              const SizedBox(
                                                                height: 6,
                                                              ),
                                                              Text(
                                                                "${productData[index]['quantity']}",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 14 *
                                                                      MediaQuery
                                                                          .of(
                                                                        context,
                                                                      ).textScaleFactor,
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          )
                                        : Container(),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      height: 2,
                                      color: Colors.black,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Is the Consignment",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${completedOrders.consignmentType} , ${completedOrders.consignmentLoadingType}",
                                          style: TextStyle(
                                            fontSize: 14 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Sq.ft Required",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.reqSqft}Sq.ft.",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Total Quantity",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.totalQuantity}",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      "Total Weight",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.totalWeight}${completedOrders.weightType}",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Warehouse Type",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.availableWarehouseType}",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: MyColors.primaryblue,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      "${completedOrders.itemDescription}",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.grey_60,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.horizontal(),
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_circle_left_outlined,
                                      size: 18,
                                      color: Colors.white,
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      "BACK",
                                      style: TextStyle(
                                        fontSize: 14 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              completedOrders.isInvoiced! != "Y"
                                  ? ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: MyColors.primaryblue,
                                        shape: const RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.horizontal(),
                                        ),
                                      ),
                                      onPressed: () async {
                                        await completedOrdersController
                                            .confirmInvoiceAPI(
                                          completedOrders.id!,
                                        )
                                            .then((value) {
                                          if (value != null) {
                                            if (value['result'] == true) {
                                              Get.offAndToNamed(
                                                'completedorders',
                                              );
                                            }
                                          }
                                        });
                                        // Get.toNamed('/invoicedetails',
                                        //     arguments: completedOrders.id!);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.arrow_circle_right_outlined,
                                            size: 18,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(
                                            width: 3,
                                          ),
                                          Text(
                                            "GENERATE PROFORMA",
                                            style: TextStyle(
                                              fontSize: 14 *
                                                  MediaQuery.of(context)
                                                      .textScaleFactor,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
