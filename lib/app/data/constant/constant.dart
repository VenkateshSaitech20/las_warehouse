// ignore_for_file: deprecated_member_use, non_constant_identifier_names

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/message_controller.dart';
import 'package:las_warehouse/app/data/models/message_model.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/themes/constant_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

class Constant {
  static MessageModel messages = Get.put(MessageController()).messages.value;
  static User userData = User();

  static String kGoogleApiKey = "AIzaSyBJXujwVr7H8PaWF9JYozqle_gr_dtal6U";
  static String distanceUnit = "KM";

  static String appVersion = messages.version!;
  static int decimal = 2;
  static int taxValue = 0;
  static String currency = "\$";
  static String taxType = 'Percentage';
  static String taxName = 'Tax';
  static String contactUsEmail = "", contactUsAddress = "", contactUsPhone = "";
  static String rideOtp = "yes";
  static String logo = "assets/logo_bos_b.png";
  static String logo2 = "assets/logo_bos_t.png";
  static String demo = "assets/test.jpg";
  static String logo3 = "assets/test1.jpg";
  static String lasTitle = "assets/logo-blue.png";
  static String deleteSVG = 'assets/icons/delete.svg';
  static String editSVG = 'assets/icons/edit.svg';
  static String uploadSVG = 'assets/icons/upload.svg';
  static String infoSVG = 'assets/icons/info.svg';
  static String cancelSVG = 'assets/icons/cancel.svg';
  static String downloadSVG = 'assets/icons/download.svg';
  static String invoiceDownloadSVG = 'assets/icons/invoice_download.svg';
  static String calenderSVG = 'assets/icons/calender.svg';
  static String negoSVG = 'assets/icons/negotiation.svg';
  static String warehouseSVG = 'assets/icons/warehouse.svg';
  static String activebidSVG = 'assets/icons/active-bid.svg';
  static String checkoutSVG = 'assets/icons/checkout.svg';
  static String addFrameSVG = 'assets/icons/add-frame-white.svg';
  static String mailSVG = 'assets/icons/mail.svg';

  static String getUuid() {
    var uuid = const Uuid();
    return uuid.v1();
  }

  static Widget loader() {
    return Center(
      child: CircularProgressIndicator(color: ConstantColors.primary),
    );
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  static Future<void> launchMapURl(
    String? latitude,
    String? longLatitude,
  ) async {
    String appleUrl =
        'https://maps.apple.com/?saddr=&daddr=$latitude,$longLatitude&directionsmode=driving';
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longLatitude';

    if (Platform.isIOS) {
      if (await canLaunch(appleUrl)) {
        await launch(appleUrl);
      } else {
        if (await canLaunch(googleUrl)) {
          await launch(googleUrl);
        } else {
          throw 'Could not open the map.';
        }
      }
    }
  }
}

class Url {
  String mime;

  String url;

  Url({this.mime = '', this.url = ''});

  factory Url.fromJson(Map<dynamic, dynamic> parsedJson) {
    return Url(mime: parsedJson['mime'] ?? '', url: parsedJson['url'] ?? '');
  }

  Map<String, dynamic> toJson() {
    return {'mime': mime, 'url': url};
  }
}
