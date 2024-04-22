// ignore_for_file: use_key_in_widget_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';

class ContentHeaderWidget extends StatelessWidget {
  String? title;
  bool? mustShow;
  Color? colorvalue;
  bool? showImageInfo;
  bool? imageOnly;

  static int i = 0;
  ContentHeaderWidget({
    this.title,
    this.mustShow,
    this.colorvalue,
    this.showImageInfo,
    this.imageOnly,
  });
  void fn() {}

  @override
  Widget build(BuildContext context) {
    showFileDialog() {
      return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: imageOnly == true
                ? const Text('Only JPG / PNG')
                : const Text('Only JPG / PNG or Pdf'),
            content: const Text('(2MB) files are allowed'),
            actions: <Widget>[
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return SizedBox(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "$title",
            style: TextStyle(
              fontSize: 15 * MediaQuery.of(context).textScaleFactor,
              color: colorvalue,
            ),
          ),
          mustShow!
              ? Text(
                  "*",
                  style: TextStyle(
                    fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                    color: Colors.red,
                  ),
                )
              : Container(),
          showImageInfo == true
              ? InkWell(
                  onTap: () {
                    showFileDialog();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 5,
                      top: 5,
                      right: 5,
                      bottom: 5,
                    ),
                    child: SvgPicture.asset(
                      Constant.infoSVG,
                      width: MediaQuery.of(context).size.width / 25,
                      height: MediaQuery.of(context).size.width / 25,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }
}
