// ignore_for_file: deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'dart:async';
import 'package:url_launcher/url_launcher.dart';

class CommonFilePicker {
  String fname = "nothing";

  static Future<void> launchInBrowser1(String url) async {
    if (await launch(url)) {
    } else {
      throw 'Could not launch this url';
    }
  }

  Future<FilePickerResult?> pickAFile(
    FileType fileType,
    bool allowMultiple,
    List<String> allowableExtn,
  ) async {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: fileType,
      allowMultiple: allowMultiple,
      allowedExtensions: allowableExtn,
    );

    if (result != null) {
      print(result.files.first.size);
      if (result.files.first.size > 2097152) {
        ShowToastDialog.showError("File too large, Limit is below 2MB");
        return null;
      }
      return result;
    }
    return null;
  }
}
