import 'package:flutter/material.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

enum alertDialogAction { cancel, save }

class Dialogs {
  static Future alertDialog(
    BuildContext context,
    String title,
    String body,
    String cancel,
    String save,
  ) {
    Future action = showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          actionsPadding: const EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          content: Text(
            body,
            style: TextStyle(
              color: MyColors.grey_100_,
              fontSize: 16 * MediaQuery.of(context).textScaleFactor,
              letterSpacing: 0.5,
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColors.primaryblue,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(),
                ),
              ),
              child: Text(
                "$save",
                style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 0.0,
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
              onPressed: () async {
                Navigator.of(context).pop(alertDialogAction.save);
              },
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(5.0),
                backgroundColor: MyColors.primarywhite,
                side: const BorderSide(width: 2, color: MyColors.primaryblue),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.horizontal(),
                ),
              ),
              child: Text(
                "$cancel",
                style: TextStyle(
                  color: MyColors.primaryblue,
                  letterSpacing: 0.0,
                  fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                ),
              ),
              onPressed: () async {
                Navigator.pop(context, alertDialogAction.cancel);
              },
            ),
          ],
        );
      },
    );
    return action;
  }
}
