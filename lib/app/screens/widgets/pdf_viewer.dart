// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors_in_immutables

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/workorder_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/work_orders/work_orders.dart';
import 'package:las_warehouse/app/screens/completed_orders/completed.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFViewerPage extends StatefulWidget {
  final String? title;
  final String? bidId;
  final String? podUrl;
  final String? retRef;

  PDFViewerPage({super.key, this.title, this.bidId, this.podUrl, this.retRef});

  @override
  _PDFViewerPageState createState() => _PDFViewerPageState();
}

class _PDFViewerPageState extends State<PDFViewerPage> {
  static String url = '';
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  final workOrderController = Get.put(WorkOrderController());
  File file = File('');
  bool load = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    setState(() {
      url = '';
      load = true;
    });
    if (widget.title == "Proforma Invoice") {
      Get.put(WorkOrderController().downloadInvoiceAPI(widget.bidId!))
          .then((value) {
        if (value != null) {
          if (value.result == true) {
            setState(() {
              url = value.message!;
            });
          } else {
            ShowToastDialog.showToast(value.message!);
            Get.offAll(const Completedpage());
          }
        }
      });
    } else if (widget.title == "Work Order") {
      Get.put(WorkOrderController().downloadWorkorderAPI(widget.bidId!))
          .then((value) {
        if (value != null) {
          if (value.result == true) {
            setState(() {
              url = value.message!;
            });
          } else {
            ShowToastDialog.showToast(value.message!);
            Get.offAll(const WorkOrdersPage());
          }
        }
      });
    } else if (widget.title == "Invoice") {
      if (widget.podUrl != "") {
        setState(() {
          url = widget.podUrl!;
        });
      }
    }
    print(url);
    setState(() {
      load = false;
    });
  }

  _willPop() {
    if (widget.retRef == "completed") {
      // Get.to(const Completedpage());
      Get.toNamed('completedorders');
    } else if (widget.retRef == "workorder") {
      Get.toNamed('workorders');
      // Get.to(const WorkOrdersPage());
    } else if (widget.retRef == "reportDetail") {
      Get.back();
    } else {
      Get.toNamed('/dashboard');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.primaryblue,
          title: Text(
            '$widget.title',
            style: TextStyle(
              fontSize: 18 * MediaQuery.of(context).textScaleFactor,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: _willPop,
          ),
          actions: <Widget>[
            url != ''
                ? IconButton(
                    icon: const Icon(Icons.download_for_offline_sharp),
                    onPressed: url != ''
                        ? () async {
                            if (widget.title == "Work Order") {
                              FileDownloader.downloadFile(
                                notificationType: NotificationType.all,
                                url: url,
                                name: "Work Order",
                                onDownloadCompleted: (path) {
                                  file = File(path);
                                },
                              );
                              if (file != null) {
                                ShowToastDialog.showToast(
                                  '${url.split('/').last} has downloaded successfully.',
                                );
                              }
                            } else if (widget.title == "Proforma Invoice") {
                              FileDownloader.downloadFile(
                                notificationType: NotificationType.all,
                                url: url,
                                name: "Invoice",
                                onDownloadCompleted: (path) {
                                  file = File(path);
                                },
                              );
                              if (file != null) {
                                ShowToastDialog.showToast(
                                  '${url.split('/').last} has downloaded successfully.',
                                );
                              }
                            } else if (widget.title == "Invoice") {
                              FileDownloader.downloadFile(
                                notificationType: NotificationType.all,
                                url: url,
                                name: "Invoice",
                                onDownloadCompleted: (path) {
                                  file = File(path);
                                },
                              );
                              if (file != null) {
                                ShowToastDialog.showToast(
                                  '${url.split('/').last} has downloaded successfully.',
                                );
                              }
                            }
                          }
                        : null,
                  )
                : Container(),
          ],
        ),
        body: (load || url.isEmpty)
            ? const Center(child: CircularProgressIndicator())
            : SfPdfViewer.network(
                key: _pdfViewerKey,
                url,
              ),
      ),
    );
  }
}
