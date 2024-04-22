import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/profile_update_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/themes/content_header.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formchnkey = GlobalKey<FormState>();
  final authController = Get.put(ProfileUpdateController());

  TextEditingController _currentContr = TextEditingController();
  TextEditingController _nPassContr = TextEditingController();
  TextEditingController _cPassContr = TextEditingController();

  bool hidePassword1 = true;
  bool hidePassword2 = true;
  bool hidePassword3 = true;

  _willPop() {
    Get.back();
  }

  @override
  void initState() {
    super.initState();
  }

  void _trySubmitForm() async {
    FocusScope.of(context).unfocus();
    if (_formchnkey.currentState!.validate()) {
      authController.load.value = true;

      await authController
          .changePasswordAPI(
        _currentContr.text,
        _nPassContr.text,
        _cPassContr.text,
      )
          .then((value) async {
        if (value != null) {
          if (value.result == true) {
            await Preferences.remove('userdata');
            await Preferences.setBoolean(Preferences.isLogin, false);
            await Preferences.setString(Preferences.accesstoken, 'access');
            authController.load.value = false;
            Get.offAndToNamed('/auth');
          } else {
            authController.load.value = false;
            ShowToastDialog.showToast(
              '${json.encode(value.message).toString()}',
            );
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: MyColors.grey_1,
        key: _scaffoldKey,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(10.0),
            child: Card(
              child: Center(
                child: Form(
                  key: _formchnkey,
                  // autovalidateMode: AutovalidateMode.always,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.only(top: 10, left: 0),
                          child: const Text(
                            "Change Password",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(height: 35.0),
                        ContentHeaderWidget(
                          title: "Current Password",
                          colorvalue: MyColors.grey,
                          mustShow: true,
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldThem.boxBuildTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintText: 'Current Password',
                          autoFocus: false,
                          labelText: ''.tr,
                          controller: _currentContr,
                          textInputType: TextInputType.text,
                          contentPadding: EdgeInsets.zero,
                          enabled: true,
                          obscure: hidePassword1,
                          maxLine: 1,
                          hintStyle: const TextStyle(color: MyColors.grey_100_),
                          validators: (String? value) {
                            if (value!.isNotEmpty && value.length > 8) {
                              return null;
                            } else if (value.isEmpty) {
                              return Constant.messages.passwordReq ??
                                  'required'.tr;
                            } else if (value.length < 8) {
                              return Constant.messages.passwordLength ??
                                  'Password length morethan 8 characters'.tr;
                            }
                            return null;
                          },
                          suffixWidget: IconButton(
                            icon: hidePassword1
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: MyColors.primaryred,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: MyColors.primaryblue,
                                  ),
                            onPressed: () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                                Future.delayed(
                                    const Duration(milliseconds: 900), () {
                                  setState(() {
                                    hidePassword1 = !hidePassword1;
                                  });
                                });
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ContentHeaderWidget(
                          title: "New Password",
                          colorvalue: MyColors.grey,
                          mustShow: true,
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldThem.boxBuildTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintText: 'New Password',
                          autoFocus: false,
                          labelText: ''.tr,
                          controller: _nPassContr,
                          textInputType: TextInputType.text,
                          contentPadding: EdgeInsets.zero,
                          enabled: true,
                          obscure: hidePassword2,
                          maxLine: 1,
                          hintStyle: const TextStyle(color: MyColors.grey_100_),
                          validators: (String? value) {
                            if (value!.isEmpty) {
                              return '${Constant.messages.passwordReq ?? 'Password is required'}'
                                  .tr;
                            } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[@$!%*?&]).{8,}$',
                            ).hasMatch(value)) {
                              return '${Constant.messages.passwordLength ?? 'Length must be atleast 8'}\n${Constant.messages.passwordUpperCase ?? 'Atleast one Uppercase letter is required'}\n${Constant.messages.passwordLowerCase ?? 'Atleast one Lowercase letter is required'}\n${Constant.messages.passwordDigit ?? 'Atleast one digit is required'}\n${Constant.messages.passwordSpecialChar ?? 'Atleast one Special Character(@\$!%*?&) is required'}'
                                  .tr;
                            } else {
                              return null;
                            }
                          },
                          suffixWidget: IconButton(
                            icon: hidePassword2
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: MyColors.primaryred,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: MyColors.primaryblue,
                                  ),
                            onPressed: () {
                              setState(() {
                                hidePassword2 = !hidePassword2;
                                Future.delayed(
                                    const Duration(milliseconds: 900), () {
                                  setState(() {
                                    hidePassword2 = !hidePassword2;
                                  });
                                });
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 20.0),
                        ContentHeaderWidget(
                          title: "Confirm Password",
                          colorvalue: MyColors.grey,
                          mustShow: true,
                        ),
                        const SizedBox(height: 10.0),
                        TextFieldThem.boxBuildTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          hintText: 'Confrim Password',
                          autoFocus: false,
                          labelText: ''.tr,
                          controller: _cPassContr,
                          textInputType: TextInputType.text,
                          contentPadding: EdgeInsets.zero,
                          enabled: true,
                          obscure: hidePassword3,
                          maxLine: 1,
                          hintStyle: const TextStyle(color: MyColors.grey_100_),
                          validators: (String? value) {
                            if (value!.isEmpty) {
                              return '${Constant.messages.passwordReq ?? 'Confirm Password is required'}'
                                  .tr;
                            } else if (_cPassContr.text != _nPassContr.text) {
                              return '${Constant.messages.pwdNotMatch ?? 'Confirm password does not match'}';
                            } else {
                              return null;
                            }
                          },
                          suffixWidget: IconButton(
                            icon: hidePassword3
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: MyColors.primaryred,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: MyColors.primaryblue,
                                  ),
                            onPressed: () {
                              setState(() {
                                hidePassword3 = !hidePassword3;
                                Future.delayed(
                                    const Duration(milliseconds: 900), () {
                                  setState(() {
                                    hidePassword3 = !hidePassword3;
                                  });
                                });
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 100.0),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: MyColors.primaryblue,
                                  // minimumSize:
                                  //     const Size.fromHeight(40), // NEW
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                ),
                                onPressed: _trySubmitForm,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    'SAVE',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 18 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      letterSpacing: 1.0,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  side: const BorderSide(
                                    width: 1,
                                    color: MyColors.primaryblue,
                                  ),
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.zero),
                                  ),
                                ),
                                onPressed: () {
                                  Get.back();
                                },
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: const Text(
                                    "CANCEL",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: MyColors.primaryblue,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
