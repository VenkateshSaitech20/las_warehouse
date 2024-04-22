import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/master_controller.dart';
import 'package:las_warehouse/app/data/controller/termsnconditions_controller.dart';
import 'package:las_warehouse/app/data/models/payment_type_model.dart';
import 'package:las_warehouse/app/data/models/termsnConditions_model.dart';
import 'package:las_warehouse/app/data/controller/order_bidding_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/available_warehouse_Model.dart';
import 'package:las_warehouse/app/data/models/orderbidding_details_model.dart';
import 'package:las_warehouse/app/screens/widgets/build_text_form_field.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/themes/content_header.dart';

class CustomerRequirements extends StatefulWidget {
  const CustomerRequirements({super.key});

  @override
  State<CustomerRequirements> createState() => _CustomerrequirementsState();
}

class _CustomerrequirementsState extends State<CustomerRequirements> {
  OrderBiddingDetailsData bidDetails = OrderBiddingDetailsData();
  final orderbiddingcontroller = Get.put(OrderBiddingController());
  final masterController = Get.put(MasterController());
  final termsnConditionsController = Get.put(TermsnConditionsController());
  TextEditingController bidPriceTController = TextEditingController();
  TextEditingController termsTController = TextEditingController();
  TextEditingController advancePercentController = TextEditingController();
  String? whId;
  List<AvailableWarehouseName> warehouseList = [];
  List<MaterialTypeData> materialTypeList = [];
  AvailableWarehouseName? selectedWareHouse;
  HtmlEditorController controller = HtmlEditorController();
  TermsDetails termsDetails = TermsDetails();
  List<PaymentType> paymentListTypes = [];
  PaymentType? selectedPaymentType;
  final GlobalKey<FormState> _bidConfirmFormKey = GlobalKey<FormState>();

