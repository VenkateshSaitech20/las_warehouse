// ignore_for_file: unused_element

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:las_warehouse/app/data/controller/control_tower_controller.dart';
import 'package:las_warehouse/app/data/models/control_tower_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/screens/widgets/appbar.dart';
import 'package:las_warehouse/app/screens/widgets/loader.dart';

class ControlTowerScreen extends StatefulWidget {
  const ControlTowerScreen({super.key});

  @override
  State<ControlTowerScreen> createState() => _ControlTowerScreenState();
}

class _ControlTowerScreenState extends State<ControlTowerScreen> {
  Completer<GoogleMapController> _controller = Completer();
  final controlTowerController = Get.put(ControlTowerController());
  final Map<String, Marker> _markers = {};
  bool load = true;
  List<ControlTower> controlTowerWHList = [];

  @override
  void initState() {
    controlTowerController.getControlTowerWarehouseList();
    // fetchMapData();
    super.initState();
  }

  _willPop() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        backgroundColor: MyColors.grey_1,
        appBar: BaseAppBar(),
        endDrawer: const DrawerMenu(),
        body: RefreshIndicator(
          onRefresh: () async {
            await controlTowerController.getControlTowerWarehouseList();
          },
          child: Obx(
            () {
              controlTowerWHList = controlTowerController.controlTowerWHList;

              return controlTowerController.load.value
                  ? LoaderWidget('')
                  : SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10, left: 0),
                            child: Text(
                              "Control Tower",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    18 * MediaQuery.of(context).textScaleFactor,
                              ),
                            ),
                          ),
                          controlTowerWHList.length > 0
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: controlTowerWHList.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Column(
                                      children: [
                                        SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Card(
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                              side: const BorderSide(
                                                width: 1,
                                                color: Colors.grey,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                left: 0,
                                                right: 0,
                                                top: 0,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color: MyColors.darkblue,
                                                      padding:
                                                          const EdgeInsets.all(
                                                        8,
                                                      ),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  '${controlTowerWHList[index].warehouseName}',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 14 *
                                                                        MediaQuery.of(context)
                                                                            .textScaleFactor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                Text(
                                                                  '(${controlTowerWHList[index].warehouseType})',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize: 14 *
                                                                        MediaQuery.of(context)
                                                                            .textScaleFactor,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                              bottom: 0,
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceEvenly,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Total Land (Sq.Ft)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10 *
                                                                                MediaQuery.of(context).textScaleFactor,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${controlTowerWHList[index].totalLand!}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12 *
                                                                                MediaQuery.of(context).textScaleFactor,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Column(
                                                                  children: [
                                                                    Text(
                                                                      "Builtup  (Sq.Ft)",
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            10 *
                                                                                MediaQuery.of(context).textScaleFactor,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      '${controlTowerWHList[index].builtUp}',
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            12 *
                                                                                MediaQuery.of(context).textScaleFactor,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            height: 5,
                                                          ),
                                                          const Divider(
                                                            color: Colors.white,
                                                            indent: 10,
                                                            endIndent: 10,
                                                          ),
                                                          SizedBox(
                                                            width:
                                                                MediaQuery.of(
                                                              context,
                                                            ).size.width,
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceEvenly,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                          "Occupied  (Sq.Ft)",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                10 * MediaQuery.of(context).textScaleFactor,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          "${controlTowerWHList[index].occupied}",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                12 * MediaQuery.of(context).textScaleFactor,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Column(
                                                                      children: [
                                                                        Text(
                                                                          "Available  (Sq.Ft)",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                10 * MediaQuery.of(context).textScaleFactor,
                                                                          ),
                                                                        ),
                                                                        Text(
                                                                          '${controlTowerWHList[index].availableSpace}',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                12 * MediaQuery.of(context).textScaleFactor,
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                                // const SizedBox(
                                                                //   height: 5,
                                                                // ),
                                                                // const Divider(
                                                                //   color: Colors
                                                                //       .white,
                                                                //   indent:
                                                                //       10,
                                                                //   endIndent:
                                                                //       10,
                                                                // ),
                                                              ],
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
                                      ],
                                    );
                                  },
                                )
                              : SizedBox(
                                  height: MediaQuery.of(context).size.height,
                                  child: Center(
                                    child: Text(
                                      'No more warehouse available.',
                                      style: TextStyle(
                                        // color: Colors.white,
                                        fontSize: 16 *
                                            MediaQuery.of(context)
                                                .textScaleFactor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long, marId) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(lat, long),
          zoom: 16,
          tilt: 50.0,
          bearing: 45.0,
        ),
      ),
    );
  }

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
          zoom: 16.0,
        ),
        onMapCreated: (GoogleMapController controller) {
          // for(int y=0; y <_markers.length; y++){
          // controller.showMarkerInfoWindow(_markers[y].markerId);

          // };
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: true,

        /* padding: EdgeInsets.only(
          top: 60.0,
        ), */

        markers: _markers.values.toSet(),
      ),
    );
  }
}
