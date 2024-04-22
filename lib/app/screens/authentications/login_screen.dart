// ignore_for_file: prefer_const_constructors
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/models/loginmodel.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/login_controller.dart';
import 'package:las_warehouse/app/data/controller/profile_controller.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/themes/text_scale_theme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    print('login comes');
    controller.load.value = false;
    super.initState();
  }

  static final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  static final _phoneController = TextEditingController();
  static final _passwordController = TextEditingController();
  final controller = Get.put(LoginController());

  LoginModel? loginData;

  void _trySubmitForm() async {
    FocusScope.of(context).unfocus();
    if (_loginFormKey.currentState!.validate()) {
      controller.load.value = true;
      Map<String, dynamic> bodyParams = {
        "email": _phoneController.text,
        "password": _passwordController.text,
      };

      await controller.loginAPI(bodyParams).then((value) async {
        if (value != null) {
          if (value.result == true) {
            loginData = value;
            final profileController = Get.put(ProfileController());

            Preferences.setString(Preferences.accesstoken, value.message!);

            await profileController.getProfileDataAPI().then((value) async {
              if (value != null) {
                if (value.result == true) {
                  _phoneController.clear();
                  _passwordController.clear();
                  Preferences.setBoolean(Preferences.isLogin, true);
                  // await loadData();

                  if (loginData?.masterResp?.page == 'false' &&
                      loginData?.masterResp?.company?.roleId == 1) {
                    Get.offAndToNamed('/dashboard');
                  } else if (
                      // duration: const Duration(milliseconds: 400),
                      // transition: Transition.rightToLeft)
                      loginData?.masterResp?.page == 'terms-conditions' &&
                          loginData?.masterResp?.company?.roleId == 1) {
                    Get.toNamed('/termsnconditions');
                  } else if (loginData?.masterResp?.page == 'warehouse' &&
                      loginData?.masterResp?.company?.roleId == 1) {
                    Get.offNamed('/warehouses');
                  } else {
                    Get.offNamed('/dashboard');
                  }
                } else {
                  controller.load.value = false;
                  ShowToastDialog.showToast(
                    '${json.encode(value.message).toString()}',
                  );
                }
              }
            });
          } else {
            ShowToastDialog.showToast(
              '${json.encode(value.message).toString()}',
            );
            controller.load.value = false;
          }
        }
      });
    }
  }

  bool ishiddenpassword = true;

  Future<bool> _onWillPop() async {
    bool result = await showDialog(
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          color: Colors.white,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10.0),
                width: double.infinity,
                color: Colors.white,
                child: Text(
                  "Confirm Exit?",
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Text(
                  'Are you sure you want to exit the app? Tap \'Yes\' to exit \'No\' to cancel.',
                  style: TextStyle(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(5.0),
                      backgroundColor: MyColors.primaryblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      "Yes",
                      style: TextStyle(
                        color: Colors.white,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () async {
                      SystemChannels.platform
                          .invokeMethod('SystemNavigator.pop');
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(
                        color: MyColors.primaryblue,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Text(
                      "No",
                      style: TextStyle(
                        color: MyColors.primaryblue,
                        letterSpacing: 1.0,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
    return result;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: MyColors.primarywhite,
        body: Obx(
          () => controller.load.value
              ? LoaderWidget('')
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 35,
                      top: 20,
                      bottom: 20,
                      right: 35,
                    ),
                    child: Form(
                      key: _loginFormKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // SizedBox(
                          //   height: MediaQuery.of(context).size.height / 10,
                          // ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Center(child: Image.asset(Constant.logo)),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 10,
                          ),
                          Text(
                            "Email Address",
                            style: TextStyle(
                              fontSize:
                                  15 * MediaQuery.of(context).textScaleFactor,
                              color: MyColors.grey,
                            ),
                          ),
                          TextFieldThem.buildTextFieldTheme(
                            initialValue: '',
                            keyboardType: TextInputType.emailAddress,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.none,
                            style: TextStyle(),
                            strutStyle: StrutStyle(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: false,
                            showCursor: true,
                            autofocus: false,
                            obscureText: false,
                            autocorrect: false,
                            maxLines: 1,
                            minLines: 1,
                            expands: false,
                            maxLength: null,
                            onChanged: (value) {},
                            onEditingComplete: () {},
                            onFieldSubmitted: (value) {},
                            onSaved: (value) {},
                            inputFormatters: null,
                            enabled: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            controller: _phoneController,
                            decoration: InputDecoration(
                              errorMaxLines: 1,
                              labelText: null,
                              contentPadding: EdgeInsets.all(0),
                              suffixIcon: null,
                              border: UnderlineInputBorder(),
                              hintText: "email@example.com",
                              hintStyle: MyText.customHintText13(context)!
                                  .copyWith(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return '${Constant.messages.emailReq ?? 'Email is required'}';
                              }

                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 20,
                          ),
                          Text(
                            "Password",
                            style: TextStyle(
                              fontSize:
                                  15 * MediaQuery.of(context).textScaleFactor,
                              color: MyColors.grey,
                            ),
                          ),
                          TextFieldThem.buildTextFieldTheme(
                            initialValue: '',
                            keyboardType: TextInputType.visiblePassword,
                            textCapitalization: TextCapitalization.none,
                            textInputAction: TextInputAction.none,
                            style: TextStyle(),
                            strutStyle: StrutStyle(),
                            textDirection: TextDirection.ltr,
                            textAlign: TextAlign.start,
                            textAlignVertical: TextAlignVertical.center,
                            readOnly: false,
                            showCursor: true,
                            autofocus: false,
                            obscureText: ishiddenpassword,
                            autocorrect: false,
                            maxLines: 1,
                            minLines: 1,
                            expands: false,
                            maxLength: null,
                            onChanged: (value) {},
                            onEditingComplete: () {},
                            onFieldSubmitted: (value) {},
                            onSaved: (value) {},
                            inputFormatters: null,
                            enabled: true,
                            autovalidateMode: AutovalidateMode.disabled,
                            controller: _passwordController,
                            decoration: InputDecoration(
                              errorMaxLines: 1,
                              labelText: null,
                              suffixIcon: InkWell(
                                onTap: passwordview,
                                child: Icon(
                                  !ishiddenpassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: !ishiddenpassword
                                      ? MyColors.primaryblue
                                      : MyColors.primaryred,
                                ),
                              ),
                              border: UnderlineInputBorder(),
                              hintText: "*******",
                              hintStyle: MyText.customHintText13(context)!
                                  .copyWith(color: Colors.black),
                            ),
                            validator: (value) {
                              if (value!.isNotEmpty && value.length < 8) {
                                return '';
                              } else if (value.isEmpty) {
                                return '${Constant.messages.passwordReq ?? 'Password is required'}';
                              } else if (value.length < 8) {
                                return '${Constant.messages.passwordLength ?? 'Password must be more than 8 characters'}';
                              }
                              return null;
                            },
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 15,
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.horizontal(),
                                ),
                                backgroundColor: MyColors.primaryblue,
                                minimumSize: const Size.fromHeight(40), // NEW
                              ),
                              onPressed: _trySubmitForm,
                              child: Text(
                                'SUBMIT',
                                style:
                                    MyText.customFormTitle18(context)!.copyWith(
                                  color: MyColors.primarywhite,
                                  fontWeight: FontWeight.normal,
                                  letterSpacing: 0,
                                ),
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height / 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: MyText.customBodytext14(context)!
                                    .copyWith(letterSpacing: 0.0),
                                //  textAlign: TextAlign.center,
                                textScaleFactor:
                                    ScaleSize.textScaleFactor(context),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed('/signup');
                                  // Get.offAll(WarehouseRegisterScreen());
                                },
                                child: Text(
                                  "Register Here.",
                                  style: MyText.customSubtitle16(context)!
                                      .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14 *
                                        MediaQuery.of(context).textScaleFactor,
                                    color: MyColors.darkblue,
                                    //decoration: TextDecoration.underline,
                                  ),
                                  textScaleFactor:
                                      ScaleSize.textScaleFactor(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void passwordview() {
    if (ishiddenpassword == true) {
      ishiddenpassword = false;
      Future.delayed(Duration(milliseconds: 900), () {
        setState(() {
          ishiddenpassword = true;
        });
      });
    } else {
      ishiddenpassword = true;
      Future.delayed(Duration(milliseconds: 900), () {
        setState(() {
          ishiddenpassword = false;
        });
      });
    }
    setState(() {});
  }
}