  @override
  void initState() {
    advancePercentController.text = '100';
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    bidDetails = orderbiddingcontroller.orderBiddingDetailModel.message!;
    warehouseList = Get.find<OrderBiddingController>().avaibleWarehouseNames;
    termsDetails = termsnConditionsController.termsDetails.value;
    materialTypeList = orderbiddingcontroller.materialTypeList;
    paymentListTypes = masterController.paymentTypesList;
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 15),
            child: SafeArea(
              child: Form(
                key: _bidConfirmFormKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  children: [
                    Text(
                      "Requirement Details",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                    Text(
                      "${bidDetails.customer!.cusName}",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.height,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: const BorderSide(width: 1, color: Colors.grey),
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
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Booking Type",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "${bidDetails.bookingType}",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      //color: MyColors.grey_1,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Requirement Type",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            "${bidDetails.requirementType}",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              bidDetails.requirementType == 'Normal'
                                  ? Container()
                                  : SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Column(
                                              children: [
                                                Text(
                                                  "Recurring Type",
                                                  textAlign: TextAlign.center,
                                                  style: MyText.customText14(
                                                    context,
                                                  )!
                                                      .copyWith(
                                                    color: MyColors.darkblue,
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0,
                                                  ),
                                                ),
                                                const SizedBox(height: 6),
                                                Text(
                                                  "${bidDetails.recurringType}",
                                                  textAlign: TextAlign.center,
                                                  style: MyText.customText14(
                                                    context,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          bidDetails.recurringType == 'Weekly'
                                              ? SizedBox(
                                                  //color: MyColors.grey_1,
                                                  width: MediaQuery.of(
                                                        context,
                                                      ).size.width /
                                                      2.5,
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        "Weekly Type",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            MyText.customText14(
                                                          context,
                                                        )!
                                                                .copyWith(
                                                          color:
                                                              MyColors.darkblue,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 6,
                                                      ),
                                                      Text(
                                                        "${bidDetails.weeklyType}"
                                                            .replaceAll(
                                                          ',',
                                                          ',  ',
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style:
                                                            MyText.customText14(
                                                          context,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              : bidDetails.recurringType ==
                                                      'Monthly'
                                                  ? SizedBox(
                                                      //color: MyColors.grey_1,
                                                      width: MediaQuery.of(
                                                            context,
                                                          ).size.width /
                                                          2.5,
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Monthly Type",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: MyText
                                                                    .customText14(
                                                              context,
                                                            )!
                                                                .copyWith(
                                                              color: MyColors
                                                                  .darkblue,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                              letterSpacing: 0,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 6,
                                                          ),
                                                          Text(
                                                            "${bidDetails.monthlyType} ${bidDetails.monthlyDay}",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: MyText
                                                                .customText14(
                                                              context,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                        ],
                                      ),
                                    ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "From Date",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/calender.svg',
                                                width: 18,
                                                height: 18,
                                                // ignore: deprecated_member_use
                                                color: MyColors.grey,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "${bidDetails.fromDateTime}",
                                                  textAlign: TextAlign.center,
                                                  style: MyText.customText14(
                                                    context,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      //color: MyColors.grey_1,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "To Date",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              SvgPicture.asset(
                                                'assets/icons/calender.svg',
                                                width: 18,
                                                height: 18,
                                                // ignore: deprecated_member_use
                                                color: MyColors.grey,
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    3,
                                                child: Text(
                                                  "${bidDetails.toDateTime}",
                                                  textAlign: TextAlign.center,
                                                  style: MyText.customText14(
                                                    context,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              bidDetails.recurringDates != null &&
                                      bidDetails.recurringDates != ''
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        const SizedBox(height: 10),
                                        Text(
                                          "Recurring Dates",
                                          style: MyText.customText14(
                                            context,
                                          )!
                                              .copyWith(
                                            color: MyColors.darkblue,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0,
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Wrap(
                                          children: [
                                            Text(
                                              bidDetails.recurringDates!
                                                  .replaceAll(
                                                ',',
                                                ',  ',
                                              ),
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                              style: MyText.customText14(
                                                context,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(height: 10),
                              Text(
                                "City",
                                style: MyText.customText14(context)!.copyWith(
                                  color: MyColors.darkblue,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/icons/locator.svg',
                                    width: 20,
                                    height: 20,
                                    // ignore: deprecated_member_use
                                    color: MyColors.grey,
                                  ),
                                  Text(
                                    bidDetails.city!,
                                    style: TextStyle(
                                      fontSize: 14 *
                                          MediaQuery.of(context)
                                              .textScaleFactor,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Preferred Location",
                                textAlign: TextAlign.center,
                                style: MyText.customText14(context)!.copyWith(
                                  color: MyColors.darkblue,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // SvgPicture.asset(
                                  //   'assets/icons/locator.svg',
                                  //   width: 20,
                                  //   height: 20,
                                  //   // ignore: deprecated_member_use
                                  //   color: MyColors.grey,
                                  // ),
                                  Flexible(
                                    child: Text(
                                      bidDetails.preferredLocation!,
                                      softWrap: true,
                                      textAlign: TextAlign.center,
                                      style: MyText.customText14(context),
                                    ),
                                  ),
                                ],
                              ),
                              ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: materialTypeList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      const Divider(
                                        height: 2,
                                        color: Colors.black,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  2.5,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Material Type",
                                                    textAlign: TextAlign.center,
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].materialType!}',
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: MyColors.grey_100_,
                                                      fontSize: 14 *
                                                          MediaQuery.of(
                                                            context,
                                                          ).textScaleFactor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              //color: MyColors.grey_1,
                                              width: MediaQuery.of(
                                                    context,
                                                  ).size.width /
                                                  2.5,
                                              child: Column(
                                                children: [
                                                  Text(
                                                    "Packaging Type",
                                                    textAlign: TextAlign.center,
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].packagingType!}',
                                                    textAlign: TextAlign.center,
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),

                                      Container(
                                        color: MyColors.background_grey,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                            left: 4,
                                            right: 4,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "Length",
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].length!.toString()}',
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Width",
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].width.toString()}',
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Height",
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].height.toString()}',
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Weight",
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].weight.toString()}',
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "Quantity",
                                                    textAlign: TextAlign.center,
                                                    style: MyText.customText14(
                                                      context,
                                                    )!
                                                        .copyWith(
                                                      color: MyColors.darkblue,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      letterSpacing: 0,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Text(
                                                    '${materialTypeList[index].quantity!}',
                                                    textAlign: TextAlign.center,
                                                    style: MyText.customText14(
                                                      context,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      // Divider(
                                      //   height: 2,
                                      //   color: Colors.black,
                                      // ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              const Divider(
                                height: 2,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Consignment Type",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.consignmentType}',
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      //color: MyColors.grey_1,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Consignment Loading Type",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.consignmentLoadingType}',
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Warehouse Type Required",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.availableWarehouseType}',
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      //color: MyColors.grey_1,
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Column(
                                        children: [
                                          Text(
                                            "Sq.ft Required",
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.reqSqft!}',
                                            textAlign: TextAlign.center,
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: MyColors.background_grey,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 8,
                                    bottom: 8,
                                    left: 4,
                                    right: 4,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const SizedBox(width: 10),
                                      Column(
                                        children: [
                                          Text(
                                            "Total Wt.(${bidDetails.weightType})",
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.totalWeight.toString()}',
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            "Total Qty",
                                            style: MyText.customText14(
                                              context,
                                            )!
                                                .copyWith(
                                              color: MyColors.darkblue,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0,
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                          Text(
                                            '${bidDetails.totalQuantity.toString()}',
                                            style: MyText.customText14(
                                              context,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(width: 10),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Description",
                                style: MyText.customText14(context)!.copyWith(
                                  color: MyColors.darkblue,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${bidDetails.itemDescription!}',
                                style: MyText.customText14(context),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              ContentHeaderWidget(
                                title: "Bidding Price (INR)",
                                mustShow: true,
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
                                textAlignVertical: TextAlignVertical.center,
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
                                    AutovalidateMode.onUserInteraction,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp('[0-9]'),
                                  ),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                suffixWidget: null,
                                prefixWidget: null,
                                decoration: const InputDecoration(),
                                contentpadding: const EdgeInsets.only(left: 15),
                                labelText: '',
                                border: const OutlineInputBorder(),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return Constant.messages.bidPriceReq ??
                                        'Bidding price required';
                                  }
                                  if (value.startsWith('.')) {
                                    return Constant.messages.bidPriceReq ??
                                        'Numeric value required';
                                  }
                                  if (int.parse(value) <= 0) {
                                    return 'Enter valid price';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                hintText: "Enter Bidding Price",
                                controller: bidPriceTController,
                                hintStyle:
                                    MyText.customText15(context)!.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ContentHeaderWidget(
                                    title: "Payment Options",
                                    mustShow: true,
                                  ),
                                  // SizedBox(height: 10),

                                  const SizedBox(
                                    height: 10.0,
                                  ),
                                  ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: paymentListTypes.length,
                                    itemBuilder: (
                                      BuildContext context,
                                      int index,
                                    ) {
                                      return InkWell(
                                        onTap: () {
                                          setState(() {
                                            advancePercentController.text =
                                                '100';
                                            selectedPaymentType =
                                                paymentListTypes[index];
                                          });
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(
                                            5.0,
                                          ),
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  decoration: BoxDecoration(
                                                    color: selectedPaymentType ==
                                                            paymentListTypes[
                                                                index]
                                                        ? MyColors.primaryred
                                                        : Colors.white,
                                                    border: Border.all(
                                                      color: MyColors.darkblue,
                                                    ),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  height: 15.0,
                                                  width: 15.0,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5.0,
                                              ),
                                              Text(
                                                '${paymentListTypes[index].paymentType}',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 15 *
                                                      MediaQuery.of(
                                                        context,
                                                      ).textScaleFactor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              selectedPaymentType?.paymentType ==
                                      "Advance Payment"
                                  ? Column(
                                      children: [
                                        ContentHeaderWidget(
                                          title: "Advance Payment (%)",
                                          mustShow: true,
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
                                          autovalidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          inputFormatters: [
                                            FilteringTextInputFormatter.allow(
                                              RegExp(
                                                '[0-9.]',
                                              ),
                                            ),
                                            FilteringTextInputFormatter
                                                .digitsOnly,
                                          ],
                                          suffixWidget: null,
                                          prefixWidget: null,
                                          decoration: const InputDecoration(),
                                          contentpadding: const EdgeInsets.all(
                                            8,
                                          ),
                                          labelText: '',
                                          border: const OutlineInputBorder(),
                                          validator: (String? value) {
                                            if (value!.startsWith('.')) {
                                              advancePercentController.text =
                                                  "100";
                                              return 'Numeric value required';
                                            }
                                            if (selectedPaymentType
                                                        ?.paymentType ==
                                                    "Advance Payment" &&
                                                value.isEmpty) {
                                              return 'Percentage Required';
                                            } else if (double.parse(
                                                  value,
                                                ) >
                                                100.0) {
                                              advancePercentController.text =
                                                  "100";
                                              return 'Invalid Percentage Required';
                                            }

                                            return null;
                                          },
                                          keyboardType: TextInputType.number,
                                          hintText: "Advance Payment (%)",
                                          controller: advancePercentController,
                                          hintStyle:
                                              MyText.customText15(context)!
                                                  .copyWith(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    )
                                  : Container(),
                              ContentHeaderWidget(
                                title: "Select WareHouse",
                                mustShow: true,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                child: ButtonTheme(
                                  alignedDropdown: true,
                                  child: DropdownButtonFormField(
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.only(
                                        left: 0,
                                        right: 8.0,
                                        top: 8.0,
                                        bottom: 8.0,
                                      ),
                                    ),
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    hint: Text(
                                      "Select Warehouse",
                                      style: MyText.customText15(context)!
                                          .copyWith(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    // underline: SizedBox(),
                                    //isDense: true,
                                    isExpanded: true,

                                    value: selectedWareHouse,
                                    // items: dropdownItems,
                                    items: warehouseList.map<
                                            DropdownMenuItem<
                                                AvailableWarehouseName>>(
                                        (AvailableWarehouseName? value) {
                                      return DropdownMenuItem<
                                          AvailableWarehouseName>(
                                        value: value,
                                        child: Text(
                                          '${value!.warehouseName!} , ' +
                                              '${value.cityLocation!}',
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (
                                      AvailableWarehouseName? newValue,
                                    ) {
                                      setState(() {
                                        selectedWareHouse = newValue!;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null) {
                                        return Constant
                                                .messages.warehouseTReq ??
                                            'Select warehouse';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Terms and Conditions",
                                style: TextStyle(
                                  fontSize: 14 *
                                      MediaQuery.of(context).textScaleFactor,
                                  color: Colors.black,
                                  //fontWeight: FontWeight.bold
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height:
                                    MediaQuery.of(context).size.height / 2.2,
                                color: Colors.white,
                                child: HtmlEditor(
                                  htmlToolbarOptions: const HtmlToolbarOptions(
                                    toolbarType: ToolbarType.nativeExpandable,
                                    toolbarPosition:
                                        ToolbarPosition.aboveEditor,
                                    buttonBorderWidth: 1.2,
                                    renderBorder: true,
                                    initiallyExpanded: false,
                                    // renderSeparatorWidget: false,
                                    toolbarItemHeight: 25,
                                    // gridViewHorizontalSpacing: 8,
                                    // gridViewVerticalSpacing: 3,
                                    //toolbarType: ToolbarType.nativeGrid
                                  ),
                                  otherOptions: OtherOptions(
                                    height: MediaQuery.of(context).size.height /
                                        1.3,
                                  ),
                                  controller: controller,
                                  htmlEditorOptions: HtmlEditorOptions(
                                    shouldEnsureVisible: true,
                                    hint: "Start writing...",
                                    initialText:
                                        "${termsDetails.termsConditions ?? ''}",
                                    // initialText: "You are hereby requested to complete work order under the following terms &Conditions:<br>Proceedings:<br><br> Shifting of material should commence on DD.MM.YYYY.<br>2. Delivery Schedule: Within 48 four hours after receiving work order.<br>3. Equipments: You should be well equipped with all necessary tools & items for the Shifting of Materials. All required materials will be provided by you time to time during transportation. M/s ABCD has no responsibility to provide you any kind of items for the shifting.<br>4. Documentation: You will provide your past experience certificates from renowned organization along with your invoice to us.<br>5. Payment Schedule: We treat your quotation dated DD.MM.YYYY is the full and final quotation value for which 50% advance will be made upon your acceptance of this WO and against your Invoice to us. Balance payment will be released after completion of work. No further claim negotiation will be entertained afterwards. Payment will be made vide Online Transfer/Cheque/DD in favour of M/s XYZ.<br>6. Confidentiality and secrecy: The Contractor commits herself to treat all non-public information confided to her during her professional activities for the shifting with strict confidentiality and her obligation to treat all information in connection with the transportation confidentially and execute the transportation in accordance with good practices. The Contractor will also impose the pledge to secrecy on all third parties involved in the execution of the order. Any and all data relating to the contract as well as any other information of which the contractor becomes aware in the course of performing the contract must be treated as confidential even beyond the term of the contract. The contractor shall not be permitted to make use of any such data and information for the contractor's own purposes.<br>7. Quality of work and services: The work and services to be provided must comply with the recognized state of the art and the generally accepted rules of technology as well as being consistent with the general strategy of the ultimate commissioning party/client. They must be of excellent quality.The work and services and the necessary work results must take into account the local conditions in accordance to the relevant law and order of the State/[country] Govt., the financing possibilities and the general, special and social impacts of the measure.<br>8. Subcontracts: Any subcontracting of work and services by the contractor to third parties shall require the prior written approval of ABCD, unless the contract stipulates that such work or services be procured by the contractor.<br>9. Obligations: The contractor shall at all times act in an impartial and loyal manner. The contractor shall ensure that the staff it employs as well as its subcontractors comply with the provisions of these Terms and Conditions and the con-tract, where applicable.<br>10. Termination: ABCD may terminate the contract at any time either wholly or in respect of individual parts of the work and services or with regard to individual experts.<br>11. Liability: The contractor's contractual liability is limited to [currency] 1,00,000.00. If the total con-tract value exceeds this figure, the contractor's contractual liability shall be limited to the total contract value. This limitation of liability shall not apply in the event of the contractor's intent or gross negligence.   It further does not apply to loss of life, bodily injury or damage to health. ABCD shall be entitled to claim for loss or damage suffered by the recipient of the work and services as a result of non-compliance with the contractor's contractual obligations.<br>12. Working Hours: The working hours of the contractor and assigned expert shall be determined by the ABCD representative on the basis of requirements of the measure and the conditions in the regional aspects of assignment.<br>13. Jurisdiction: The place of jurisdiction will be  [name of city] ",
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.primaryblue,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(),
                        ),
                      ),
                      onPressed: () async {
                        String? textData = await controller.getText();
                        if (_bidConfirmFormKey.currentState!.validate()) {
                          _bidConfirmFormKey.currentState!.save();
                          // print(
                          //     'image path  ${bidDetails.packagingType![0].icon!}');
                          // print('id  ${selectedWareHouse!.id!}');
                          Map<String, dynamic> bodyParams = {
                            'token': await Preferences.getString(
                              Preferences.accesstoken,
                            ),
                            'reqId': bidDetails.id,
                            'bidPrice': bidPriceTController.text,
                            'paymentType': selectedPaymentType!.paymentType,
                            'advancePercent': advancePercentController.text,
                            'termsConditions': textData,
                            'warehouseId': selectedWareHouse!.id!,
                            'mobType': "true",
                          };
                          await orderbiddingcontroller
                              .confirmbidAPI(bodyParams)
                              .then((value) async {
                            if (value != null) {
                              if (value['result'] == true) {
                                Get.toNamed('/pendingorders');
                              }
                            }
                          });
                        }
                      },
                      child: Text(
                        "Confirm Bidding",
                        style: TextStyle(
                          fontSize: 15 * MediaQuery.of(context).textScaleFactor,
                          color: Colors.white,
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
