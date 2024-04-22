import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/models/message_model.dart';
import 'package:las_warehouse/app/services/api.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';

class MessageController extends GetxController {
  RxString version1 = ''.obs;

  RxBool load1 = true.obs;

  Rx<MessageModel> messages = MessageModel().obs;

  @override
  void onInit() {
    commonMessageAPI();
    super.onInit();
  }

  Future<MessageModel?> commonMessageAPI() async {
    try {
      load1.value = true;
      final response = await http.get(
        Uri.parse(API.messages),
      );

      Map<String, dynamic> responseBody = json.decode(response.body);
      messages.value = MessageModel.fromJson(responseBody);
      version1.value = messages.value.aadharLength!;
      load1.value = false;

      return messages.value;
    } catch (error) {
      load1.value = false;
      ApiExceptionService().handleSocketException(error);
    }
    update();
    return null;
  }
}
