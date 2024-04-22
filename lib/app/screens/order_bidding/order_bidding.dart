// ignore_for_file: invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/order_bidding_controller.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/wbs_customer_requirement_model.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';

import '../../data/models/orderbidding_details_model.dart';

class Orderbiddingpage extends StatefulWidget {
  const Orderbiddingpage({super.key});

  @override
  State<Orderbiddingpage> createState() => _OrderbiddingpageState();
}

class _OrderbiddingpageState extends State<Orderbiddingpage> {
  final orderbiddingcontroller = Get.put(OrderBiddingController());
  List<List<WbsRequirement>> orderBiddingDataList = [];
  List<MaterialTypeData> materialTypeList = [];
  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  Widget OrderCard(List<WbsRequirement> orderBiddingData) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orderBiddingData.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            index == 0
                ? Container(
                    padding: const EdgeInsets.only(left: 5.0, top: 8),
                    child: Text(
                      '${orderBiddingData[0].city}',
                      style: TextStyle(
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: MyColors.grey_100_,
                      ),
                    ),
                  )
                : Container(),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.grey),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(
                                '${orderBiddingData[index].customer!.logo}',
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.width / 7,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 0),
                                      child: Text(
                                        '${orderBiddingData[index].customer!.cusName}',
                                        style: MyText.customText16(context)!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: InkWell(
                                      onTap: () async {
                                        print("ontap clicked");
                                        final action =
                                            await Dialogs.alertDialog(
                                          context,
                                          "",
                                          '${Constant.messages.reqNotInterest ?? "Are you not Interested in this Requirement?"}',
                                          "Cancel",
                                          "Confirm",
                                        );
                                        if (action == alertDialogAction.save) {
                                          orderbiddingcontroller
                                              .deleteOrderedBidAPI(
                                            orderBiddingData[index].id!,
                                          );
                                          print('Saved');
                                        }

                                        if (action ==
                                            alertDialogAction.cancel) {
                                          print('canceled');
                                        }
                                      },
                                      child: SvgPicture.asset(
                                        Constant.cancelSVG,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        semanticsLabel: 'Cancel',
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 5.0,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.0,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  "${orderBiddingData[index].availableWarehouseType}"
                                  // +
                                  // " (${orderBiddingData[index].recurringType ?? ''})"
                                  ,
                                  style: MyText.customText15(context)!.copyWith(
                                    color: MyColors.grey_70,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "From : ",
                            style: MyText.customHintText13(context)!.copyWith(
                              color: MyColors.grey_50,
                              fontSize:
                                  14 * MediaQuery.of(context).textScaleFactor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            // width:80,
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              '${orderBiddingData[index].fromDateTime}',
                              style: MyText.customHintText13(context)!.copyWith(
                                color: MyColors.grey_50,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    14 * MediaQuery.of(context).textScaleFactor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 70,
                          ),
                          Text(
                            "|",
                            style: MyText.customHintText13(context)!
                                .copyWith(color: MyColors.grey),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 70,
                          ),
                          Text(
                            "To : ",
                            style: MyText.customHintText13(context)!.copyWith(
                              color: MyColors.grey_50,
                              fontSize:
                                  14 * MediaQuery.of(context).textScaleFactor,
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              '${orderBiddingData[index].toDateTime}',
                              style: MyText.customHintText13(context)!.copyWith(
                                color: MyColors.grey_50,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    14 * MediaQuery.of(context).textScaleFactor,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                Constant.warehouseSVG,
                                width: MediaQuery.of(context).size.width / 20,
                                height: MediaQuery.of(context).size.width / 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 75,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.2,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${orderBiddingData[index].bookingType}',
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: MyColors.grey_5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () async {
                              orderbiddingcontroller.reachedEntryAPI(
                                orderBiddingData[index].id!,
                              );

                              await orderbiddingcontroller
                                  .orderBiddingDetailsAPI(
                                orderBiddingData[index].id!,
                              )
                                  .then((value) async {
                                if (value != null) {
                                  if (value.result == true &&
                                      value.message != null) {
                                    materialTypeList = orderbiddingcontroller
                                        .materialTypeList.value;
                                    String materialString = '';
                                    for (int i = 0;
                                        i < materialTypeList.length;
                                        i++) {
                                      materialString =
                                          materialTypeList[i].materialType! +
                                              ',';
                                    }
                                    await orderbiddingcontroller
                                        .avaibleWarehouseAPI(
                                      orderBiddingData[index].city!,
                                      materialString,
                                      // orderBiddingData[index]
                                      //     .materialType!,
                                      orderBiddingData[index]
                                          .availableWarehouseType!,
                                    )
                                        .then((value) async {
                                      Get.toNamed('/customerreq');
                                    });
                                  }
                                }
                              });
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Constant.activebidSVG,
                                  width: MediaQuery.of(context).size.width / 20,
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Bid",
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: MyColors.primaryGreen,
                                  ),
                                ),
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
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: MyColors.grey_1,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Obx(() {
          orderBiddingDataList =
              orderbiddingcontroller.WbsRequirementList.value;
          return orderbiddingcontroller.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await orderbiddingcontroller.orderBiddingAPI();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            "Order Bidding",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        orderBiddingDataList.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: orderBiddingDataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OrderCard(
                                    orderBiddingDataList[index],
                                  );
                                },
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: Center(
                                  child: Text(
                                    Constant.messages.noActiveBids ??
                                        'Currently Bidding Unavailable',
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
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
