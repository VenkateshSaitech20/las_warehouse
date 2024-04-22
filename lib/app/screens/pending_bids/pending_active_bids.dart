// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/data/controller/pending_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/pendingbids_model.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';

class PendingActiveBidsPage extends StatefulWidget {
  const PendingActiveBidsPage({super.key});

  @override
  State<PendingActiveBidsPage> createState() => _PendingActiveBidsPageState();
}

class _PendingActiveBidsPageState extends State<PendingActiveBidsPage> {
  final pendingBidsController = Get.put(PendingBidsController());
  List<List<PendingBidsData>> pendingBidsList = [];

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  Widget OrderCard(List<PendingBidsData> pendingBids) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: pendingBids.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            index == 0
                ? Container(
                    padding: const EdgeInsets.only(left: 5.0, top: 8),
                    child: Text(
                      '${pendingBids[0].city}',
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
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 0),
                          child: SizedBox(
                            // width: MediaQuery.of(context).size.width / 6,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.network(
                                '${pendingBids[index].customer!.logo}',
                                width: MediaQuery.of(context).size.width / 7,
                                height: MediaQuery.of(context).size.width / 7,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 30,
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
                                        '${pendingBids[index].customer!.cusName}',
                                        style: MyText.customText16(context)!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      color: MyColors.grey_90,
                                      border: Border.all(
                                        color: MyColors.grey_90,
                                      ),
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(6),
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(
                                        '₹' +
                                            '${pendingBids[index].finalPrice!}',
                                        style: MyText.customHintText13(context)!
                                            .copyWith(
                                          color: MyColors.grey_5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.0,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${pendingBids[index].availableWarehouseType}'
                                  //  "${orderBiddingData[index].bookingType}"
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
                    const SizedBox(height: 5),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "From : ",
                            style: MyText.customText13(context)!
                                .copyWith(color: MyColors.grey_70),
                          ),
                          SizedBox(
                            // width:80,
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              '${pendingBids[index].fromDateTime}',
                              style: MyText.customText13(context)!
                                  .copyWith(color: MyColors.grey_50),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 70,
                          ),
                          Text(
                            "|",
                            style: MyText.customText13(context)!
                                .copyWith(color: MyColors.grey),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 70,
                          ),
                          Text(
                            "To : ",
                            style: MyText.customText13(context)!
                                .copyWith(color: MyColors.grey_70),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: Text(
                              textAlign: TextAlign.center,
                              '${pendingBids[index].toDateTime}',
                              style: MyText.customText13(context)!
                                  .copyWith(color: MyColors.grey_50),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.6,
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                Constant.warehouseSVG,
                                width: MediaQuery.of(context).size.width / 18,
                                height: MediaQuery.of(context).size.width / 18,
                              ),
                              const SizedBox(width: 3),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 4.9,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${pendingBids[index].bookingType!}',
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: MyColors.grey_5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 5),
                        '${pendingBids[index].finalPriceConfirmed}' != "Y"
                            ? InkWell(
                                onTap: () async {
                                  Get.toNamed(
                                    '/negotiations',
                                    arguments: pendingBids[index].id,
                                  );
                                  // Get.to(ChatScreen(
                                  //   bidId: pendingBids[index].id,
                                  // ));
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 3.6,
                                  child: Row(
                                    children: [
                                      SvgPicture.asset(
                                        Constant.negoSVG,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                        height:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Text(
                                        "Negotiation",
                                        style: MyText.customHintText13(context)!
                                            .copyWith(
                                          color: MyColors.primaryblue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : Container(
                                width: MediaQuery.of(context).size.width / 3.6,
                              ),
                        InkWell(
                          onTap: () async {
                            final action = await Dialogs.alertDialog(
                              context,
                              "",
                              '${Constant.messages.bidCancel ?? "Are you sure want to accept this bid?"}',
                              "Cancel",
                              "Confirm",
                            );
                            if (action == alertDialogAction.save) {
                              pendingBidsController
                                  .cancelBidAPI(pendingBids[index].id);
                            }

                            if (action == alertDialogAction.cancel) {}
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 3.6,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SvgPicture.asset(
                                  Constant.cancelSVG,
                                  width: MediaQuery.of(context).size.width / 20,
                                  height:
                                      MediaQuery.of(context).size.width / 20,
                                  color: Colors.red,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Cancel",
                                  style: MyText.customHintText13(context)!
                                      .copyWith(color: Colors.red),
                                ),
                              ],
                            ),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    pendingBidsList = pendingBidsController.pendingBidsDataList;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: MyColors.grey_1,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Obx(
          () => pendingBidsController.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await pendingBidsController.pendingBidsAPI();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            "Pending",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize:
                                  18 * MediaQuery.of(context).textScaleFactor,
                            ),
                          ),
                        ),
                        pendingBidsList.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: pendingBidsList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OrderCard(pendingBidsList[index]);
                                },
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: Center(
                                  child: Text(
                                    Constant.messages.noPending ??
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
                ),
        ),
      ),
    );
  }
}
