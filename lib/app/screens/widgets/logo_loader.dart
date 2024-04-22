import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InititalLoaderWidget extends StatelessWidget {
  const InititalLoaderWidget({super.key});

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
          height: MediaQuery.of(context).size.width / 3,
          // width: 300,
          color: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: MediaQuery.of(context).size.width / 3.5,
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),
                // SizedBox(
                //   height: 10,
                // ),
                // CircularProgressIndicator(
                //   backgroundColor: Colors.white,
                //   valueColor:
                //       new AlwaysStoppedAnimation<Color>(MyColors.primaryblue),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
