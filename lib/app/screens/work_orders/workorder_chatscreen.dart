// ignore_for_file: invalid_use_of_protected_member

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';
import 'package:las_warehouse/app/data/models/completed_BidDetail_model.dart';
import 'package:las_warehouse/app/data/models/workorder_chatmodel.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/zoom_image.dart';
import 'package:las_warehouse/app/screens/work_orders/work_orders.dart';

import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';

class WorkOrderChatScreen extends StatefulWidget {
  final String? bidId;
  // final String? bookingType;
  // final String? finalPrice;

  const WorkOrderChatScreen({super.key, this.bidId});

  @override
  State<WorkOrderChatScreen> createState() => _WorkOrderChatScreenState();
}

class _WorkOrderChatScreenState extends State<WorkOrderChatScreen> {
  // String? bidId;
  // _WorkOrderChatScreenState(this.bidId);
  CompletedBidDetailData completedOrders = CompletedBidDetailData();
  final workOrderController = Get.put(WorkOrderController());
  final completedOrderController = Get.put(CompletedOrdersController());
  TextEditingController _biddingPriceController = TextEditingController();
  TextEditingController _biddingConfirmPriceController =
      TextEditingController();
  final formatCurrency = NumberFormat("#,##,000.00", "en_US");
  List<WorkorderChat> workorderchatHistory = [];
  bool showTextField = false;

  ScrollController? _scrollController;

  @override
  void initState() {
    getData();
    _scrollController = ScrollController();
    // SchedulerBinding.instance.addPostFrameCallback((_) {
    //   _scrollController!.jumpTo(_scrollController!.position.maxScrollExtent);
    // });
    super.initState();
  }

