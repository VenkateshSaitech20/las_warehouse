// ignore_for_file: avoid_unnecessary_containers, deprecated_member_use, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/workorders_model.dart';
import 'package:las_warehouse/app/screens/widgets/pdf_viewer.dart';
import 'package:las_warehouse/app/themes/custom_alert_dialog.dart';

class WorkOrdersPage extends StatefulWidget {
  const WorkOrdersPage({super.key});

  @override
  State<WorkOrdersPage> createState() => _WorkOrdersPageState();
}

class _WorkOrdersPageState extends State<WorkOrdersPage> {
  _willPop() {
    Get..back();
  }

  final workorderController = Get.put(WorkOrderController());
  List<List<WorkOrdersData>> workOrdersDataList = [];

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  Widget OrderCard(List<WorkOrdersData> workOrdersList) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: workOrdersList.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            index == 0
                ? Container(
                    padding: const EdgeInsets.only(left: 5.0, top: 8),
                    child: Text(
                      '${workOrdersList[0].city}',
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image(
                              image: ResizeImage(
                                NetworkImage(
                                  '${workOrdersList[index].customer!.logo}',
                                ),
                                width: MediaQuery.of(context).size.width ~/ 6,
                                height: MediaQuery.of(context).size.width ~/ 6,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 45,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${workOrdersList[index].customer!.cusName!}',
                                style: MyText.customText16(context)!.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.0,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  '${workOrdersList[index].bookingType}',
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: MyColors.grey_5,
                                    letterSpacing: 0.0,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: MyColors.grey_90,
                              border: Border.all(
                                color: MyColors.grey_90,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            // width: 70,
                            // height: 20,
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(3.0),
                                child: Text(
                                  '₹' + '${workOrdersList[index].price!}',
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "From : ",
                          style: MyText.customHintText13(context)!
                              .copyWith(color: MyColors.grey),
                        ),
                        SizedBox(
                          // width:80,
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Text(
                            textAlign: TextAlign.center,
                            '${workOrdersList[index].fromDateTime!}',
                            style: MyText.customHintText13(context)!
                                .copyWith(color: MyColors.grey),
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
                          style: MyText.customHintText13(context)!
                              .copyWith(color: MyColors.grey),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 3.5,
                          child: Text(
                            textAlign: TextAlign.center,
                            '${workOrdersList[index].toDateTime}',
                            style: MyText.customHintText13(context)!
                                .copyWith(color: MyColors.grey),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 2.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SvgPicture.asset(
                                Constant.warehouseSVG,
                                width: MediaQuery.of(context).size.width / 20,
                                height: MediaQuery.of(context).size.width / 20,
                              ),
                              const SizedBox(
                                width: 3,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.7,
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  ' ${workOrdersList[index].availableWarehouseType}',
                                  style: MyText.customHintText13(context)!
                                      .copyWith(
                                    color: MyColors.grey_5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Expanded(child: SizedBox(width: 5)),
                        InkWell(
                          onTap: () async {
                            await Get.to(
                              PDFViewerPage(
                                title: 'Work Order',
                                bidId: workOrdersList[index].id,
                                podUrl: '',
                                retRef: 'workorder',
                              ),
                            );
                          },
                          child: Container(
                            // width: 30,
                            // padding:
                            //     const EdgeInsets.only(left: 1, right: 1),
                            // decoration: BoxDecoration(
                            //     border: Border.all(
                            //         color: MyColors.primaryblue)),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  Constant.downloadSVG,
                                  width: MediaQuery.of(context).size.width / 18,
                                  height:
                                      MediaQuery.of(context).size.width / 18,
                                  color: MyColors.primaryLight,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                SizedBox(
                                  // width: MediaQuery.of(context).size.width /
                                  //     2.5,
                                  child: Text(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    'Workorder',
                                    style: MyText.customHintText13(context)!
                                        .copyWith(
                                      color: MyColors.primaryblue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    workOrdersList[index].showCheckOut == true
                        ? const SizedBox(
                            height: 5,
                          )
                        : Container(),
                    workOrdersList[index].showCheckOut == true
                        ? Row(
                            children: [
                              workOrdersList[index].isCheckout == 'Y'
                                  ? InkWell(
                                      onTap: () async {
                                        Get.toNamed(
                                          '/wonegotiations',
                                          arguments: workOrdersList[index].id,
                                        );
                                        // Get.to(WorkOrderChatScreen(
                                        //   bidId: workOrdersList[index].id,
                                        // ));
                                      },
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Constant.negoSVG,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Negotiation",
                                              style: MyText.customHintText13(
                                                context,
                                              )!
                                                  .copyWith(
                                                color: MyColors.primaryblue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () async {
                                        final action =
                                            await Dialogs.alertDialog(
                                          context,
                                          "",
                                          '${Constant.messages.chkOutBid ?? "Are you sure want to checkout this work-order?"}',
                                          "Cancel",
                                          "Confirm",
                                        );
                                        if (action == alertDialogAction.save) {
                                          await workorderController
                                              .checkoutAPI(
                                            workOrdersList[index].id!,
                                          )
                                              .then((value) {
                                            if (value != null) {
                                              //Get.offAll(Completedpage());
                                            }
                                          });
                                        }

                                        if (action ==
                                            alertDialogAction.cancel) {}
                                      },
                                      child: Container(
                                        // width: 30,
                                        // padding: const EdgeInsets.only(
                                        //     left: 1, right: 1),
                                        // decoration: BoxDecoration(
                                        //     border: Border.all(
                                        //         color: MyColors.primaryblue)),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                              Constant.checkoutSVG,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  20,
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Text(
                                              "Checkout",
                                              style: MyText.customHintText13(
                                                context,
                                              )!
                                                  .copyWith(
                                                color: MyColors.primaryblue,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          )
                        : Container(),
                    //   ],
                    // ),
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
          workOrdersDataList = workorderController.workOrdersDataList.value;
          return workorderController.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await workorderController.workOrdersListAPI();
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10, left: 0),
                          child: Text(
                            "Work Orders",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        workOrdersDataList.length > 0
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(8),
                                itemCount: workOrdersDataList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return OrderCard(workOrdersDataList[index]);
                                },
                              )
                            : SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 1.25,
                                child: Center(
                                  child: Text(
                                    Constant.messages.noBookings ??
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
