// ignore_for_file: prefer_const_constructors, invalid_use_of_protected_member

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/controller/user_role_controller.dart';
import 'package:las_warehouse/app/data/models/user_role_master_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/services/validations.dart';
import 'package:las_warehouse/app/themes/content_header.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class AddUserRoleMaster extends StatefulWidget {
  const AddUserRoleMaster({super.key});

  @override
  State<AddUserRoleMaster> createState() => _AddUserRoleMasterState();
}

class _AddUserRoleMasterState extends State<AddUserRoleMaster> {
  static final GlobalKey<FormState> _addUserRoleFormKey =
      GlobalKey<FormState>();

  TextEditingController _userRoleController = TextEditingController();

  final userRoleController = Get.put(UserRoleController());
  List<String> menuList = [];
  List<UserRoleMaster> privilegeMenus = [];
  List<UserRoleMaster> selectedPrivilegeMenus = [];

  List<String> privilegeMenusIdList = [];

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  void _trySubmitForm() async {
    FocusScope.of(context).unfocus();
    if (_addUserRoleFormKey.currentState!.validate()) {
      if (selectedPrivilegeMenus.isNotEmpty) {
        privilegeMenusIdList = [];
        for (int j = 0; j < selectedPrivilegeMenus.length; j++) {
          privilegeMenusIdList
              .add(selectedPrivilegeMenus[j].menuId!.toString());
        }
        print(privilegeMenusIdList);
        Map<String, dynamic> mapDataa = {"hasRead": privilegeMenusIdList};
        String menuStringJson = json.encode(mapDataa);
        print(menuStringJson);
        await userRoleController
            .addUserRoleAPI('', _userRoleController.text, menuStringJson)
            .then((value) async {
          if (value != null) {
            if (value.result == true) {
              ShowToastDialog.showToast('${value.message}');
              Get.toNamed('/userroles');
            } else {
              ShowToastDialog.showToast(
                '${json.encode(value.message).toString()}',
              );
            }
          }
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    privilegeMenus = userRoleController.userRoleMenusList.value;
    print('privilegeMenus');
    print(privilegeMenus);
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
              key: _addUserRoleFormKey,
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
                                "Add User Role",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(height: 10),
                              ContentHeaderWidget(
                                title: "User Role",
                                colorvalue: MyColors.grey,
                                mustShow: true,
                              ),
                              SizedBox(height: 10),
                              TextFieldThem.boxBuildTextField(
                                // readOnlyStatus: false,
                                suffixWidget: null,
                                autoFocus: false,
                                hintText: 'User role'.tr,
                                labelText: ''.tr,
                                controller: _userRoleController,
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
                                hintStyle:
                                    MyText.customText15(context)!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 10),
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
                                  child: FormField<bool>(
                                    builder: (state) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          MultiSelectDialogField<
                                              UserRoleMaster>(
                                            dialogHeight: 220,
                                            buttonIcon: Icon(
                                              Icons.arrow_drop_down,
                                              color: MyColors.grey_80,
                                              size: 25,
                                            ),
                                            // initialChildSize: 0.4,
                                            initialValue:
                                                selectedPrivilegeMenus,

                                            // autovalidateMode: AutovalidateMode.always,
                                            listType: MultiSelectListType.LIST,
                                            searchable: true,
                                            buttonText: Text("Select Role(s)"),
                                            title: Text("Role's"),
                                            items: privilegeMenus
                                                .map(
                                                  (e) => MultiSelectItem(
                                                    e,
                                                    e.menu!,
                                                  ),
                                                )
                                                .toList(),
                                            onConfirm: (
                                              List<UserRoleMaster> values,
                                            ) {
                                              setState(() {
                                                selectedPrivilegeMenus = values;
                                              });
                                            },
                                            chipDisplay: MultiSelectChipDisplay(
                                              chipColor: MyColors.primaryblue,
                                              textStyle: TextStyle(
                                                color: Colors.white,
                                              ),
                                              onTap: (value) {
                                                setState(() {
                                                  selectedPrivilegeMenus
                                                      .remove(value);
                                                });
                                              },
                                            ),
                                          ),
                                          // selectedPrivilegeMenus == null ||
                                          selectedPrivilegeMenus.isEmpty
                                              ? Container(
                                                  padding: EdgeInsets.all(10),
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    "Nothing selected",
                                                    style: TextStyle(
                                                      color: MyColors.grey_100_,
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          state.errorText == null
                                              ? Container()
                                              : Padding(
                                                  padding: EdgeInsets.only(
                                                    left: 2,
                                                    top: 5.0,
                                                  ),
                                                  child: Text(
                                                    state.errorText ?? '',
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .error,
                                                    ),
                                                  ),
                                                ),
                                        ],
                                      );
                                    },
                                    validator: (value) {
                                      if (selectedPrivilegeMenus.isEmpty) {
                                        return 'Menu Privileges required';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
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
                                      // Get.offAll(UsersMasterView());
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
