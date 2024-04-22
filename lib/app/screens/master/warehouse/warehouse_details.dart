import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';
import 'package:las_warehouse/app/data/controller/warehouse_controller.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/models/warehouseDetail_model.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/zoom_image.dart';

class WarehouseDetails extends StatefulWidget {
  const WarehouseDetails({
    super.key,
  });

  @override
  State<WarehouseDetails> createState() => WarehouseDetailsState();
}

class WarehouseDetailsState extends State<WarehouseDetails> {
  // String? id;
  // WarehouseDetailsState(this.id);
  Completer<GoogleMapController> _controller = Completer();
  final Map<String, Marker> _markers = {};
  List<Marker> marker1 = [];
//Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  WarehouseDetailsData warehouseDetails = WarehouseDetailsData();
  @override
  void initState() {
    super.initState();
  }

  List<String> amenitiesList = [];

  Widget _buildGoogleMap(BuildContext context, lat, lng) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        compassEnabled: true,
        mapToolbarEnabled: true,
        zoomGesturesEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(lat, lng),
          zoom: 12.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        markers: _markers.values.toSet(),
      ),
    );
  }

  _willPop() {
    Get.back();
  }

  final warehouseController = Get.put(WarehouseController());
  var timings = {};

  @override
  Widget build(BuildContext context) {
    warehouseDetails = warehouseController.warehouseDetailModel.value.message!;
    timings = json.decode(warehouseDetails.workingDays!);
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: Obx(() {
          final marker = Marker(
            markerId: const MarkerId("curr_loc"),
            position: LatLng(
              double.parse(warehouseDetails.latitude!),
              double.parse(warehouseDetails.longitude!),
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed,
            ),
            infoWindow: InfoWindow(title: '${warehouseDetails.warehouseName}'),
          );
          _markers['initial place'] = marker;

          return warehouseController.load.value
              ? LoaderWidget('')
              : SingleChildScrollView(
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.height,
                            child: Card(
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Card(
                                      elevation: 5,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  6,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(13),
                                                child: Image.network(
                                                  '${warehouseDetails.warehouseLogo}',
                                                  height: 90,
                                                  width: 90,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      warehouseDetails.warehouseName!,
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/warehouse.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        const SizedBox(
                                          width: 3,
                                        ),
                                        Text(
                                          '${warehouseDetails.warehouseType}',
                                          style: TextStyle(
                                            fontSize: 13 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/icons/warehouse-area.svg',
                                          width: 20,
                                          height: 20,
                                        ),
                                        Text(
                                          '${warehouseDetails.totalLand!} Sq.ft'
                                              .toString(),
                                          style: TextStyle(
                                            fontSize: 13 *
                                                MediaQuery.of(context)
                                                    .textScaleFactor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Divider(
                                      height: 2,
                                      color: MyColors.grey,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          children: [
                                            Text(
                                              "Storage ",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            Text(
                                              "Charges(₹)",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${warehouseDetails.storageCharges!}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Handling",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            Text(
                                              "Charges(₹)",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${warehouseDetails.handlingCharges!}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Year",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            Text(
                                              "Built",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              warehouseDetails.yearBuilt!
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Built",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            Text(
                                              "-Up",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              textAlign: TextAlign.right,
                                              '${warehouseDetails.builtUp}'
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              "Total",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            Text(
                                              "Land(Sq.ft)",
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              textAlign: TextAlign.right,
                                              '${warehouseDetails.totalLand!}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 13 *
                                                    MediaQuery.of(context)
                                                        .textScaleFactor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    const Divider(
                                      height: 2,
                                      color: MyColors.grey,
                                    ),

                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Amenities",
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: MyColors.grey,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${warehouseDetails.amenities!.replaceAll(',', '\n')}',
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Warehouse Photos",
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Yard Photos',
                                      style: TextStyle(
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                        ),
                                        itemCount:
                                            warehouseDetails.yardPhotos!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ZoomImage(
                                                    warehouseDetails
                                                        .yardPhotos![index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              '${warehouseDetails.yardPhotos![index]}',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Gate Photos',
                                      style: TextStyle(
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                        ),
                                        itemCount:
                                            warehouseDetails.gatePhotos!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ZoomImage(
                                                    warehouseDetails
                                                        .gatePhotos![index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              '${warehouseDetails.gatePhotos![index]}',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Docking Area',
                                      style: TextStyle(
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                        ),
                                        itemCount: warehouseDetails
                                            .dockingArea!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ZoomImage(
                                                    warehouseDetails
                                                        .dockingArea![index],
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              '${warehouseDetails.dockingArea![index]}',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      'Inside Warehouse and Equipments',
                                      style: TextStyle(
                                        fontSize: 15 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: GridView.builder(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                          maxCrossAxisExtent: 200,
                                          childAspectRatio: 3 / 2,
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 20,
                                        ),
                                        itemCount: warehouseDetails
                                            .whEquipmentPhotos!.length,
                                        itemBuilder: (BuildContext ctx, index) {
                                          return InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ZoomImage(
                                                    warehouseDetails
                                                        .whEquipmentPhotos!,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Image.network(
                                              '${warehouseDetails.whEquipmentPhotos![index]}',
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Documents",
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: MyColors.grey,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .leaseRentalAgreement!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Lease / Rental Agreement',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .fireSafetyCertificate!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Fire Safety Certificate',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .buildingPlanApproved!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Building Plan Approval',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .environmentalClearance!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Environmental Clearance',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .insuranceDocument!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text('Insurance Documents'),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .shopLicenseDocument!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Shop License Document',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 11),
                                              InkWell(
                                                onTap: () async {
                                                  await CommonFilePicker
                                                      .launchInBrowser1(
                                                    warehouseDetails
                                                        .labourLicenseDocument!,
                                                  );
                                                },
                                                child: const Row(
                                                  children: [
                                                    Icon(Icons.file_copy),
                                                    Text(
                                                      'Labour License Document',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Open Hours",
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 8,
                                        right: 8,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          border: Border.all(
                                            color: MyColors.grey,
                                          ),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                'Monday : ${timings['Monday']['from']} - ${timings['Monday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Tuesday : ${timings['Tuesday']['from']} - ${timings['Tuesday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Wednesday : ${timings['Wednesday']['from']} - ${timings['Wednesday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Thursday : ${timings['Thursday']['from']} - ${timings['Thursday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Friday : ${timings['Friday']['from']} - ${timings['Friday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Saturday : ${timings['Saturday']['from']} - ${timings['Saturday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                              Text(
                                                'Sunday : ${timings['Sunday']['from']} - ${timings['Sunday']['to']}',
                                              ),
                                              const SizedBox(
                                                height: 6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      "Types of goods they handle",
                                      style: TextStyle(
                                        fontSize: 18 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      child: Text(
                                        '${warehouseDetails.materialTypes}',
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Location",
                                        style: TextStyle(
                                          fontSize: 18 *
                                              MediaQuery.of(context)
                                                  .textScaleFactor,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    //_buildGoogleMap(context, 9.91735, 78.11962),
                                    _buildGoogleMap(
                                      context,
                                      double.parse(
                                        warehouseDetails.latitude!,
                                      ),
                                      double.parse(
                                        warehouseDetails.longitude!,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Center(
                                      child: SizedBox(
                                        width: 100,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: MyColors.grey_60,
                                            shape: const RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.horizontal(),
                                            ),
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons
                                                    .arrow_circle_left_outlined,
                                                size: 18,
                                              ),
                                              const SizedBox(width: 3),
                                              Text(
                                                "Back",
                                                style: TextStyle(
                                                  fontSize: 17 *
                                                      MediaQuery.of(context)
                                                          .textScaleFactor,
                                                ),
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
                      ],
                    ),
                  ),
                );
        }),
      ),
    );
  }
}
