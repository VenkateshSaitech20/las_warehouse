// ignore_for_file: prefer_const_declarations, avoid_unnecessary_containers, deprecated_member_use, prefer_const_constructors

import 'dart:async';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
// import 'package:las_warehouse/app/services/filePicker11.dart';
import 'package:las_warehouse/app/data/controller/cities_controller.dart';
import 'package:las_warehouse/app/data/controller/register_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/cities_model.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/services/validations.dart';
import 'package:las_warehouse/app/themes/content_header.dart';
import 'package:las_warehouse/app/themes/text_scale_theme.dart';
import 'package:las_warehouse/app/themes/upper_case_convert.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class WarehouseRegisterScreen extends StatefulWidget {
  const WarehouseRegisterScreen({super.key});

  @override
  State<WarehouseRegisterScreen> createState() =>
      _WarehouseRegisterScreenState();
}

class _WarehouseRegisterScreenState extends State<WarehouseRegisterScreen> {
  static final GlobalKey<FormState> _regFormKey = GlobalKey<FormState>();

  bool load = false;
  List<Citiesmodel> statelist = <Citiesmodel>[];
  List<String> cityList = <String>[];
  Citiesmodel? selectedStateData;
  String? selectedState;
  String? selectedCity;
  // String doe = '';
  final citycontroller = Get.put(Citiescontroller());
  final controller = Get.put(RegisterController());
  DateTime? selectedDOEDate;
  bool agree = false;
  String value1 = '';
  String msg = '';

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
  bool hidePassword1 = true;
  bool hidePassword3 = true;

  RxString? logoFilename = "nothing".obs;
  RxString? gstFilename = "nothing".obs;
  RxString? panFilename = "nothing".obs;
  RxString? aadharFilename = "nothing".obs;
  File? logoImage;
  String _gstFilePath = '';
  String _panFilePath = '';
  String _aadharFilePath = '';
  String _logoFilePath = '';

  @override
  void initState() {
    countrycontroller.text = 'India';
    loadData();
    super.initState();
  }

