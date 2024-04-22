// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/user_controller.dart';
import 'package:las_warehouse/app/data/controller/user_role_controller.dart';
import 'package:las_warehouse/app/data/models/user_role_master_model.dart';
import 'package:las_warehouse/app/data/models/user_role_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/services/validations.dart';
import 'package:las_warehouse/app/themes/content_header.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddUserMaster extends StatefulWidget {
  const AddUserMaster({super.key});

  @override
  State<AddUserMaster> createState() => _AddUserMasterState();
}

class _AddUserMasterState extends State<AddUserMaster> {
  static final GlobalKey<FormState> _addUserFormKey = GlobalKey<FormState>();

  TextEditingController _usernameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  // TextEditingController _passwordController = TextEditingController();

  final userController = Get.put(UserController());
  final userRoleController = Get.put(UserRoleController());

  List<UserRoleMaster> privilegeMenus = [];
  List<UserRoleMaster> selectedPrivilegeMenus = [];
  List<UserRole> userRolesList = [];
  UserRole? selectedUserRole;

  // bool hidePassword2 = false;

  @override
  void initState() {
    userRolesList = userRoleController.interUsersRoleList.value;
    privilegeMenus = userRoleController.userRoleMenusList.value;
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  void _trySubmitForm() async {
    FocusScope.of(context).unfocus();
    if (_addUserFormKey.currentState!.validate()) {
      await userController
          .addUserAPI(
        '',
        _usernameController.text,
        _phoneController.text,
        _emailController.text,
        // _passwordController.text,
        selectedUserRole!.id!,
      )
          .then((value) async {
        if (value != null) {
          if (value.result == true) {
            ShowToastDialog.showToast('${value.message}');

            Get.offAndToNamed('/users');
          } else {
            ShowToastDialog.showToast(
              '${json.encode(value.message).toString()}',
            );
          }
        }
      });
    }
    // }
  }

  @override
  Widget build(BuildContext context) {
    // privilegeMenus = messageController.messages.value.wbsVendorMenus!;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: DrawerMenu(),
        body: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, bottom: 10, right: 10, left: 10),
            child: Form(
              key: _addUserFormKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1, color: Colors.grey),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            top: 20,
                            bottom: 20,
                            right: 20,
                            left: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Add User",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18 *
                                      MediaQuery.of(context).textScaleFactor,
                                ),
                              ),
                              SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "User’s Name",
                                colorvalue: MyColors.grey,
                                mustShow: true,
                              ),
                              SizedBox(height: 10),
                              TextFieldThem.boxBuildTextField(
                                // readOnlyStatus: false,
                                suffixWidget: null,
                                autoFocus: false,
                                hintText: 'User’s Name'.tr,
                                labelText: ''.tr,
                                controller: _usernameController,
                                textInputType: TextInputType.text,
                                contentPadding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                enabled: true,
                                obscure: false,
                                validators: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'required'.tr;
                                  } else if (Validations()
                                      .hasOnlySpace(value)) {
                                    return "This field doesn't allow only spaces";
                                  } else if (Validations()
                                      .hasOnlyNumber(value)) {
                                    return "This field doesn't allow only numbers";
                                  } else if (!Validations().nameField(value)) {
                                    return 'Some special characters are not allowed.'
                                        .tr;
                                  } else if (value.length > 256) {
                                    return 'length should be lessthan 256 characters';
                                  }
                                  return null;
                                },
                                hintStyle: TextStyle(color: MyColors.grey_100_),
                              ),
                              SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "Mobile Number",
                                colorvalue: MyColors.grey,
                                mustShow: true,
                              ),
                              SizedBox(height: 10),
                              TextFieldThem.boxBuildTextField(
                                // readOnlyStatus: false,
                                suffixWidget: null,
                                autoFocus: false,
                                hintText: 'Mobile Number'.tr,
                                labelText: ''.tr,
                                controller: _phoneController,
                                textInputType: TextInputType.number,
                                contentPadding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                enabled: true,
                                obscure: false,
                                validators: (value) {
                                  if (value == null || value.trim().isEmpty) {
                                    return Constant.messages.phoneReq ??
                                        'required'.tr;
                                  }
                                  if (value.length != 10) {
                                    return Constant.messages.phoneLength ??
                                        'A valid phone number should be 10 digits'
                                            .tr;
                                  }
                                  if (!RegExp('^[1-9]{1}[0-9]{9}')
                                      .hasMatch(value)) {
                                    return 'Enter a valid Postal code'.tr;
                                  }
                                  return null;
                                },
                                inputFormatter: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                  LengthLimitingTextInputFormatter(10),
                                ],
                                hintStyle: TextStyle(color: MyColors.grey_100_),
                              ),
                              SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "Email",
                                colorvalue: MyColors.grey,
                                mustShow: true,
                              ),
                              SizedBox(height: 10),
                              TextFieldThem.boxBuildTextField(
                                // readOnlyStatus: false,
                                suffixWidget: null,
                                autoFocus: false,
                                hintText: 'Email'.tr,
                                labelText: ''.tr,
                                controller: _emailController,
                                textInputType: TextInputType.text,
                                contentPadding: EdgeInsets.only(
                                  left: 15.0,
                                  right: 8.0,
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                enabled: true,
                                obscure: false,
                                validators: (String? value) {
                                  if (value!.isEmpty) {
                                    return Constant.messages.emailReq ??
                                        'required'.tr;
                                  } else if (!RegExp(
                                    r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
                                  ).hasMatch(value)) {
                                    return Constant.messages.validEmail ??
                                        'Invalid Email'.tr;
                                  } else {
                                    return null;
                                  }
                                },
                                // inputFormatters: [],
                                hintStyle: TextStyle(color: MyColors.grey_100_),
                              ),
                              SizedBox(height: 10),
                              // ContentHeaderWidget(
                              //     title: "Password",
                              //     colorvalue: MyColors.grey,
                              //     mustShow: true),
                              // SizedBox(height: 10.0),
                              // TextFieldThem.boxBuildTextField(
                              //   // readOnlyStatus: false,
                              //   hintText: 'Password',
                              //   autoFocus: false,
                              //   // title: '********'.tr,
                              //   labelText: ''.tr,
                              //   controller: _passwordController,
                              //   textInputType: TextInputType.text,
                              //   contentPadding: EdgeInsets.zero,
                              //   enabled: true,
                              //   obscure: !hidePassword2,
                              //   maxLine: 1,
                              //   hintStyle: TextStyle(color: MyColors.grey_100_),
                              //   validators: (String? value) {
                              //     if (value!.isEmpty) {
                              //       return Constant.messages.passwordReq ??
                              //           'required'.tr;
                              //     }
                              //     if (!RegExp(
                              //             r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)")
                              //         .hasMatch(value)) {
                              //       return '${Constant.messages.passwordUpperCase ?? 'Password should contain at least one uppercase letter'}\n${Constant.messages.passwordLowerCase ?? 'Password should contain at least one lowercase letter'}\n${Constant.messages.passwordDigit ?? 'Password should contain at least one digit'}\n${Constant.messages.passwordSpecialChar ?? 'Password should contain at least one special character (e.g., @\$!%*?&)'}\n${Constant.messages.passwordLength ?? 'Password length morethan 8 characters'}'
                              //           .tr;
                              //     }
                              //     if (value.length < 8) {
                              //       return Constant.messages.passwordLength ??
                              //           'Password length morethan 8 characters'
                              //               .tr;
                              //     }
                              //     return null;
                              //   },
                              //   suffixWidget: IconButton(
                              //       icon: !hidePassword2
                              //           ? Icon(
                              //               Icons.visibility_off,
                              //               color: MyColors.primaryred,
                              //             )
                              //           : Icon(
                              //               Icons.visibility,
                              //               color: MyColors.primaryblue,
                              //             ),
                              //       onPressed: () {
                              //         setState(() {
                              //           hidePassword2 = !hidePassword2;
                              //         });
                              //       }),
                              // ),
                              // SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "User Role",
                                mustShow: true,
                                colorvalue: MyColors.grey,
                              ),
                              const SizedBox(height: 10),
                              ButtonTheme(
                                alignedDropdown: true,
                                child: DropdownButtonFormField(
                                  // padding: EdgeInsets.zero,
                                  // borderRadius: const BorderRadius.all(
                                  //     Radius.circular(5)),
                                  dropdownColor: MyColors.grey_3,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: EdgeInsets.only(
                                      left: 0.0,
                                      right: 8.0,
                                      top: 8.0,
                                      bottom: 8.0,
                                    ),
                                  ),
                                  menuMaxHeight:
                                      MediaQuery.of(context).size.height * 0.50,
                                  hint: Text(
                                    "Select User Role",
                                    style: TextStyle(
                                      fontSize: 15 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      color: MyColors.grey_100_,
                                    ),
                                  ),
                                  validator: ((value) {
                                    if (value == null) {
                                      return 'required';
                                    }
                                    return null;
                                  }),
                                  // underline: const SizedBox(),
                                  isDense: true,
                                  isExpanded: true,

                                  value: selectedUserRole,
                                  // items: dropdownItems,
                                  items: userRolesList
                                      .map<DropdownMenuItem<UserRole>>(
                                          (UserRole value) {
                                    return DropdownMenuItem<UserRole>(
                                      value: value,
                                      child: Text(value.userRole!),
                                    );
                                  }).toList(),
                                  onChanged: (UserRole? newValue) {
                                    setState(() {
                                      selectedUserRole = newValue!;
                                    });

                                    selectedPrivilegeMenus = [];
                                    for (int j = 0;
                                        j < privilegeMenus.length;
                                        j++) {
                                      for (int ij = 0;
                                          ij <
                                              selectedUserRole!
                                                  .menus!.hasRead!.length;
                                          ij++) {
                                        if (privilegeMenus[j].menuId ==
                                            selectedUserRole!
                                                .menus!.hasRead![ij]) {
                                          selectedPrivilegeMenus
                                              .add(privilegeMenus[j]);
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "Menu Privileges",
                                colorvalue: MyColors.grey,
                                mustShow: true,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                margin: EdgeInsets.all(0),
                                elevation: 0,
                                child: Container(
                                  // height: 40,
                                  alignment: Alignment.centerLeft,
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    children: <Widget>[
                                      MultiSelectDialogField<UserRoleMaster>(
                                        dialogHeight: 220,
                                        buttonIcon: Icon(
                                          Icons.arrow_drop_down,
                                          color: MyColors.grey_80,
                                          size: 25,
                                        ),
                                        // initialChildSize: 0.4,
                                        initialValue: selectedPrivilegeMenus,

                                        // autovalidateMode: AutovalidateMode.always,
                                        listType: MultiSelectListType.LIST,
                                        searchable: true,
                                        buttonText:
                                            Text("Select Privilege Menu(s)"),
                                        title: Text("Privilege's"),
                                        items: privilegeMenus
                                            .map(
                                              (e) =>
                                                  MultiSelectItem(e, e.menu!),
                                            )
                                            .toList(),
                                        onConfirm:
                                            (List<UserRoleMaster> values) {
                                          setState(() {
                                            selectedPrivilegeMenus = values;
                                          });
                                        },
                                        chipDisplay: MultiSelectChipDisplay(
                                          chipColor: MyColors.primaryblue,
                                          textStyle:
                                              TextStyle(color: Colors.white),
                                          onTap: (value) {
                                            setState(() {
                                              selectedPrivilegeMenus
                                                  .remove(value);
                                            });
                                          },
                                        ),
                                      ),
                                      selectedPrivilegeMenus == null ||
                                              selectedPrivilegeMenus.isEmpty
                                          ? Container(
                                              padding: EdgeInsets.all(10),
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Nothing selected",
                                                style: TextStyle(
                                                  color: MyColors.grey_100_,
                                                ),
                                              ),
                                            )
                                          : Container(),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: MyColors.primaryblue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                      ),
                                    ),
                                    onPressed: () async {
                                      _trySubmitForm();
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Text(
                                        "SAVE",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(letterSpacing: 0.5),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      side: BorderSide(
                                        width: 1,
                                        color: MyColors.primaryblue,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.all(Radius.zero),
                                      ),
                                    ),
                                    onPressed: () async {
                                      Get.back();
                                    },
                                    child: SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width / 5,
                                      child: Text(
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
                            ],
                          ),
                        ),
                      ),
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
}
