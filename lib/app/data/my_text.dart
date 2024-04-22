// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

class MyText {
  static TextStyle? customText10(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 10 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText12(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 12 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText13(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 13 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText14(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 14 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText15(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 15 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText16(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 16 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customText18(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.normal,
      fontSize: 18 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customSubheadline12(BuildContext context) {
    return TextStyle(
      letterSpacing: 0.2,
      color: MyColors.grey,
      fontSize: 12.0 * MediaQuery.of(context).textScaleFactor,
    );
  }

  static TextStyle? customFormTitle18(BuildContext context) {
    return TextStyle(
      fontSize: 18 * MediaQuery.of(context).textScaleFactor,
      fontWeight: FontWeight.bold,
      letterSpacing: 0.3,
    );
  }

  static TextStyle? customLabelText15(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_5,
      fontWeight: FontWeight.w500,
      fontSize: 16 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customHintText13(BuildContext context) {
    return TextStyle(
      color: MyColors.grey_70,
      fontWeight: FontWeight.w400,
      fontSize: 15 * MediaQuery.of(context).textScaleFactor,
      letterSpacing: 0.5,
    );
  }

  static TextStyle? customTitle18(BuildContext context) {
    return TextStyle(
      fontSize: 18 * MediaQuery.of(context).textScaleFactor,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle? customSubtitle16(BuildContext context) {
    return TextStyle(
      fontSize: 16 * MediaQuery.of(context).textScaleFactor,
      color: MyColors.primaryblue,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle? customBodytext14(BuildContext context) {
    return TextStyle(
      fontSize: 14 * MediaQuery.of(context).textScaleFactor,
      color: MyColors.grey_80,
      letterSpacing: 1.0,
    );
  }

  static TextStyle? display4(BuildContext context) {
    return Theme.of(context).textTheme.headline1;
  }

  static TextStyle? display3(BuildContext context) {
    return Theme.of(context).textTheme.headline2;
  }

  static TextStyle? display2(BuildContext context) {
    return Theme.of(context).textTheme.headline3;
  }

  static TextStyle? display1(BuildContext context) {
    return Theme.of(context).textTheme.headline4;
  }

  static TextStyle? headline(BuildContext context) {
    return Theme.of(context).textTheme.headline5;
  }

  static TextStyle? title(BuildContext context) {
    return Theme.of(context).textTheme.headline6;
  }

  static TextStyle medium(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1!.copyWith(
          fontSize: 18 * MediaQuery.of(context).textScaleFactor,
        );
  }

  static TextStyle? subhead(BuildContext context) {
    return Theme.of(context).textTheme.subtitle1;
  }

  static TextStyle? body2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText1;
  }

  static TextStyle? body1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2;
  }

  static TextStyle? caption(BuildContext context) {
    return Theme.of(context).textTheme.caption;
  }

  static TextStyle? button(BuildContext context) {
    return Theme.of(context).textTheme.button;
  }

  static TextStyle? subtitle(BuildContext context) {
    return Theme.of(context).textTheme.subtitle2;
  }

  static TextStyle? overline(BuildContext context) {
    return Theme.of(context).textTheme.overline;
  }
}
