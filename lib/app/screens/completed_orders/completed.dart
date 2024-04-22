// ignore_for_file: invalid_use_of_protected_member, avoid_unnecessary_containers, deprecated_member_use

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/completed_controller.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/completedOrders_model.dart';
import 'package:las_warehouse/app/screens/widgets/pdf_viewer.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class Completedpage extends StatefulWidget {
  const Completedpage({super.key});

  @override
  State<Completedpage> createState() => _CompletedpageState();
}

class _CompletedpageState extends State<Completedpage> {
  _willPop() {
    Get.toNamed('/dashboard');
  }

  String? filePath;
  sendEmailFunctions(String bidId) async {
    Get.put(WorkOrderController().downloadInvoiceAPI(bidId))
        .then((value) async {
      if (value != null) {
        if (value.result == true) {
          final response = await http.get(Uri.parse(value.message!));

          if (response.statusCode == 200) {
            final appDocDir = await getApplicationDocumentsDirectory();
            filePath = '${appDocDir.path}/Invoice.pdf';
            final file = File(filePath!);

            await file.writeAsBytes(response.bodyBytes);

            final Email email = Email(
              subject: 'Invoice pdf from $bidId',
              recipients: [],
              attachmentPaths: [filePath!],
              isHTML: false,
            );

            await FlutterEmailSender.send(email);
          } else {
            throw Exception('Failed to download PDF');
          }
        } else {
          ShowToastDialog.showToast(value.message!);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
  }

  final completedOrderController = Get.put(CompletedOrdersController());
  List<List<CompletedOrdersData>> completedOrdersdataList = [];

  Widget OrderCard(List<CompletedOrdersData> completedOrders) {
    void showFileUploadDialog(BuildContext context, bidId) async {
      showFileDialog() {
        return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('File Selected'),
              content: Text('File : ${filePath!.split('/').last}'),
              actions: <Widget>[
                TextButton(
                  child: const Text('Upload'),
                  onPressed: () {
                    completedOrderController
                        .uploadInvoicePdfAPI(bidId, filePath)
                        .then((value) {
                      if (value != null) {
                        if (value.result == true) {
                          ShowToastDialog.showToast(value.message);
                          Navigator.of(context).pop();
                        }
                      }
                    });
                  },
                ),
              ],
            );
          },
        );
      }

      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );

      if (result != null) {
        String? filePath = result.files.single.path;
        if (filePath != null) {
          // Process the selected file (e.g., upload it to a server)
          // Here, we're just displaying the file path
          showFileDialog();
        }
      }
    }

    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: completedOrders.length,
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            index == 0
                ? Container(
                    padding: const EdgeInsets.only(left: 5.0, top: 8),
                    child: Text(
                      '${completedOrders[0].city}',
                      style: TextStyle(
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.5,
                        color: MyColors.grey_5,
                      ),
                    ),
                  )
                : Container(),
            Card(
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Container(
                // color: Colors.red,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          // width: MediaQuery.of(context).size.width / 6,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              '${completedOrders[index].customer!.logo}',
                              width: MediaQuery.of(context).size.width / 7,
                              height: MediaQuery.of(context).size.width / 7,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.41,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: Text(
                                      '${completedOrders[index].customer?.cusName}',
                                      maxLines: 2,
                                      style: MyText.customText16(context)!
                                          .copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        // width:
                                        //     MediaQuery.of(context).size.width /
                                        //         3.6,
                                        child: Text(
                                          overflow: TextOverflow.ellipsis,
                                          '${completedOrders[index].bookingType}',
                                          style: MyText.customText15(
                                            context,
                                          )!
                                              .copyWith(
                                            color: MyColors.grey_70,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      completedOrders[index].rating != null
                                          ? Container(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    completedOrders[index]
                                                                .rating ==
                                                            null
                                                        ? Icons
                                                            .star_border_outlined
                                                        : Icons.star,
                                                    color: MyColors.primaryblue,
                                                    size: 20,
                                                  ),
                                                  const SizedBox(
                                                    width: 1.0,
                                                  ),
                                                  Text(
                                                    "(${completedOrders[index].rating ?? '0'})",
                                                    style: TextStyle(
                                                      fontSize: 12 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                      color: MyColors.grey_100_,
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
                              const Expanded(
                                child: SizedBox(
                                  width: 5,
                                ),
                              ),
                              InkWell(
                                onTap: () async {
                                  await completedOrderController
                                      .completedBidDetailsAPI(
                                    completedOrders[index].id!,
                                  )
                                      .then((value) {
                                    Get.toNamed('/customerinfo');
                                  });
                                },
                                child: SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 7.5,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            left: 5,
                                            top: 5,
                                            right: 5,
                                            bottom: 5,
                                          ),
                                          child: SvgPicture.asset(
                                            Constant.infoSVG,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                18,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                18,
                                          ),
                                        ),
                                      ),
                                      // const SizedBox(height: 5),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                7.5,
                                        child: Text(
                                          '${completedOrders[index].paymentStatus}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 13 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                            color: completedOrders[index]
                                                        .paymentStatus! ==
                                                    "Paid"
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Expanded(child: const SizedBox(width: 5)),
                      ],
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 30,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,

                        children: [
                          completedOrders[index].isInvoiced == "N"
                              ? Container()
                              : SizedBox(
                                  width: MediaQuery.of(context).size.width - 50,
                                  child: Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      completedOrders[index].isInvoiced == 'Y'
                                          ? InkWell(
                                              onTap: () async {
                                                await Get.to(
                                                  PDFViewerPage(
                                                    title: 'Proforma Invoice',
                                                    bidId:
                                                        completedOrders[index]
                                                            .id,
                                                    podUrl: '',
                                                    retRef: 'completed',
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      Constant.downloadSVG,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      color:
                                                          MyColors.primaryLight,
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      'Proforma',
                                                      style:
                                                          MyText.customText15(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        color: MyColors
                                                            .primaryblue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Constant.downloadSVG,
                                                    width: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        15,
                                                    height: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        15,
                                                    color: MyColors.grey_40,
                                                  ),
                                                  const SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                    'Proforma',
                                                    style: MyText.customText15(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.grey_40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      const Expanded(
                                        child: SizedBox(
                                          width: 2,
                                        ),
                                      ),
                                      completedOrders[index].isInvoiced == 'Y'
                                          ? InkWell(
                                              onTap: () async {
                                                await sendEmailFunctions(
                                                  completedOrders[index].id!,
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  children: [
                                                    SvgPicture.asset(
                                                      Constant.mailSVG,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      color:
                                                          MyColors.primaryblue,
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      'Proforma',
                                                      style:
                                                          MyText.customText15(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        color: MyColors
                                                            .primaryblue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : Container(
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Constant.mailSVG,
                                                    width: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        15,
                                                    height: MediaQuery.of(
                                                          context,
                                                        ).size.width /
                                                        15,
                                                    color: MyColors.grey_40,
                                                  ),
                                                  const SizedBox(
                                                    width: 1,
                                                  ),
                                                  Text(
                                                    'Proforma',
                                                    style: MyText.customText15(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.grey_40,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                      const Expanded(
                                        child: SizedBox(
                                          width: 2,
                                        ),
                                      ),
                                      completedOrders[index].invoiceUploaded !=
                                                  "Y" &&
                                              completedOrders[index]
                                                      .invoiceDoc ==
                                                  null
                                          ? InkWell(
                                              onTap: () {
                                                showFileUploadDialog(
                                                  context,
                                                  completedOrders[index].id,
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      // width: 30,
                                                      child: SvgPicture.asset(
                                                        Constant.uploadSVG,
                                                        width: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            15,
                                                        height: MediaQuery.of(
                                                              context,
                                                            ).size.width /
                                                            15,
                                                        color: MyColors
                                                            .primaryLight,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      'Invoice',
                                                      style:
                                                          MyText.customText15(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        color: MyColors
                                                            .primaryblue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )
                                          : InkWell(
                                              onTap: () async {
                                                Get.to(
                                                  PDFViewerPage(
                                                    title: 'Invoice',
                                                    bidId: '',
                                                    podUrl:
                                                        completedOrders[index]
                                                            .invoiceDoc,
                                                    retRef: 'completed',
                                                  ),
                                                );
                                              },
                                              child: Container(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SvgPicture.asset(
                                                      Constant
                                                          .invoiceDownloadSVG,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      height: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          15,
                                                      color:
                                                          MyColors.primaryblue,
                                                    ),
                                                    const SizedBox(
                                                      width: 1,
                                                    ),
                                                    Text(
                                                      'Invoice',
                                                      style:
                                                          MyText.customText15(
                                                        context,
                                                      )!
                                                              .copyWith(
                                                        color: MyColors
                                                            .primaryblue,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                    ],
                                  ),
                                ),
                          const Expanded(
                            child: SizedBox(
                              width: 2,
                            ),
                          ),
                          completedOrders[index].isInvoiced == "N" &&
                                  completedOrders[index].paymentStatus ==
                                      "Not Paid"
                              ? InkWell(
                                  onTap: () async {
                                    await completedOrderController
                                        .completedBidDetailsAPI(
                                      completedOrders[index].id!,
                                    )
                                        .then((value) {
                                      Get.toNamed('/customerinfo');
                                    });
                                  },
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 6,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Generate",
                                          style: MyText.customText15(
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
                              : Container(),
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
          completedOrdersdataList =
              completedOrderController.completedOrdersDataList.value;

          return completedOrderController.load.value
              ? LoaderWidget('')
              : RefreshIndicator(
                  onRefresh: () async {
                    await completedOrderController.completedOrdersAPI();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                      top: 10,
                    ),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 0),
                            child: Text(
                              "Completed Orders",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * MediaQuery.of(context).textScaleFactor,
                              ),
                            ),
                          ),
                          completedOrdersdataList.length > 0
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  padding: const EdgeInsets.all(0),
                                  itemCount: completedOrdersdataList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return OrderCard(
                                      completedOrdersdataList[index],
                                    );
                                  },
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height / 1.25,
                                  child: Center(
                                    child: Text(
                                      Constant.messages.noCompletedOrders ??
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
                );
        }),
      ),
    );
  }
}