  loadData() async {
    await Citiescontroller().stateCityAPI();
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

  _trySubmitForm() async {
    if (_regFormKey.currentState!.validate()) {
      await controller
          .registerAPI(
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
        //agree.toString(),
        'Y',
        cinController.text,
      )
          .then((value) {
        if (value != null) {
          if (value["result"] == true) {
            Get.offAllNamed('/auth');
          }
        }
      });
    }
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    statelist = Get.find<Citiescontroller>().citiesData;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 15, 30, 20),
            child: Form(
              key: _regFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(Constant.logo),
                    ),
                  ),
                  const SizedBox(
                    height: 35,
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
                    height: 15,
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
                      suffix: Padding(
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
                    height: 15,
                  ),
                  ContentHeaderWidget(
                    title: "Upload Logo",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                    showImageInfo: true,
                    imageOnly: true,
                  ),
                  const SizedBox(height: 10),
                  FormField<bool>(
                    builder: (state) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() async {
                                    await CommonFilePicker().pickAFile(
                                      FileType.image,
                                      false,
                                      [],
                                    ).then((value) {
                                      setState(() {
                                        logoImage =
                                            File(value!.files.first.path!);

                                        _logoFilePath = value.files.first.path!;
                                        logoFilename =
                                            value.files.first.name.obs;
                                      });
                                    });
                                  });
                                },
                                icon: const Icon(Icons.file_copy),
                              ),
                              Obx(
                                () => Text(
                                  logoFilename == "nothing".obs
                                      ? "No file chosen"
                                      : "$logoFilename",
                                  style: MyText.customText15(context)!.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          state.errorText == null
                              ? Container()
                              : Padding(
                                  padding: EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    state.errorText ?? '',
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                    ),
                                  ),
                                ),
                        ],
                      );
                    },
                    validator: (value) {
                      if (logoFilename == "nothing".obs) {
                        return 'Logo image is required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ContentHeaderWidget(
                    title: "GST Number",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                  ),
                  TextFieldThem.buildTextFieldTheme(
                    initialValue: '',
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
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
                      suffix: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.primaryblue,
                          // minimumSize:
                          //     const Size.fromHeight(40), // NEW
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.zero),
                          ),
                        ),
                        onPressed: () {},
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width / 5,
                          child: Text(
                            'Validate',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:
                                  14 * MediaQuery.of(context).textScaleFactor,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ),
                      ),
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
                        return '${Constant.messages.gstReq ?? ' GST is required'}'
                            .tr;
                      } else if (!RegExp(
                        '^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}',
                      ).hasMatch(value)) {
                        return 'Enter a valid GST number'.tr;
                      } else if (value.length < 15) {
                        return '${Constant.messages.gstLength ?? ' GST number length must be equal to 15'}';
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                      LengthLimitingTextInputFormatter(15),
                      UpperCaseTextFormatter(),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ContentHeaderWidget(
                    title: "Upload GST",
                    mustShow: false,
                    colorvalue: MyColors.grey,
                    showImageInfo: true,
                    imageOnly: false,
                  ),
                  const SizedBox(height: 10),
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
                                _gstFilePath = value!.files.first.path!;
                                gstFilename = value.files.first.name.obs;
                              });
                            });
                          });
                        },
                        icon: const Icon(Icons.file_copy),
                      ),
                      Obx(
                        () => Text(
                          gstFilename == "nothing".obs
                              ? "No file chosen"
                              : "$gstFilename",
                          style: MyText.customHintText13(context)!
                              .copyWith(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ContentHeaderWidget(
                    title: "PAN Number",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                  ),
                  TextFieldThem.buildTextFieldTheme(
                    initialValue: '',
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
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
                        return '${Constant.messages.panLength ?? 'PAN number length must be equal to 10'}';
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                      LengthLimitingTextInputFormatter(10),
                      UpperCaseTextFormatter(),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ContentHeaderWidget(
                    title: "Upload PAN",
                    mustShow: false,
                    colorvalue: MyColors.grey,
                    showImageInfo: true,
                    imageOnly: false,
                  ),
                  const SizedBox(height: 10),
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
                                _panFilePath = value!.files.first.path!;
                                panFilename = value.files.first.name.obs;
                              });
                            });
                          });
                        },
                        icon: const Icon(Icons.file_copy),
                      ),
                      Obx(
                        () => Text(
                          panFilename == "nothing".obs
                              ? "No file chosen"
                              : "$panFilename",
                          style: MyText.customText15(context)!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                      LengthLimitingTextInputFormatter(12),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ContentHeaderWidget(
                    title: "Upload Aadhar",
                    mustShow: false,
                    colorvalue: MyColors.grey,
                    showImageInfo: true,
                    imageOnly: false,
                  ),
                  const SizedBox(height: 10),
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
                        () => Text(
                          aadharFilename == "nothing".obs
                              ? "No file chosen"
                              : "$aadharFilename",
                          style: MyText.customText15(context)!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
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
                      } else if (!RegExp('^[1-9]{1}[0-9]{9}').hasMatch(value)) {
                        return 'Enter a valid Postal code'.tr;
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
                        return '${Constant.messages.cinReq ?? 'CIN Number is required'}'
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
                      FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                      UpperCaseTextFormatter(),
                      LengthLimitingTextInputFormatter(21),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ContentHeaderWidget(
                    title: "Password",
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
                    obscureText: hidePassword1,
                    autocorrect: false,
                    maxLines: 1,
                    minLines: 1,
                    expands: false,
                    maxLength: null,
                    onChanged: (value) {
                      value1 = value;
                    },
                    onEditingComplete: () {},
                    onFieldSubmitted: (value) {},
                    onSaved: (value) {},
                    enabled: true,
                    autovalidateMode: AutovalidateMode.always,
                    controller: passController,
                    decoration: InputDecoration(
                      errorMaxLines: 1,
                      labelText: null,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            hidePassword1 = !hidePassword1;
                            Future.delayed(const Duration(milliseconds: 900),
                                () {
                              setState(() {
                                hidePassword1 = !hidePassword1;
                              });
                            });
                          });
                        },
                        child: Icon(
                          !hidePassword1
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: !hidePassword1
                              ? MyColors.primaryblue
                              : MyColors.primaryred,
                        ),
                      ),
                      border: const UnderlineInputBorder(),
                      hintText: "Enter Password",
                      hintStyle: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (String? value) {
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
                    inputFormatters: null,
                  ),
                  const SizedBox(height: 15),
                  ContentHeaderWidget(
                    title: "Confirm Password",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                  ),
                  TextFieldThem.buildTextFieldTheme(
                    initialValue: '',
                    keyboardType: TextInputType.visiblePassword,
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
                    obscureText: hidePassword3,
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
                    controller: cPassController,
                    decoration: InputDecoration(
                      errorMaxLines: 1,
                      labelText: null,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            hidePassword3 = !hidePassword3;
                            Future.delayed(const Duration(milliseconds: 900),
                                () {
                              setState(() {
                                hidePassword3 = !hidePassword3;
                              });
                            });
                          });
                        },
                        child: Icon(
                          !hidePassword3
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: !hidePassword3
                              ? MyColors.primaryblue
                              : MyColors.primaryred,
                        ),
                      ),
                      border: const UnderlineInputBorder(),
                      hintText: "Confirm your Password",
                      hintStyle: MyText.customText15(context)!.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return '${Constant.messages.passwordReq ?? 'Confirm Password is required'}'
                            .tr;
                      } else if (cPassController.text != passController.text) {
                        return '${Constant.messages.pwdNotMatch ?? 'Confirm password does not match'}';
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: null,
                  ),
                  const SizedBox(height: 15),
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
                      if (value!.isNotEmpty && value.length < 256) {
                        return null;
                      } else if (value.length > 256) {
                        return 'length should be lessthan 256 characters';
                      } else {
                        return '${Constant.messages.address2Req ?? 'Address2 is required'}';
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
                      } else if (!RegExp('^[1-9]{1}[0-9]{5}').hasMatch(value)) {
                        return 'Enter a valid Postal code'.tr;
                      } else if (value.length != 6) {
                        return '${Constant.messages.pincodeValid ?? 'Length must be equal to 6'}'
                            .tr;
                      } else {
                        return null;
                      }
                    },
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      LengthLimitingTextInputFormatter(6),
                    ],
                  ),
                  const SizedBox(height: 15),
                  ContentHeaderWidget(
                    title: "Country",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                  ),
                  TextFieldThem.buildTextFieldTheme(
                    style: MyText.customText15(context)!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                    initialValue: '',
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.none,
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
                  TypeAheadField(
                    // key: stateKey,
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
                        style: MyText.customText15(context)!.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                        validator: ((value) {
                          if (selectedStateData == null) {
                            return 'Name of the state required';
                          }
                          return null;
                        }),
                        controller: controller,
                        focusNode: focusNode,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: const UnderlineInputBorder(),
                          hintText: "Select your State",
                          hintStyle: MyText.customText15(context)!.copyWith(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
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
                  const SizedBox(height: 15),
                  ContentHeaderWidget(
                    title: "City",
                    mustShow: true,
                    colorvalue: MyColors.grey,
                  ),
                  selectedStateData == null
                      ? Container(
                          padding: const EdgeInsets.only(
                            left: 0,
                            right: 10,
                            top: 10,
                            bottom: 10,
                          ),
                          width: MediaQuery.of(context).size.width,
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                width: 2,
                                color: MyColors.grey,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 6.0,
                                    bottom: 6.0,
                                  ),
                                  child: Text(
                                    "Select your city",
                                    textAlign: TextAlign.start,
                                    style:
                                        MyText.customText15(context)!.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.clear,
                                color: Colors.black,
                                size: 20,
                              ),
                            ],
                          ),
                        )
                      : TypeAheadField(
                          // key: cityKey,
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
                              style: MyText.customText15(context)!.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                              ),
                              validator: ((value) {
                                if (selectedCity == '' &&
                                    selectedCity != null) {
                                  return 'City required';
                                }
                                return null;
                              }),
                              controller: controller,
                              focusNode: focusNode,
                              autofocus: false,
                              decoration: InputDecoration(
                                border: const UnderlineInputBorder(),
                                hintText: "Select your City",
                                hintStyle:
                                    MyText.customText15(context)!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
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
                        ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FormField<bool>(
                          builder: (state) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Checkbox(
                                      value: agree,
                                      onChanged: (value) {
                                        setState(() {
                                          agree = value!;
                                          state.didChange(value);
                                        });
                                      },
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width -
                                          100,
                                      child: Text(
                                        "${Constant.messages.termsTxt ?? 'I hereby declare that the information provided in this vendor registration form is true, complete and accurate to the best of my knowledge. I understand that any false or misleading information may lead to disqualification or termination of the vendor registration process.'}",
                                        style: MyText.customBodytext14(context)!
                                            .copyWith(
                                          letterSpacing: 0.0,
                                          color: MyColors.grey,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: state.errorText == null ? 0.0 : 5.0,
                                  ),
                                  child: Text(
                                    state.errorText ?? '',
                                    style: TextStyle(
                                      color: Theme.of(context).errorColor,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                          validator: (value) {
                            if (!agree) {
                              return '${Constant.messages.termsReq ?? 'please check the agree checkbox'}';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryblue,
                        elevation: 0,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                      child: Text(
                        "SUBMIT",
                        style: MyText.customFormTitle18(context)!.copyWith(
                          color: MyColors.primarywhite,
                          fontWeight: FontWeight.normal,
                          letterSpacing: 0,
                        ),
                        textScaleFactor: ScaleSize.textScaleFactor(context),
                      ),
                      onPressed: () {
                        _trySubmitForm();
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an Account?",
                          style: MyText.customBodytext14(context)!
                              .copyWith(letterSpacing: 0.0),
                          textScaleFactor: ScaleSize.textScaleFactor(context),
                        ),
                        TextButton(
                          onPressed: () {
                            Get.offAllNamed('/auth');
                          },
                          child: Text(
                            "Login Here",
                            style: MyText.customSubtitle16(context)!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: MyColors.darkblue,
                              decoration: TextDecoration.none,
                            ),
                            textScaleFactor: ScaleSize.textScaleFactor(context),
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
    );
  }
}