  getData() async {
    await Get.put(CompletedOrdersController())
        .completedBidDetailsAPI(widget.bidId!);
    await workOrderController
        .workorderBidNegotiationsAPI(widget.bidId!)
        .then((value) {
      if (value != null) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          _scrollController!
              .jumpTo(_scrollController!.position.maxScrollExtent);
        });
      }
    });
  }

  @override
  void dispose() {
    _scrollController!.dispose();
    super.dispose();
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        bottomNavigationBar: IconTheme(
          data: IconThemeData(
            color: _biddingPriceController.text.isNotEmpty
                ? MyColors.primaryblue
                : MyColors.grey_20,
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              color: Colors.white,
            ),
            padding: EdgeInsets.only(
              left: 10.0,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 0.0),
            child: Row(
              children: <Widget>[
                const SizedBox(width: 1),
                Flexible(
                  child: TextField(
                    controller: _biddingPriceController,
                    maxLines: 15,
                    minLines: 1,
                    autofocus: false,
                    onChanged: (String messageText) {
                      setState(() {});
                    },
                    decoration: const InputDecoration.collapsed(
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      // border: OutlineInputBorder(
                      //     borderRadius: BorderRadius.circular(18)),
                      hintText: "Send a message...",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: const Icon(
                      Icons.attach_file,
                      color: MyColors.primaryblue,
                    ),
                    onPressed: () async {
                      await CommonFilePicker().pickAFile(
                        FileType.image,
                        false,
                        [],
                      ).then((value) async {
                        if (value != null) {
                          await workOrderController
                              .uploadWONegotiationAttachment(
                            widget.bidId!,
                            value.files.first.path!,
                          )
                              .then((value) {
                            if (value != null) {
                              SchedulerBinding.instance
                                  .addPostFrameCallback((_) {
                                _scrollController!.jumpTo(
                                  _scrollController!.position.maxScrollExtent,
                                );
                              });
                            }
                          });
                        }
                      });
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconButton(
                    icon: Transform.rotate(
                      angle: 0,
                      child: const Icon(
                        Icons.send,
                        size: 25,
                      ),
                    ),
                    color: MyColors.primaryblue,
                    onPressed: _biddingPriceController.text.isNotEmpty
                        ? () async {
                            await workOrderController
                                .workorderBidNegotiationEntryAPI(
                              widget.bidId!,
                              _biddingPriceController.text,
                            )
                                .then((value) {
                              if (value != null) {
                                FocusScope.of(context).unfocus();
                                _biddingPriceController.clear();
                                SchedulerBinding.instance
                                    .addPostFrameCallback((_) {
                                  _scrollController!.jumpTo(
                                    _scrollController!.position.maxScrollExtent,
                                  );
                                });
                              }
                            });
                          }
                        : null,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Obx(() {
          workorderchatHistory = workOrderController.workorderchatHistory.value;
          completedOrders =
              completedOrderController.completedBidDetailData.value;
          return workOrderController.load.value ||
                  completedOrderController.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await Get.put(CompletedOrdersController())
                        .completedBidDetailsAPI(widget.bidId!);
                    await workOrderController
                        .workorderBidNegotiationsAPI(widget.bidId!);
                  },
                  child: SingleChildScrollView(
                    child: SizedBox(
                      // padding: const EdgeInsets.only(
                      //     left: 10, right: 10, bottom: 10, top: 10),
                      height: MediaQuery.of(context).size.height - 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              'Booking Type : ${completedOrders.bookingType}',
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 20,
                              top: 10,
                              bottom: 5,
                            ),
                            child: Text(
                              'Bid Price : ₹ ${formatCurrency.format(double.parse(completedOrders.bidPrice!))}',
                            ),
                          ),
                          completedOrders.finalPrice != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'Final Price : ₹ ${completedOrders.finalPrice!}',
                                  ),
                                )
                              : Container(),
                          completedOrders.advancePrice != null
                              ? Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                    top: 5,
                                    bottom: 5,
                                  ),
                                  child: Text(
                                    'Advance Paid : ₹ ${completedOrders.advancePrice!} (${completedOrders.advancePercent!}%)',
                                  ),
                                )
                              : Container(),
                          Container(
                            // height: MediaQuery.of(context).size.height,
                            //height: MediaQuery.of(context).size.height/2,
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                              bottom: 10,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                showTextField
                                    ? IconTheme(
                                        data: IconThemeData(
                                          color: _biddingConfirmPriceController
                                                  .text.isNotEmpty
                                              ? MyColors.primaryblue
                                              : MyColors.grey_20,
                                        ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            border: Border.all(),
                                          ),
                                          padding: const EdgeInsets.only(
                                            left: 5.0,
                                            right: 0.0,
                                          ),
                                          margin: const EdgeInsets.symmetric(
                                            horizontal: 8.0,
                                          ),
                                          child: Row(
                                            children: <Widget>[
                                              const SizedBox(width: 1),
                                              Flexible(
                                                child: TextField(
                                                  inputFormatters: [
                                                    FilteringTextInputFormatter
                                                        .allow(
                                                      RegExp(
                                                        '[0-9.]',
                                                      ),
                                                    ),
                                                    FilteringTextInputFormatter
                                                        .digitsOnly,
                                                  ],
                                                  controller:
                                                      _biddingConfirmPriceController,
                                                  maxLines: 15,
                                                  minLines: 1,
                                                  autofocus: false,
                                                  onChanged: (
                                                    String messageText,
                                                  ) {
                                                    setState(() {});
                                                  },
                                                  decoration:
                                                      const InputDecoration
                                                          .collapsed(
                                                    floatingLabelBehavior:
                                                        FloatingLabelBehavior
                                                            .auto,
                                                    // border: OutlineInputBorder(
                                                    //     borderRadius: BorderRadius.circular(18)),
                                                    hintText:
                                                        "Final price negotiated amount",
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 4.0,
                                                ),
                                                child: IconButton(
                                                  icon: Transform.rotate(
                                                    angle: 0,
                                                    child: const Icon(
                                                      Icons.send,
                                                      size: 25,
                                                    ),
                                                  ),
                                                  color: MyColors.primaryblue,
                                                  onPressed:
                                                      _biddingConfirmPriceController
                                                              .text.isNotEmpty
                                                          ? () async {
                                                              if (_biddingConfirmPriceController
                                                                  .text
                                                                  .isNotEmpty) {
                                                                await workOrderController
                                                                    .workorderBidPriceConfirmAPI(
                                                                  widget.bidId!,
                                                                  _biddingConfirmPriceController
                                                                      .text,
                                                                )
                                                                    .then(
                                                                        (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    FocusScope
                                                                        .of(
                                                                      context,
                                                                    ).unfocus();
                                                                    _biddingConfirmPriceController
                                                                        .clear();
                                                                    Get.offAll(
                                                                      const WorkOrdersPage(),
                                                                    );
                                                                  }
                                                                });
                                                              }
                                                            }
                                                          : null,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.offAll(
                                          const WorkOrdersPage(),
                                        );
                                      },
                                      child: const Icon(Icons.arrow_back),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      "Price Negotiation",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                      ),
                                    ),
                                    const Expanded(
                                      child: SizedBox(
                                        width: 5.0,
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          showTextField = !showTextField;
                                        });
                                      },
                                      child: Text(
                                        "Final Negotiation",
                                        style: TextStyle(
                                          fontWeight: FontWeight.normal,
                                          color: MyColors.primaryblue,
                                          fontSize: 16 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color: Colors.white,
                                  height: MediaQuery.of(context).size.height -
                                      (MediaQuery.of(context).size.height *
                                          0.35),
                                  child: ListView.builder(
                                    primary: false,
                                    reverse: false,
                                    controller: _scrollController,
                                    physics:
                                        const AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: false,
                                    padding: EdgeInsets.only(
                                      left: 8,
                                      right: 8.0,
                                      top: 8.0,
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom,
                                    ),
                                    itemCount: workorderchatHistory.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return workorderchatHistory[index]
                                                  .senderType !=
                                              'vendor'
                                          ? Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Text(
                                                  "${workorderchatHistory[index].senderData!.cusName}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.height /
                                                          20,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.height /
                                                          20,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "${workorderchatHistory[index].senderData!.logo}",
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    workorderchatHistory[index]
                                                                .message !=
                                                            null
                                                        ? Card(
                                                            color: Colors
                                                                .grey.shade300,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 10,
                                                                top: 10,
                                                              ),
                                                              child: Text(
                                                                "${workorderchatHistory[index].message}",
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    workorderchatHistory[index]
                                                                .attachment !=
                                                            null
                                                        ? InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                ZoomImage(
                                                                  workorderchatHistory[
                                                                          index]
                                                                      .attachment,
                                                                ),
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              height: 100,
                                                              width: 100,
                                                              child: Card(
                                                                color: Colors
                                                                    .grey
                                                                    .shade300,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    10,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 2,
                                                                    right: 2,
                                                                    bottom: 2,
                                                                    top: 2,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    "${workorderchatHistory[index].attachment}",
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
                                                    DateTime.parse(
                                                      "${workorderchatHistory[index].sentAt!}",
                                                    ).toLocal(),
                                                  ),
                                                  // "${GetTimeAgo.parse(workorderchatHistory[index].sentAt!)}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              ],
                                            )
                                          : Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                const SizedBox(
                                                  height: 13,
                                                ),
                                                Text(
                                                  "${workorderchatHistory[index].senderData!.vendorName}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    workorderchatHistory[index]
                                                                .message !=
                                                            null
                                                        ? Card(
                                                            color: Colors
                                                                .blue.shade800,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                10,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                left: 10,
                                                                right: 10,
                                                                bottom: 10,
                                                                top: 10,
                                                              ),
                                                              child: Text(
                                                                "${workorderchatHistory[index].message}",
                                                                textAlign:
                                                                    TextAlign
                                                                        .right,
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    workorderchatHistory[index]
                                                                .attachment !=
                                                            null
                                                        ? InkWell(
                                                            onTap: () {
                                                              Get.to(
                                                                ZoomImage(
                                                                  workorderchatHistory[
                                                                          index]
                                                                      .attachment,
                                                                ),
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              width: 100,
                                                              height: 100,
                                                              child: Card(
                                                                color: Colors
                                                                    .blue
                                                                    .shade800,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    5,
                                                                  ),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    left: 2,
                                                                    right: 2,
                                                                    bottom: 2,
                                                                    top: 2,
                                                                  ),
                                                                  child: Image
                                                                      .network(
                                                                    "${workorderchatHistory[index].attachment}",
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                    const SizedBox(
                                                      width: 10,
                                                    ),
                                                    SizedBox(
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.height /
                                                          20,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.height /
                                                          20,
                                                      child: CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                          "${workorderchatHistory[index].senderData!.logo}",
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  DateFormat(
                                                    "MMM dd, h:mm a",
                                                  ).format(
                                                    DateTime.parse(
                                                      "${workorderchatHistory[index].sentAt!}",
                                                    ).toLocal(),
                                                  ),
                                                  // "${GetTimeAgo.parse(workorderchatHistory[index].sentAt!)}",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                  ),
                                                ),
                                              ],
                                            );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Expanded(
                            child: SizedBox(
                              height: 5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
