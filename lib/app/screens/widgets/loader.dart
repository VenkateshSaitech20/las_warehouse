import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

// ignore: must_be_immutable
class LoaderWidget extends StatelessWidget {
  String loaderString;
  LoaderWidget(this.loaderString, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          height: 100,
          width: 300,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 300,
                  child: Text(
                    loaderString,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: MyColors.grey_100_,
                      fontSize: 14 * MediaQuery.of(context).textScaleFactor,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const CircularProgressIndicator(
                  backgroundColor: Colors.white,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(MyColors.primaryblue),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
