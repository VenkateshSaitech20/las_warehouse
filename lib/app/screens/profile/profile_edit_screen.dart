// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/screens/widgets/show_toast_dialog.dart';
import 'package:las_warehouse/app/data/controller/cities_controller.dart';
import 'package:las_warehouse/app/data/controller/profile_controller.dart';
import 'package:las_warehouse/app/data/controller/profile_update_controller.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/cities_model.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/profile/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:las_warehouse/app/services/validations.dart';
import 'package:las_warehouse/app/themes/content_header.dart';
import 'dart:ui' as ui;

import 'package:las_warehouse/app/themes/upper_case_convert.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final profileUpdateController = Get.put(ProfileUpdateController());
  final profileDataController = Get.put(ProfileController());
  final cityController = Get.put(Citiescontroller());

  TextEditingController countrycontroller = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController panController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController gstController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController cPassController = TextEditingController();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController address1Controller = TextEditingController();
  TextEditingController address2Controller = TextEditingController();
  TextEditingController stateTController = TextEditingController();
  TextEditingController cityTController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController doeController = TextEditingController();
  final picker = ImagePicker();
  String profilePicLink = '';
  User userProfileData1 = User();

  File _logoImage = File('');
  String _gstFilePath = '';
  String _panFilePath = '';
  String _aadharFilePath = '';
  String _logoFilePath = '';
  final _peFormKey = GlobalKey<FormState>();
  TextEditingController pcontroller = TextEditingController();
  TextEditingController cpcontroller = TextEditingController();
  List<String> selected = [];
  List<String> selected1 = [];

  RxString? logoFilename = "nothing".obs;
  RxString? gstFilename = "nothing".obs;
  RxString? panFilename = "nothing".obs;
  RxString? aadharFilename = "nothing".obs;
  bool agree = false;

  List<Citiesmodel> statelist = <Citiesmodel>[];
  List<String> cityList = <String>[];
  Citiesmodel? selectedStateData;
  String? selectedState;
  String? selectedCity;
  DateTime? selectedDOEDate;

  bool load = false;

  @override
  void initState() {
    loadData();
    super.initState();

    userProfileData1 = Constant.userData;
    companyNameController.text = userProfileData1.vendorName!;
    cinController.text = userProfileData1.cinNo!;
    panController.text = userProfileData1.panNo!;
    aadharController.text = userProfileData1.aadharNo!;
    gstController.text = userProfileData1.gstNo!;
    emailController.text = userProfileData1.email!;
    phoneController.text = userProfileData1.phone!;
    passController.text = userProfileData1.password!;
    cPassController.text = userProfileData1.password!;
    pincodeController.text = userProfileData1.pincode!;
    address1Controller.text = userProfileData1.address1!;
    address2Controller.text = userProfileData1.address2!;
    countrycontroller.text = userProfileData1.country!;
    stateTController.text = userProfileData1.state!;
    cityTController.text = userProfileData1.city!;
    selectedState = userProfileData1.state!;
    selectedCity = userProfileData1.city!;
    doeController.text = userProfileData1.doe!;

    gstFilename = userProfileData1.gstFile != null
        ? userProfileData1.gstFile!.obs
        : 'nothing'.obs;
    panFilename = userProfileData1.panFile != null
        ? userProfileData1.panFile!.obs
        : 'nothing'.obs;
    aadharFilename = userProfileData1.aadharFile != null
        ? userProfileData1.aadharFile!.obs
        : 'nothing'.obs;
  }

  Future<void> _selectDOEDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: ThemeData(
            primaryColor: Colors.orangeAccent,
            disabledColor: Colors.brown,
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.blueAccent),
            ),
            hoverColor: Colors.yellow,
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != selectedDOEDate) {
      setState(() {
        doeController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  void _trySubmitForm() async {
    if (_peFormKey.currentState?.validate() == true) {
      await profileUpdateController
          .updateProfileDataAPI(
        companyNameController.text,
        doeController.text,
        gstController.text,
        panController.text,
        aadharController.text,
        emailController.text,
        passController.text,
        cPassController.text,
        phoneController.text,
        address1Controller.text,
        address2Controller.text,
        pincodeController.text,
        countrycontroller.text,
        stateTController.text,
        cityTController.text,
        _logoFilePath,
        _gstFilePath,
        _panFilePath,
        _aadharFilePath,
        agree.toString(),
        cinController.text,
      )
          .then((value) async {
        if (value != null) {
          if (value["result"] == true) {
            profileDataController.getProfileDataAPI().then((value) {
              if (value != null) {
                if (value.result == true) {
                  Get.offAndToNamed('/profile');
                }
              }
            });
          } else {
            ShowToastDialog.showToast(
              '${json.encode(value["message"]).toString()}',
            );
          }
        }
      });
    }
  }

  _willPop() {
    Get.back();
  }

  loadData() async {
    await cityController.stateCityAPI();
  }

  @override
  Widget build(BuildContext context) {
    statelist = cityController.citiesData;

    if (statelist.isEmpty) {
      for (int i = 0; i < statelist.length; i++) {
        if (selectedState == statelist[i].state) {
          selectedStateData = statelist[i];
          cityList = selectedStateData!.cities!;
        }
      }
    }

    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: MyColors.primarywhite,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: SingleChildScrollView(
          child: Form(
            key: _peFormKey,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                  top: 10,
                  bottom: 20,
                  right: 30,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: SizedBox(
                        height: 115,
                        width: 115,
                        child: Stack(
                          clipBehavior: Clip.none,
                          fit: StackFit.expand,
                          children: [
                            logoFilename!.value == 'nothing'
                                ? CircleAvatar(
                                    radius: 43,
                                    backgroundImage: NetworkImage(
                                      userProfileData1.logo!,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 43,
                                    backgroundImage: FileImage(_logoImage),
                                  ),
                            // : CircleAvatar(

                            //     backgroundImage:
                            //         AssetImage('assets/profile.jpg'),
                            //   ),
                            Positioned(
                              bottom: 0,
                              right: -35,
                              child: RawMaterialButton(
                                onPressed: () async {
                                  await CommonFilePicker().pickAFile(
                                    FileType.image,
                                    false,
                                    [
                                      'jpg',
                                      'png',
                                      'jpeg',
                                    ],
                                  ).then((value) {
                                    setState(() {
                                      _logoImage =
                                          File(value!.files.first.path!);

                                      _logoFilePath = value.files.first.path!;
                                      logoFilename = value.files.first.name.obs;
                                    });
                                  });
                                },
                                elevation: 2.0,
                                fillColor: Colors.white,
                                padding: const EdgeInsets.all(15.0),
                                shape: const CircleBorder(),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: MyColors.primaryblue,
                                  size: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ContentHeaderWidget(
                      title: "Warehouse Name",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      controller: companyNameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Warehouse Name",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return Constant.messages.nameReq ?? 'required'.tr;
                        } else if (Validations().hasOnlySpace(value)) {
                          return "This field doesn't allow only spaces";
                        } else if (Validations().hasOnlyNumber(value)) {
                          return "This field doesn't allow only numbers";
                        } else if (!Validations().nameField(value)) {
                          return 'Some special characters are not allowed.'.tr;
                        } else if (value.length > 256) {
                          return 'length should be lessthan 256 characters';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "Date of Establishment",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _selectDOEDate(context);
                      },
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: doeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffix: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.calendar_month,
                            color: MyColors.primaryblue,
                          ),
                        ),
                        border: const UnderlineInputBorder(),
                        hintText: "DOE (DD-MM-YYYY)",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.doeReq ?? 'please select Date.'}'
                              .tr;
                        }

                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "Email",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      controller: emailController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Email address",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.emailReq ?? 'Email is required'}'
                              .tr;
                        } else if (!RegExp(
                          r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$',
                        ).hasMatch(value)) {
                          return 'Invalid Email'.tr;
                        } else {
                          return null;
                        }
                      },
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "Phone",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.center,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: phoneController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Phone number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '${Constant.messages.phoneReq ?? 'Phone Number is required'}'
                              .tr;
                        }
                        if (value.length != 10) {
                          return '${Constant.messages.phoneLength ?? 'Length must be equal to 10'}'
                              .tr;
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "CIN Number",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: cinController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter CIN Number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return '${Constant.messages.cinReq ?? 'Cin Number is required'}'
                              .tr;
                        } else if (!RegExp(
                          '^[A-Z]{1}[0-9]{5}[A-Z]{2}[0-9]{4}[A-Z]{3}[1-9]{6}',
                        ).hasMatch(value)) {
                          return 'Enter a valid CIN number'.tr;
                        }
                        if (value.length != 21) {
                          return '${Constant.messages.cinLength ?? 'Length must be equal to 21'}'
                              .tr;
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'),
                        ),
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(21),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "GST Number",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: gstController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter GST Number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.gstReq ?? ' Gst is required'}'
                              .tr;
                        } else if (!RegExp(
                          '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}',
                        ).hasMatch(value)) {
                          return 'Enter a valid GST number'.tr;
                        } else if (value.length < 15) {
                          return '${Constant.messages.gstLength ?? ' Gst number length must be equal to 15'}';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'),
                        ),
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(15),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ContentHeaderWidget(
                      title: "Upload GST",
                      colorvalue: MyColors.grey,
                      mustShow: false,
                      showImageInfo: true,
                      imageOnly: false,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() async {
                              await CommonFilePicker()
                                  .pickAFile(FileType.custom, false, [
                                'jpg'
                                    'png',
                                'jpeg',
                                'pdf',
                              ]).then((value) {
                                setState(() {
                                  _gstFilePath = value!.files.first.path!;
                                  gstFilename = value.files.first.name.obs;
                                });
                              });
                            });
                          },
                          icon: const Icon(Icons.file_copy),
                        ),
                        Obx(
                          () => Flexible(
                            child: Text(
                              gstFilename == "nothing".obs
                                  ? "No file chosen"
                                  : "${gstFilename!.split("/").last}",
                              style: MyText.customText15(context)!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "PAN Number",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: panController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter PAN Number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.panReq ?? 'PAN Number is required'}'
                              .tr;
                        } else if (!RegExp('^[A-Z]{5}[0-9]{4}[A-Z]{1}')
                            .hasMatch(value)) {
                          return 'Enter a valid PAN number'.tr;
                        } else if (value.length < 10) {
                          return '${Constant.messages.panLength ?? 'Pan number length must be equal to 10'}';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(
                          RegExp('[a-zA-Z0-9]'),
                        ),
                        UpperCaseTextFormatter(),
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "Upload PAN",
                      colorvalue: MyColors.grey,
                      mustShow: false,
                      showImageInfo: true,
                      imageOnly: false,
                    ),
                    const SizedBox(
                      height: 7,
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            setState(() async {
                              await CommonFilePicker()
                                  .pickAFile(FileType.custom, false, [
                                'jpg',
                                'png',
                                'jpeg',
                                'pdf',
                              ]).then((value) {
                                setState(() {
                                  _panFilePath = value!.files.first.path!;
                                  panFilename = value.files.first.name.obs;
                                });
                              });
                            });
                          },
                          icon: const Icon(Icons.file_copy),
                        ),
                        Obx(
                          () => Flexible(
                            child: Text(
                              panFilename == "nothing".obs
                                  ? "No file chosen"
                                  : "${panFilename!.split("/").last}",
                              style: MyText.customText15(context)!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "Aadhar Number",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: aadharController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter Aadhar Number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.aadharReq ?? ' Aadhar number is required'}'
                              .tr;
                        } else if (!RegExp('^[2-9]{1}[0-9]{11}')
                            .hasMatch(value)) {
                          return 'Enter a valid Aadhar number'.tr;
                        } else if (value.length < 12) {
                          return '${Constant.messages.aadharLength ?? 'Aadhar number must be equal to '}';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(12),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    ContentHeaderWidget(
                      title: "Upload Aadhar",
                      colorvalue: MyColors.grey,
                      mustShow: false,
                      showImageInfo: true,
                      imageOnly: false,
                    ),
                    const SizedBox(height: 7),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() async {
                              await CommonFilePicker()
                                  .pickAFile(FileType.custom, false, [
                                'jpg',
                                'png',
                                'jpeg',
                                'pdf',
                              ]).then((value) {
                                setState(() {
                                  _aadharFilePath = value!.files.first.path!;
                                  aadharFilename = value.files.first.name.obs;
                                });
                              });
                            });
                          },
                          icon: const Icon(Icons.file_copy),
                        ),
                        Obx(
                          () => Flexible(
                            child: Text(
                              aadharFilename == "nothing".obs
                                  ? "No file chosen"
                                  : "${aadharFilename!.split("/").last}",
                              style: MyText.customText15(context)!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    ContentHeaderWidget(
                      title: "Address 1",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: address1Controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter your Address",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isNotEmpty && value.length < 256) {
                          return null;
                        } else if (value.length > 256) {
                          return 'length should be lessthan 256 characters';
                        } else {
                          return '${Constant.messages.address1Req ?? 'Address1 is required'}';
                        }
                      },
                      inputFormatters: null,
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "Address 2",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: address2Controller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter your Address",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.address2Req ?? 'Address2 is required'}';
                        } else if (value.length > 256) {
                          return 'length should be lessthan 256 characters';
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: null,
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "Pincode",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.number,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: false,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: pincodeController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "Enter 6-digit number",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return '${Constant.messages.pincodeReq ?? 'Pin code is required'}'
                              .tr;
                        } else if (value.length != 6) {
                          return '${Constant.messages.pincodeValid ?? 'Length must be equal to 6'}'
                              .tr;
                        } else {
                          return null;
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(6),
                      ],
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "Country",
                      mustShow: false,
                      colorvalue: MyColors.grey,
                    ),
                    TextFieldThem.buildTextFieldTheme(
                      initialValue: '',
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.none,
                      textInputAction: TextInputAction.none,
                      style: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                      strutStyle: const StrutStyle(),
                      textDirection: ui.TextDirection.ltr,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical.bottom,
                      readOnly: true,
                      showCursor: true,
                      autofocus: true,
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
                      enabled: true,
                      autovalidateMode: AutovalidateMode.disabled,
                      controller: countrycontroller,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        errorMaxLines: 1,
                        labelText: null,
                        suffixIcon: null,
                        border: const UnderlineInputBorder(),
                        hintText: "",
                        hintStyle: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    ContentHeaderWidget(
                      title: "State",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    const SizedBox(height: 5),
                    TypeAheadField(
                      controller: stateTController,
                      suggestionsCallback: (search) {
                        return statelist
                            .where(
                              (statee) => statee.state!
                                  .toLowerCase()
                                  .contains(search.toLowerCase()),
                            )
                            .toList();
                      },
                      builder: (context, controller, focusNode) {
                        return TextFormField(
                          validator: (value) {
                            if (selectedState == null) {
                              return 'Select name of state';
                            }
                            return null;
                          },
                          controller: controller,
                          focusNode: focusNode,
                          autofocus: false,
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            hintText: "Select your State",
                            hintStyle: const TextStyle(color: Colors.black),
                            suffixIcon: InkWell(
                              onTap: () {
                                selectedStateData = null;
                                selectedState = '';
                                stateTController.clear();
                                selectedCity = '';
                                cityTController.clear();
                              },
                              child: const Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 20,
                              ),
                            ),
                          ),
                        );
                      },
                      itemBuilder: (context, city) {
                        return ListTile(
                          title: Text(city.state!),
                        );
                      },
                      onSelected: (Citiesmodel? item) {
                        setState(() {
                          load = true;
                          stateTController.text = item!.state!;
                          selectedState = item.state!;
                          selectedStateData = null;
                          // selectedStateData!.cities = [];
                          selectedStateData = item;
                          selectedCity = '';
                          cityTController.clear();
                          cityList = item.cities!;
                          print(cityList);
                          load = false;
                        });
                        print(stateTController.text);
                        print(cityList);
                      },
                    ),
                    const SizedBox(height: 25),
                    ContentHeaderWidget(
                      title: "City",
                      mustShow: true,
                      colorvalue: MyColors.grey,
                    ),
                    const SizedBox(height: 5),
                    (selectedStateData != null &&
                                selectedCity != '' &&
                                selectedState != '') ||
                            (selectedStateData != null &&
                                selectedCity == '' &&
                                selectedState != '')
                        ? TypeAheadField(
                            controller: cityTController,
                            suggestionsCallback: (search) {
                              return cityList
                                  .where(
                                    (cityy) => cityy
                                        .toLowerCase()
                                        .contains(search.toLowerCase()),
                                  )
                                  .toList();
                            },
                            builder: (context, controller, focusNode) {
                              return TextFormField(
                                validator: (value) {
                                  if (selectedCity == null) {
                                    return 'Select name of the city';
                                  }
                                  return null;
                                },
                                controller: controller,
                                focusNode: focusNode,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: const UnderlineInputBorder(),
                                  hintText: "Select your City",
                                  hintStyle:
                                      const TextStyle(color: Colors.black),
                                  suffixIcon: InkWell(
                                    onTap: () {
                                      selectedCity = '';
                                      cityTController.clear();
                                    },
                                    child: const Icon(
                                      Icons.clear,
                                      color: Colors.black,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              );
                            },
                            itemBuilder: (context, city) {
                              return ListTile(
                                title: Text(city),
                              );
                            },
                            onSelected: (String? item) {
                              setState(() {
                                selectedCity = item;
                                cityTController.text = item!;
                              });
                            },
                          )
                        : Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.only(
                              right: 10.0,
                              top: 5,
                              bottom: 15.0,
                            ),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: MyColors.grey),
                              ),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  "$selectedCity",
                                  style: TextStyle(
                                    fontSize: 15 *
                                        MediaQuery.of(context).textScaleFactor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.primaryblue,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.zero),
                            ),
                          ),
                          onPressed: () {
                            _trySubmitForm();
                          },
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 5,
                            child: const Text(
                              "SAVE",
                              textAlign: TextAlign.center,
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
                              style: TextStyle(color: MyColors.primaryblue),
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
        ),
      ),
    );
  }
}
