// ignore_for_file: unnecessary_null_comparison, prefer_const_constructors, deprecated_member_use

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/models/warehouse_category_model.dart';
import 'package:las_warehouse/app/data/models/warehouse_services_model.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/data/controller/master_controller.dart';
import 'package:las_warehouse/app/data/controller/warehouse_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/amenity_model.dart';
import 'package:las_warehouse/app/data/models/material_type_model.dart';
import 'package:las_warehouse/app/data/models/timing_model.dart';
import 'package:las_warehouse/app/data/models/warehouse_types_model.dart';
import 'package:las_warehouse/app/services/validations.dart';
import 'package:las_warehouse/app/themes/content_header.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class Addwarehousepage extends StatefulWidget {
  const Addwarehousepage({super.key});

  @override
  State<Addwarehousepage> createState() => _AddwarehousepageState();
}

class _AddwarehousepageState extends State<Addwarehousepage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final masterController = Get.put(MasterController());
  List<WareHouseType> wareHouseTypeList = [];
  List<WHCategory> whCategoryList = [];
  List<WHService> whServiceList = [];
  List<MaterialTypeModel> materialTypeList = [];
  List<MaterialTypeModel> selectedmaterialTypeList = [];
  List<AmenityType> amenityList = [];
  List<AmenityType> amenitiesList = [];
  List<AmenityType> selectedAmenitiesList = [];
  List<Timings> timingList = [];

  WareHouseType? selectedWareHouseType;
  WHCategory? selectedWareHouseCategory;
  List<WHService> selectedWareHouseServices = [];
  MaterialTypeModel? materialselectedValue;
  List<String> selectedAmenities = [];
  String? selectedCityLocation;

  bool load = false;
  String name = "";

  String? mondayvalue;
  String? tuesdayvalue;
  String? wednesdayvalue;
  String? thursdayvalue;
  String? fridayvalue;
  String? saturdayvalue;
  String? sundayvalue;

  String? mondayvalue2;
  String? tuesdayvalue2;
  String? wednesdayvalue2;
  String? thursdayvalue2;
  String? fridayvalue2;
  String? saturdayvalue2;
  String? sundayvalue2;

  Timings? monfrom;
  Timings? monto;
  bool moncheck = false;

  Timings? tuefrom;
  Timings? tueto;
  bool tuecheck = false;

  Timings? wedfrom;
  Timings? wedto;
  bool wedcheck = false;

  Timings? thurfrom;
  Timings? thurto;
  bool thurcheck = false;

  Timings? frifrom;
  Timings? frito;
  bool fricheck = false;

  Timings? satfrom;
  Timings? satto;
  bool satcheck = false;

  Timings? sunfrom;
  Timings? sunto;
  bool suncheck = false;

  RxString? filename = "nothing".obs;

  String? logoname = "nothing";
  String? lfname = "nothing";
  String? fsname = "nothing";
  String? bpname = "nothing";
  String? ecname = "nothing";
  String? idname = "nothing";
  String? pwname = "nothing";
  String? shliname = "nothing";
  String? laliname = "nothing";

  String? logofilepath;
  String? lffilepath;
  String? fsfilepath;
  String? bpfilepath;
  String? ecfilepath;
  String? idfilepath;
  String? pwfilepath;
  String? shlifilepath;
  String? lalifilepath;

  List<String> yardnames = [];
  List<String> dockingnames = [];
  List<String> gatenames = [];
  List<String> equipmentsnames = [];
  List<String> yardpics = [];
  List<String> dockingpic = [];
  List<String> gatepics = [];
  List<String> equipmentspic = [];
  String? selectedCity;
  List<String>? cityList = [];

  TextEditingController Citiescontroller = TextEditingController();
  TextEditingController wnameTController = TextEditingController();
  TextEditingController wshortnameTController = TextEditingController();
  TextEditingController totlandTController = TextEditingController();
  TextEditingController StorageTController = TextEditingController();
  TextEditingController handingTController = TextEditingController();
  TextEditingController yearTController = TextEditingController();
  TextEditingController builtupTController = TextEditingController();
  TextEditingController latitudeTController = TextEditingController();
  TextEditingController longitudeTController = TextEditingController();
  final warehouseController = Get.put(WarehouseController());
  String amenityStr = '';
  String materialStr = '';

  @override
  void initState() {
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  void trySubmit() async {
    if (formKey.currentState!.validate() == true) {
      String materialString = '';
      String amenityString = '';
      String servicesString = '';

      for (int i = 0; i < selectedmaterialTypeList.length; i++) {
        materialString =
            materialString + '${selectedmaterialTypeList[i].materialType},';
      }

      for (int i = 0; i < selectedAmenitiesList.length; i++) {
        amenityString = amenityString + '${selectedAmenitiesList[i].amenity},';
      }
      for (int i = 0; i < selectedWareHouseServices.length; i++) {
        servicesString =
            servicesString + '${selectedWareHouseServices[i].service},';
      }

      String jsontiming =
          '''{"Monday":{"from":"${monfrom!.timing!}","to":"${monto!.timing!}"},"Tuesday":{"from":"${tuefrom!.timing!}","to":"${tueto!.timing!}"},"Wednesday":{"from":"${wedfrom!.timing!}","to":"${wedto!.timing!}"},"Thursday":{"from":"${thurfrom!.timing!}","to":"${thurto!.timing!}"},"Friday":{"from":"${frifrom!.timing!}","to":"${frito!.timing!}"},"Saturday":{"from":"${satfrom!.timing!}","to":"${satto!.timing!}"},"Sunday":{"from":"${sunfrom!.timing!}","to":"${sunto!.timing!}"}}''';

      await warehouseController
          .addWarehouseAPI(
        wnameTController.text,
        wshortnameTController.text,
        selectedWareHouseType!.warehouseType!,
        selectedWareHouseCategory!.category!,
        num.parse(totlandTController.text),
        StorageTController.text,
        handingTController.text,
        int.parse(yearTController.text),
        int.parse(builtupTController.text),
        materialString,
        selectedCity,
        amenityString,
        servicesString,
        jsontiming,
        latitudeTController.text,
        longitudeTController.text,
        logofilepath,
        lffilepath,
        fsfilepath,
        bpfilepath,
        ecfilepath,
        idfilepath,
        shlifilepath,
        lalifilepath,
        yardpics,
        gatepics,
        dockingpic,
        equipmentspic,
      )
          .then((value) {
        if (value != null) {
          Get.offAndToNamed('/warehouses');
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    wareHouseTypeList = Get.find<MasterController>().wareHouseTypeData;
    whCategoryList = Get.find<MasterController>().whCategoriesList;
    whServiceList = Get.find<MasterController>().whServicesList;
    materialTypeList = Get.find<MasterController>().materialTypeData;
    amenityList = Get.find<MasterController>().amenityType;
    timingList = Get.find<MasterController>().timingType;
    cityList = Get.find<MasterController>().cityLocationList;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: DrawerMenu(),
        body: Obx(
          () => Center(
            child: Get.find<MasterController>().load.value
                ? LoaderWidget('')
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 15,
                        bottom: 15,
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Card(
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    top: 10,
                                    bottom: 10,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        width: 15,
                                      ),
                                      Text(
                                        "Add Warehouse",
                                        style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          fontSize: 20 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Warehouse Logo",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await CommonFilePicker()
                                                          .pickAFile(
                                                        FileType.image,
                                                        false,
                                                        [],
                                                      ).then((value) {
                                                        if (value != null) {
                                                          setState(() {
                                                            logoname = value
                                                                .files
                                                                .first
                                                                .name;
                                                            logofilepath = value
                                                                .files
                                                                .first
                                                                .path;
                                                          });
                                                        }
                                                      });
                                                    },
                                                    icon: const Icon(
                                                      Icons.file_copy,
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Text(
                                                      logoname == "nothing"
                                                          ? "No file chosen"
                                                          : "$logoname",
                                                      style: TextStyle(
                                                        fontSize: 14 *
                                                            MediaQuery.of(
                                                              context,
                                                            ).textScaleFactor,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (logoname == "nothing") {
                                            return 'Logo image is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Warehouse Name",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        controller: wnameTController,
                                        initialValue: null,
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return '${Constant.messages.whNameReq ?? 'Warehouse Name is required'}';
                                          } else if (Validations()
                                              .hasOnlySpace(value)) {
                                            return "This field doesn't allow only spaces";
                                          } else if (Validations()
                                              .hasOnlyNumber(value)) {
                                            return "This field doesn't allow only numbers";
                                          } else if (!Validations()
                                              .nameField(value)) {
                                            return 'Some special characters are not allowed.'
                                                .tr;
                                          } else if (value.length > 256) {
                                            return 'length should be lessthan 256 characters';
                                          }
                                          return null;
                                        },
                                        inputFormatters: null,
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                        hintText: "Enter Warehouse Name",
                                        decoration: const InputDecoration(),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Short Name",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        keyboardType: TextInputType.text,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: null,
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        hintStyle: MyText.customHintText13(
                                          context,
                                        )!
                                            .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                        hintText: "Enter Short Name",
                                        controller: wshortnameTController,
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return '${Constant.messages.shtNameReq ?? 'Short Name is required'}';
                                          } else if (Validations()
                                              .hasOnlySpace(value)) {
                                            return "This field doesn't allow only spaces";
                                          } else if (Validations()
                                              .hasOnlyNumber(value)) {
                                            return "This field doesn't allow only numbers";
                                          } else if (!Validations()
                                              .nameField(value)) {
                                            return 'Some special characters are not allowed.'
                                                .tr;
                                          } else if (value.length > 256) {
                                            return 'length should be lessthan 256 characters';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Warehouse Types",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButtonFormField(
                                                  // validator: ((value) {
                                                  //   if (value == null) {
                                                  //     return 'select warehouse type';
                                                  //   }
                                                  //   return null;
                                                  // }),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  dropdownColor:
                                                      MyColors.grey_3,
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 0.0,
                                                      right: 8.0,
                                                      top: 8.0,
                                                      bottom: 8.0,
                                                    ),
                                                  ),
                                                  menuMaxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.50,
                                                  hint: Text(
                                                    "Select Warehouse Type",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                      color: MyColors.grey_100_,
                                                    ),
                                                  ),

                                                  // underline: const SizedBox(),
                                                  //isDense: true,
                                                  isExpanded: true,

                                                  value: selectedWareHouseType,
                                                  // items: dropdownItems,
                                                  items: wareHouseTypeList.map<
                                                          DropdownMenuItem<
                                                              WareHouseType>>(
                                                      (WareHouseType value) {
                                                    return DropdownMenuItem<
                                                        WareHouseType>(
                                                      value: value,
                                                      child: Text(
                                                        value.warehouseType!,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  onChanged: (
                                                    WareHouseType? newValue,
                                                  ) {
                                                    setState(() {
                                                      selectedWareHouseType =
                                                          newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (selectedWareHouseType == null) {
                                            return 'Warehouse type is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Total Land",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.totalLandReq ?? 'Total Land Field is required'}'
                                                .tr;
                                          }
                                        },
                                        hintText: "Enter Total Land",
                                        controller: totlandTController,
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                        suffixWidget: Container(
                                          decoration: const BoxDecoration(
                                            color: MyColors.grey_95,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(4),
                                              topRight: Radius.circular(4),
                                            ),
                                          ),
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              "Sq.ft",
                                              style: TextStyle(
                                                fontSize: 15 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Storage Charges (per sq.ft)",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        suffixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        hintText: "Enter Storage Charges",
                                        controller: StorageTController,
                                        textAlign: TextAlign.right,
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                        prefixWidget: Container(
                                          decoration: const BoxDecoration(
                                            color: MyColors.grey_95,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(4),
                                              topLeft: Radius.circular(4),
                                            ),
                                          ),
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              "₹",
                                              style: TextStyle(
                                                fontSize: 15 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.storageChReq ?? 'Storage Charges Field is required'}'
                                                .tr;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Handling Charges",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      TextFieldThem.boxBuildTextField(
                                        inputFormatter: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        contentPadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        textInputType: TextInputType.number,
                                        validators: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.handlingChReq ?? ' Handling Charges is required'}'
                                                .tr;
                                          }
                                        },
                                        textAlign: TextAlign.right,
                                        hintText: "Enter Handling Charges",
                                        controller: handingTController,
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                        prefixWidget: Container(
                                          decoration: const BoxDecoration(
                                            color: MyColors.grey_95,
                                            borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(4),
                                              topLeft: Radius.circular(4),
                                            ),
                                          ),
                                          width: 50,
                                          child: Center(
                                            child: Text(
                                              "₹",
                                              style: TextStyle(
                                                fontSize: 15 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Year Built",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.yearBReq ?? 'Year Built is required'}'
                                                .tr;
                                          }
                                        },
                                        controller: yearTController,
                                        hintText: "Enter Year Built",
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Built up",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'),
                                          ),
                                        ],
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.builtUpReq ?? 'Built Up Field is required'}'
                                                .tr;
                                          }
                                        },
                                        controller: builtupTController,
                                        hintText: "Enter Built up",
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Warehouse Category",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ButtonTheme(
                                                alignedDropdown: true,
                                                child: DropdownButtonFormField(
                                                  decoration:
                                                      const InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    contentPadding:
                                                        EdgeInsets.only(
                                                      left: 0,
                                                      right: 8.0,
                                                      top: 8.0,
                                                      bottom: 8.0,
                                                    ),
                                                  ),
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                    Radius.circular(5),
                                                  ),
                                                  dropdownColor:
                                                      MyColors.grey_3,
                                                  // padding: EdgeInsets.only(
                                                  //     left: 20, right: 20),
                                                  alignment:
                                                      AlignmentDirectional
                                                          .centerStart,
                                                  elevation: 8,
                                                  menuMaxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .height *
                                                          0.50,
                                                  hint: Text(
                                                    "Select Warehouse Category",
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                      color: MyColors.grey_100_,
                                                    ),
                                                  ),
                                                  // underline: const SizedBox(),
                                                  // isDense: true,
                                                  isExpanded: true,

                                                  value:
                                                      selectedWareHouseCategory,
                                                  // items: dropdownItems,
                                                  items: whCategoryList.map<
                                                          DropdownMenuItem<
                                                              WHCategory>>(
                                                      (WHCategory value) {
                                                    return DropdownMenuItem<
                                                        WHCategory>(
                                                      value: value,
                                                      child:
                                                          Text(value.category!),
                                                    );
                                                  }).toList(),
                                                  onChanged:
                                                      (WHCategory? newValue) {
                                                    setState(() {
                                                      selectedWareHouseCategory =
                                                          newValue!;
                                                    });
                                                  },
                                                ),
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (selectedWareHouseCategory ==
                                              null) {
                                            return 'Warehouse Category is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Warehouse Services",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        margin: const EdgeInsets.all(0),
                                        //elevation: 10,
                                        child: Container(
                                          // height: 40,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              MultiSelectDialogField<WHService>(
                                                validator: ((value) {
                                                  if (value!.isEmpty) {
                                                    return 'Warehouse services is required';
                                                  }
                                                  return null;
                                                }),
                                                buttonIcon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: MyColors.grey_80,
                                                  size: 25,
                                                ),
                                                dialogHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.50,
                                                // initialChildSize: 0.4,
                                                initialValue:
                                                    selectedWareHouseServices,

                                                // autovalidateMode: AutovalidateMode.always,
                                                listType:
                                                    MultiSelectListType.LIST,
                                                searchable: true,
                                                buttonText: Text(
                                                  "Select Warehouse Services",
                                                  style:
                                                      MyText.customHintText13(
                                                    context,
                                                  )!
                                                          .copyWith(
                                                    color: MyColors.grey_5,
                                                  ),
                                                ),
                                                title: const Text("Services"),
                                                items: whServiceList
                                                    .map(
                                                      (e) => MultiSelectItem(
                                                        e,
                                                        e.service!,
                                                      ),
                                                    )
                                                    .toList(),
                                                onConfirm:
                                                    (List<WHService> values) {
                                                  setState(() {
                                                    selectedWareHouseServices =
                                                        values;
                                                  });
                                                },
                                                chipDisplay:
                                                    MultiSelectChipDisplay(
                                                  chipColor:
                                                      MyColors.primaryblue,
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  onTap: (value) {
                                                    setState(() {
                                                      selectedWareHouseServices
                                                          .remove(value);
                                                    });
                                                  },
                                                ),
                                              ),
                                              selectedWareHouseServices.isEmpty
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Nothing selected",
                                                        style: MyText
                                                            .customHintText13(
                                                          context,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Material Types",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                        ),
                                        clipBehavior:
                                            Clip.antiAliasWithSaveLayer,
                                        margin: const EdgeInsets.all(0),
                                        //elevation: 10,
                                        child: Container(
                                          // height: 40,
                                          alignment: Alignment.centerLeft,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              MultiSelectDialogField<
                                                  MaterialTypeModel>(
                                                validator: ((value) {
                                                  if (value!.isEmpty) {
                                                    return 'Material type is required';
                                                  }
                                                  return null;
                                                }),
                                                dialogHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.50,
                                                buttonIcon: const Icon(
                                                  Icons.arrow_drop_down,
                                                  color: MyColors.grey_80,
                                                  size: 25,
                                                ),
                                                // initialChildSize: 0.4,
                                                initialValue:
                                                    selectedmaterialTypeList,

                                                // autovalidateMode: AutovalidateMode.always,
                                                listType:
                                                    MultiSelectListType.LIST,
                                                searchable: true,
                                                buttonText: Text(
                                                  "Select Material Type",
                                                  style:
                                                      MyText.customHintText13(
                                                    context,
                                                  )!
                                                          .copyWith(
                                                    color: MyColors.grey_5,
                                                  ),
                                                ),
                                                title: const Text(
                                                  "Material Type",
                                                ),
                                                items: materialTypeList
                                                    .map(
                                                      (e) => MultiSelectItem(
                                                        e,
                                                        e.materialType!,
                                                      ),
                                                    )
                                                    .toList(),
                                                onConfirm: (
                                                  List<MaterialTypeModel>
                                                      values,
                                                ) {
                                                  setState(() {
                                                    selectedmaterialTypeList =
                                                        values;
                                                  });
                                                },
                                                chipDisplay:
                                                    MultiSelectChipDisplay(
                                                  chipColor:
                                                      MyColors.primaryblue,
                                                  textStyle: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                  onTap: (value) {
                                                    setState(() {
                                                      selectedmaterialTypeList
                                                          .remove(value);
                                                    });
                                                  },
                                                ),
                                              ),
                                              selectedmaterialTypeList.isEmpty
                                                  ? Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                        10,
                                                      ),
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Text(
                                                        "Nothing selected",
                                                        style: MyText
                                                            .customHintText13(
                                                          context,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      ContentHeaderWidget(
                                        title: "Amenities",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      load
                                          ? const CircularProgressIndicator()
                                          : Card(
                                              elevation: 0,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3),
                                              ),
                                              clipBehavior:
                                                  Clip.antiAliasWithSaveLayer,
                                              margin: const EdgeInsets.all(0),
                                              //elevation: 10,
                                              child: Container(
                                                // height: 40,
                                                alignment: Alignment.centerLeft,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 8,
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    MultiSelectDialogField<
                                                        AmenityType>(
                                                      validator: ((value) {
                                                        if (value!.isEmpty) {
                                                          return 'Amenities required';
                                                        }
                                                        return null;
                                                      }),
                                                      dialogHeight:
                                                          MediaQuery.of(
                                                                context,
                                                              ).size.height *
                                                              0.50,
                                                      buttonIcon: const Icon(
                                                        Icons.arrow_drop_down,
                                                        color: MyColors.grey_80,
                                                        size: 25,
                                                      ),
                                                      // initialChildSize: 0.4,
                                                      initialValue:
                                                          selectedAmenitiesList,

                                                      // autovalidateMode: AutovalidateMode.always,
                                                      listType:
                                                          MultiSelectListType
                                                              .LIST,
                                                      searchable: true,
                                                      buttonText: Text(
                                                        "Select Amenity Type",
                                                        style: MyText
                                                                .customHintText13(
                                                          context,
                                                        )!
                                                            .copyWith(
                                                          color:
                                                              MyColors.grey_5,
                                                        ),
                                                      ),
                                                      title: const Text(
                                                        "Amenity Type",
                                                      ),
                                                      items: amenityList
                                                          .map(
                                                            (e) =>
                                                                MultiSelectItem(
                                                              e,
                                                              e.amenity!,
                                                            ),
                                                          )
                                                          .toList(),
                                                      onConfirm: (
                                                        List<AmenityType>
                                                            values,
                                                      ) {
                                                        setState(() {
                                                          selectedAmenitiesList =
                                                              values;
                                                        });
                                                      },
                                                      chipDisplay:
                                                          MultiSelectChipDisplay(
                                                        chipColor: MyColors
                                                            .primaryblue,
                                                        textStyle:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                        onTap: (value) {
                                                          setState(() {
                                                            selectedAmenitiesList
                                                                .remove(
                                                              value,
                                                            );
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    selectedAmenitiesList
                                                            .isEmpty
                                                        ? Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              "Nothing selected",
                                                              style: MyText
                                                                  .customHintText13(
                                                                context,
                                                              ),
                                                            ),
                                                          )
                                                        : Container(),
                                                  ],
                                                ),
                                              ),
                                            ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        height: 2,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Documents:",
                                        style: TextStyle(
                                          fontSize: 15 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title:
                                            "Lease Agreement/Rental Agreement",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    lfname =
                                                        value.files.first.name;
                                                    lffilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              lfname == "nothing"
                                                  ? "No file chosen"
                                                  : "$lfname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Fire Safety Certificate",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    fsname =
                                                        value.files.first.name;
                                                    fsfilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              fsname == "nothing"
                                                  ? "No file chosen"
                                                  : "$fsname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Building Plan Approval",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    bpname =
                                                        value.files.first.name;
                                                    bpfilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              bpname == "nothing"
                                                  ? "No file chosen"
                                                  : "$bpname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Environmental Clearance",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    ecname =
                                                        value.files.first.name;
                                                    ecfilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              ecname == "nothing"
                                                  ? "No file chosen"
                                                  : "$ecname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Insurance Documents",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    idname =
                                                        value.files.first.name;
                                                    idfilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              idname == "nothing"
                                                  ? "No file chosen"
                                                  : "$idname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: " Shop License Document",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    shliname =
                                                        value.files.first.name;
                                                    shlifilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              shliname == "nothing"
                                                  ? "No file chosen"
                                                  : "$shliname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Labour License Document",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                      FileType.custom, false, [
                                                'pdf',
                                                'doc',
                                                'docx',
                                              ]).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    laliname =
                                                        value.files.first.name;
                                                    lalifilepath =
                                                        value.files.first.path;
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              laliname == "nothing"
                                                  ? "No file chosen"
                                                  : "$laliname",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        height: 2,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Calendar ( Working Days, Hours open in day, Time Zone)",
                                        style: TextStyle(
                                          fontSize: 15 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Monday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        isExpanded: true,

                                                        value: monfrom,
                                                        //items: dropitems,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            monfrom = newValue!;

                                                            mondayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (mondayvalue !=
                                                                "Closed") {
                                                              moncheck = false;
                                                            }
                                                            if (monfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                monto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.moncheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),

                                                        isExpanded: true,
                                                        value: monto,
                                                        //items: dropitems,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            monto = newValue!;

                                                            mondayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (mondayvalue2 !=
                                                                "Closed") {
                                                              moncheck = false;
                                                            }
                                                            if (monfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                monto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.moncheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.moncheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.moncheck = value!;

                                                        if (moncheck == true) {
                                                          //mondayvalue = "Closed";
                                                          monfrom =
                                                              timingList[49];
                                                          monto =
                                                              timingList[49];
                                                        } else {
                                                          monfrom =
                                                              timingList[0];
                                                          monto = timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (monfrom == null ||
                                              monto == null) {
                                            return 'Monday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Tuesday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: tuefrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            tuefrom = newValue!;

                                                            tuesdayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (tuesdayvalue !=
                                                                "Closed") {
                                                              tuecheck = false;
                                                            }
                                                            if (tuefrom ==
                                                                    timingList[
                                                                        10] &&
                                                                tueto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.tuecheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: tueto,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            tueto = newValue!;

                                                            tuesdayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (tuesdayvalue2 !=
                                                                "Closed") {
                                                              tuecheck = false;
                                                            }
                                                            if (tuefrom ==
                                                                    timingList[
                                                                        10] &&
                                                                tueto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.tuecheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.tuecheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.tuecheck = value!;
                                                        if (tuecheck == true) {
                                                          tuefrom =
                                                              timingList[49];
                                                          tueto =
                                                              timingList[49];
                                                        } else {
                                                          tuefrom =
                                                              timingList[0];
                                                          tueto = timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (tuefrom == null ||
                                              tueto == null) {
                                            return 'Tuesday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Wednesday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: wedfrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            wedfrom = newValue!;

                                                            wednesdayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (wednesdayvalue !=
                                                                "Closed") {
                                                              wedcheck = false;
                                                            }
                                                            if (wedfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                wedto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.wedcheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: wedto,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            wedto = newValue!;

                                                            wednesdayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (wednesdayvalue2 !=
                                                                "Closed") {
                                                              wedcheck = false;
                                                            }
                                                            if (wedfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                wedto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.wedcheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.wedcheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.wedcheck = value!;
                                                        if (wedcheck == true) {
                                                          wedfrom =
                                                              timingList[49];
                                                          wedto =
                                                              timingList[49];
                                                        } else {
                                                          wedfrom =
                                                              timingList[0];
                                                          wedto = timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (wedfrom == null ||
                                              wedto == null) {
                                            return 'Wednesday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Thursday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: thurfrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            thurfrom =
                                                                newValue!;

                                                            thursdayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (thursdayvalue !=
                                                                "Closed") {
                                                              thurcheck = false;
                                                            }
                                                            if (thurfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                thurto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.thurcheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 0,
                                                    ),
                                                    child: Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              1.5,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              9.5,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(3.0),
                                                        border: Border.all(
                                                          color: Colors.grey,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: ButtonTheme(
                                                        alignedDropdown: true,
                                                        child:
                                                            DropdownButtonFormField(
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            contentPadding:
                                                                EdgeInsets.only(
                                                              left: 0,
                                                              right: 8.0,
                                                              top: 8.0,
                                                              bottom: 8.0,
                                                            ),
                                                          ),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(
                                                            Radius.circular(
                                                              5,
                                                            ),
                                                          ),
                                                          dropdownColor:
                                                              MyColors.grey_3,
                                                          menuMaxHeight:
                                                              MediaQuery.of(
                                                                    context,
                                                                  )
                                                                      .size
                                                                      .height *
                                                                  0.50,
                                                          hint: Text(
                                                            "Select",
                                                            style: TextStyle(
                                                              letterSpacing:
                                                                  0.2,
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 13.0 *
                                                                  MediaQuery.of(
                                                                    context,
                                                                  ).textScaleFactor,
                                                            ),
                                                          ),
                                                          isExpanded: true,
                                                          value: thurto,
                                                          items: timingList.map<
                                                                  DropdownMenuItem<
                                                                      Timings>>(
                                                              (Timings value) {
                                                            return DropdownMenuItem<
                                                                Timings>(
                                                              value: value,
                                                              child: Text(
                                                                value.timing!,
                                                              ),
                                                            );
                                                          }).toList(),
                                                          onChanged: (
                                                            Timings? newValue,
                                                          ) {
                                                            setState(() {
                                                              thurto =
                                                                  newValue!;

                                                              thursdayvalue2 =
                                                                  newValue
                                                                      .timing!;
                                                              if (thursdayvalue2 !=
                                                                  "Closed") {
                                                                thurcheck =
                                                                    false;
                                                              }
                                                              if (thurfrom ==
                                                                      timingList[
                                                                          10] &&
                                                                  thurto ==
                                                                      timingList[
                                                                          10]) {
                                                                setState(() {
                                                                  this.thurcheck =
                                                                      true;
                                                                });
                                                              }
                                                            });
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.thurcheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.thurcheck = value!;
                                                        if (thurcheck == true) {
                                                          thurfrom =
                                                              timingList[49];
                                                          thurto =
                                                              timingList[49];
                                                        } else {
                                                          thurfrom =
                                                              timingList[0];
                                                          thurto =
                                                              timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (thurfrom == null ||
                                              thurto == null) {
                                            return 'Thursday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Friday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: frifrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            frifrom = newValue!;

                                                            fridayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (fridayvalue !=
                                                                "Closed") {
                                                              fricheck = false;
                                                            }
                                                            if (frifrom ==
                                                                    timingList[
                                                                        10] &&
                                                                frito ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.fricheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: frito,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            frito = newValue!;

                                                            fridayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (fridayvalue2 !=
                                                                "Closed") {
                                                              fricheck = false;
                                                            }
                                                            if (frifrom ==
                                                                    timingList[
                                                                        10] &&
                                                                frito ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.fricheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.fricheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.fricheck = value!;
                                                        if (fricheck == true) {
                                                          frifrom =
                                                              timingList[49];
                                                          frito =
                                                              timingList[49];
                                                        } else {
                                                          frifrom =
                                                              timingList[0];
                                                          frito = timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (frifrom == null ||
                                              frito == null) {
                                            return 'Friday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Saturday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: satfrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            satfrom = newValue!;

                                                            saturdayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (saturdayvalue !=
                                                                "Closed") {
                                                              satcheck = false;
                                                            }
                                                            if (satfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                satto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.satcheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: satto,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            satto = newValue!;

                                                            saturdayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (saturdayvalue2 !=
                                                                "Closed") {
                                                              satcheck = false;
                                                            }
                                                            if (satfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                satto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.satcheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.satcheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.satcheck = value!;
                                                        if (satcheck == true) {
                                                          satfrom =
                                                              timingList[49];
                                                          satto =
                                                              timingList[49];
                                                        } else {
                                                          satfrom =
                                                              timingList[0];
                                                          satto = timingList[0];
                                                        }
                                                        // Future.delayed(Duration(seconds: 3),
                                                        //     () {
                                                        //   if (sunfrom != "Closed" ||
                                                        //       sunto != "Closed") {
                                                        //     suncheck = false;
                                                        //   }
                                                        // });
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(context)
                                                              .textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (satfrom == null ||
                                              satto == null) {
                                            return 'Saturday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              ContentHeaderWidget(
                                                title: "Sunday",
                                                mustShow: true,
                                                colorvalue: MyColors.grey,
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "From",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 12.5,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: sunfrom,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            sunfrom = newValue!;

                                                            sundayvalue =
                                                                newValue
                                                                    .timing!;
                                                            if (sundayvalue !=
                                                                "Closed") {
                                                              suncheck = false;
                                                            }
                                                            if (sunfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                sunto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.suncheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      left: 7,
                                                    ),
                                                    child: SizedBox(
                                                      width: 60,
                                                      child:
                                                          ContentHeaderWidget(
                                                        title: "To",
                                                        mustShow: false,
                                                        colorvalue:
                                                            MyColors.grey,
                                                      ),
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: MediaQuery.of(context)
                                                  //           .size
                                                  //           .width /
                                                  //       10,
                                                  // ),
                                                  Container(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            1.5,
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            9.5,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        3.0,
                                                      ),
                                                      border: Border.all(
                                                        color: Colors.grey,
                                                        width: 1,
                                                      ),
                                                    ),
                                                    child: ButtonTheme(
                                                      alignedDropdown: true,
                                                      child:
                                                          DropdownButtonFormField(
                                                        decoration:
                                                            const InputDecoration(
                                                          border:
                                                              OutlineInputBorder(),
                                                          contentPadding:
                                                              EdgeInsets.only(
                                                            left: 0,
                                                            right: 8.0,
                                                            top: 8.0,
                                                            bottom: 8.0,
                                                          ),
                                                        ),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .all(
                                                          Radius.circular(
                                                            5,
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            MyColors.grey_3,
                                                        menuMaxHeight:
                                                            MediaQuery.of(
                                                                  context,
                                                                ).size.height *
                                                                0.50,
                                                        hint: Text(
                                                          "Select",
                                                          style: TextStyle(
                                                            letterSpacing: 0.2,
                                                            color: Colors.black,
                                                            fontSize: 13.0 *
                                                                MediaQuery.of(
                                                                  context,
                                                                ).textScaleFactor,
                                                          ),
                                                        ),
                                                        isExpanded: true,
                                                        value: sunto,
                                                        items: timingList.map<
                                                                DropdownMenuItem<
                                                                    Timings>>(
                                                            (Timings value) {
                                                          return DropdownMenuItem<
                                                              Timings>(
                                                            value: value,
                                                            child: Text(
                                                              value.timing!,
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (
                                                          Timings? newValue,
                                                        ) {
                                                          setState(() {
                                                            sunto = newValue!;

                                                            sundayvalue2 =
                                                                newValue
                                                                    .timing!;
                                                            if (sundayvalue2 !=
                                                                "Closed") {
                                                              suncheck = false;
                                                            }
                                                            if (sunfrom ==
                                                                    timingList[
                                                                        10] &&
                                                                sunto ==
                                                                    timingList[
                                                                        10]) {
                                                              setState(() {
                                                                this.suncheck =
                                                                    true;
                                                              });
                                                            }
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Checkbox(
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                        2,
                                                      ),
                                                    ),
                                                    materialTapTargetSize:
                                                        MaterialTapTargetSize
                                                            .shrinkWrap,
                                                    checkColor: Colors.white,
                                                    activeColor: MyColors.blue,
                                                    value: this.suncheck,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        this.suncheck = value!;
                                                        if (suncheck == true) {
                                                          sunfrom =
                                                              timingList[49];
                                                          sunto =
                                                              timingList[49];
                                                        } else {
                                                          sunfrom =
                                                              timingList[0];
                                                          sunto = timingList[0];
                                                        }
                                                      });
                                                    },
                                                  ),
                                                  const SizedBox(
                                                    width: 4,
                                                  ),
                                                  Text(
                                                    "Closed",
                                                    style: TextStyle(
                                                      fontSize: 15 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 14,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (sunfrom == null ||
                                              sunto == null) {
                                            return 'Sunday timing is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        height: 2,
                                      ),
                                      const SizedBox(height: 20),
                                      Text(
                                        "Warehouse Photos:",
                                        style: TextStyle(
                                          fontSize: 15 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Yard Photos",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              setState(() async {
                                                await CommonFilePicker()
                                                    .pickAFile(
                                                  FileType.image,
                                                  true,
                                                  [],
                                                ).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      value.files
                                                          .forEach((element) {
                                                        yardnames.add(
                                                          element.name,
                                                        );
                                                      });
                                                      value.files
                                                          .forEach((element) {
                                                        yardpics.add(
                                                          element.path!,
                                                        );
                                                      });
                                                    });
                                                  }
                                                });
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              yardnames.isEmpty
                                                  ? "No file chosen"
                                                  : "$yardnames",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: " Gate Photos",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              await CommonFilePicker()
                                                  .pickAFile(
                                                FileType.image,
                                                true,
                                                [],
                                              ).then((value) {
                                                if (value != null) {
                                                  setState(() {
                                                    value.files
                                                        .forEach((element) {
                                                      gatenames.add(
                                                        element.name,
                                                      );
                                                    });
                                                    value.files
                                                        .forEach((element) {
                                                      gatepics.add(
                                                        element.path!,
                                                      );
                                                    });
                                                  });
                                                }
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              gatenames.isEmpty
                                                  ? "No file chosen"
                                                  : "$gatenames",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Docking Area",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              setState(() async {
                                                await CommonFilePicker()
                                                    .pickAFile(
                                                  FileType.image,
                                                  true,
                                                  [],
                                                ).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      value.files
                                                          .forEach((element) {
                                                        dockingnames.add(
                                                          element.name,
                                                        );
                                                      });
                                                      value.files
                                                          .forEach((element) {
                                                        dockingpic.add(
                                                          element.path!,
                                                        );
                                                      });
                                                    });
                                                  }
                                                });
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              dockingnames.isEmpty
                                                  ? "No file chosen"
                                                  : "$dockingnames",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title:
                                            "Inside Warehouse and Equipments",
                                        mustShow: false,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () async {
                                              setState(() async {
                                                await CommonFilePicker()
                                                    .pickAFile(
                                                  FileType.image,
                                                  true,
                                                  [],
                                                ).then((value) {
                                                  if (value != null) {
                                                    setState(() {
                                                      value.files
                                                          .forEach((element) {
                                                        equipmentsnames.add(
                                                          element.name,
                                                        );
                                                      });
                                                      value.files
                                                          .forEach((element) {
                                                        equipmentspic.add(
                                                          element.path!,
                                                        );
                                                      });
                                                    });
                                                  }
                                                });
                                              });
                                            },
                                            icon: const Icon(
                                              Icons.file_copy,
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              equipmentsnames.isEmpty
                                                  ? "No file chosen"
                                                  : "$equipmentsnames",
                                              style: TextStyle(
                                                fontSize: 14 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      const Divider(
                                        height: 2,
                                      ),
                                      const SizedBox(height: 20),
                                      ContentHeaderWidget(
                                        title: "Location",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      FormField<bool>(
                                        builder: (state) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TypeAheadField(
                                                // key: cityKey3,
                                                controller: Citiescontroller,
                                                suggestionsCallback: (search) {
                                                  return cityList!
                                                      .where(
                                                        (item) => item
                                                            .toLowerCase()
                                                            .contains(
                                                              search
                                                                  .toLowerCase(),
                                                            ),
                                                      )
                                                      .toList();
                                                },
                                                builder: (
                                                  context,
                                                  controller,
                                                  focusNode,
                                                ) {
                                                  return TextField(
                                                    controller: controller,
                                                    focusNode: focusNode,
                                                    autofocus: false,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                        left: 15.0,
                                                        right: 8.0,
                                                        top: 8.0,
                                                        bottom: 8.0,
                                                      ),
                                                      border:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: MyColors.grey,
                                                          width: 0.7,
                                                        ),
                                                      ),
                                                      focusedBorder:
                                                          const OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                          color: MyColors
                                                              .primaryblue,
                                                          width: 0.7,
                                                        ),
                                                      ),
                                                      hintText: "Select City",
                                                      hintStyle: MyText
                                                              .customHintText13(
                                                        context,
                                                      )!
                                                          .copyWith(
                                                        color: MyColors.grey_5,
                                                      ),
                                                      suffixIcon: InkWell(
                                                        onTap: () {
                                                          selectedCity = '';
                                                          Citiescontroller
                                                              .clear();
                                                        },
                                                        child: const Icon(
                                                          Icons.clear,
                                                          size: 20,
                                                          color:
                                                              MyColors.grey_40,
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
                                                onSelected: (item) {
                                                  setState(() {
                                                    selectedCity = item;
                                                    Citiescontroller.text =
                                                        item;
                                                  });
                                                },
                                              ),
                                              state.errorText == null
                                                  ? Container()
                                                  : Padding(
                                                      padding: EdgeInsets.only(
                                                        left: 12,
                                                        top: 5.0,
                                                      ),
                                                      child: Text(
                                                        state.errorText ?? '',
                                                        style: TextStyle(
                                                          fontSize: 12,
                                                          color:
                                                              Theme.of(context)
                                                                  .errorColor,
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          );
                                        },
//output from validation will be displayed in state.errorText (above)
                                        validator: (value) {
                                          if (selectedCity == null) {
                                            return 'Location is required';
                                          } else {
                                            return null;
                                          }
                                        },
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ContentHeaderWidget(
                                        title: "Latitude",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'),
                                          ),
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.]'),
                                          ),
                                        ],
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.latitudeReq ?? 'Latitude is required'}'
                                                .tr;
                                          }
                                        },
                                        controller: latitudeTController,
                                        hintText: "Enter Latitude",
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      ContentHeaderWidget(
                                        title: "Longitude",
                                        mustShow: true,
                                        colorvalue: MyColors.grey,
                                      ),
                                      const SizedBox(height: 10),
                                      TextFieldThem.boxBuildTextFieldtheme(
                                        initialValue: null,
                                        textCapitalization:
                                            TextCapitalization.sentences,
                                        textInputAction: TextInputAction.none,
                                        style: const TextStyle(),
                                        strutStyle: const StrutStyle(),
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.start,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        autofocus: false,
                                        readOnly: false,
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
                                        autovalidateMode:
                                            AutovalidateMode.disabled,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.allow(
                                            RegExp(r'(^\d*\.?\d*)'),
                                          ),
                                          FilteringTextInputFormatter.allow(
                                            RegExp('[0-9.]'),
                                          ),
                                        ],
                                        suffixWidget: null,
                                        prefixWidget: null,
                                        decoration: const InputDecoration(),
                                        contentpadding: EdgeInsets.only(
                                          left: 15.0,
                                          right: 8.0,
                                          top: 8.0,
                                          bottom: 8.0,
                                        ),
                                        labelText: '',
                                        border: const OutlineInputBorder(),
                                        keyboardType: TextInputType.number,
                                        validator: (String? value) {
                                          if (value!.isNotEmpty) {
                                            return null;
                                          } else {
                                            return '${Constant.messages.longitudeReq ?? 'Longitude is required'}'
                                                .tr;
                                          }
                                        },
                                        controller: longitudeTController,
                                        hintText: "Enter longitude",
                                        hintStyle:
                                            MyText.customHintText13(context)!
                                                .copyWith(
                                          color: MyColors.grey_5,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  MyColors.primaryblue,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.zero,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              trySubmit();
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
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
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.zero,
                                                ),
                                              ),
                                            ),
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  5,
                                              child: const Text(
                                                "CANCEL",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: MyColors.primaryblue,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 13,
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
      ),
    );
  }
}
