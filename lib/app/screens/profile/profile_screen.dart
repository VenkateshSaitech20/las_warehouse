// ignore_for_file: sized_box_for_whitespace, deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/screens/widgets/common_file_picker.dart';
import 'package:las_warehouse/app/screens/drawer/drawer.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/data/my_text.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';

class Profilepage extends StatefulWidget {
  const Profilepage({super.key});

  @override
  ProfilepageState createState() => ProfilepageState();
}

class ProfilepageState extends State<Profilepage> {
  User userProfileData = User();

  String? fname = "nothing";
  _willPop() {
    Get.back();
  }

  @override
  void initState() {
    userProfileData = Constant.userData;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _willPop(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: MyColors.primaryblue,
          title: Container(width: 120, child: Image.asset(Constant.logo2)),
          actions: [
            Builder(
              builder: (context) => Padding(
                padding: const EdgeInsets.only(right: 10),
                child: InkWell(
                  onTap: () => Scaffold.of(context).openEndDrawer(),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: MyColors.primaryblue,
                    child: CircleAvatar(
                      radius: 14,
                      backgroundImage: NetworkImage(userProfileData.logo!),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        endDrawer: const DrawerMenu(),
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: MyColors.primaryblue,
                automaticallyImplyLeading: false,
                expandedHeight: 200.0,
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.dark,
                ),
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background:
                      Image.asset('assets/bg_polygon.png', fit: BoxFit.cover),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Get.toNamed('/editprofile');
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => const EditProfilePage()),
                      // );
                    },
                    icon: SvgPicture.asset(
                      'assets/icons/edit.svg',
                      width: 25,
                      height: 25,
                      color: Colors.white,
                    ),
                  ),
                ],
                bottom: PreferredSize(
                  preferredSize: const Size.fromHeight(50),
                  child: Container(
                    transform: Matrix4.translationValues(0, 50, 0),
                    child: CircleAvatar(
                      radius: 48,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: NetworkImage(
                          userProfileData.logo!,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: <Widget>[
                  Container(height: 70),
                  Text(
                    '${userProfileData.vendorName ?? ''}',
                    style: MyText.headline(context)!.copyWith(
                      color: Colors.grey[900],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(height: 15),
                  const Divider(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "GST Number",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.gstNo ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "PAN Number",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.panNo ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Aadhar Number",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.aadharNo ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Cin Number",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.cinNo ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Email address",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        '${userProfileData.email ?? ''}',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Phone No",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.phone ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Address line 1",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.address1 ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Address line 2",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.address2 ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Area Pin code",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.pincode ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Country",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.country ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "State",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        userProfileData.state ?? '',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "City",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      Text(
                        '${userProfileData.city ?? ''}',
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.grey_5,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "GST",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      userProfileData.gstFile != null
                          ? OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                              ),
                              label: Text(
                                "${File(userProfileData.gstFile!).path.split("/").last}",
                                style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.grey_5,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              onPressed: () async {
                                await CommonFilePicker.launchInBrowser1(
                                  userProfileData.gstFile!,
                                );
                              },
                              icon: const Icon(
                                Icons.file_copy,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "PAN Card",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      userProfileData.panFile != null
                          ? OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                              ),
                              label: Text(
                                "${File(userProfileData.panFile!).path.split("/").last}",
                                style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.grey_5,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              onPressed: () async {
                                await CommonFilePicker.launchInBrowser1(
                                  userProfileData.panFile!,
                                );
                              },
                              icon: const Icon(
                                Icons.file_copy,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Aadhar Card",
                        style: MyText.subhead(context)!.copyWith(
                          color: MyColors.primaryblue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(height: 5),
                      userProfileData.aadharFile != null
                          ? OutlinedButton.icon(
                              style: OutlinedButton.styleFrom(
                                side: BorderSide.none,
                              ),
                              label: Text(
                                "${File(userProfileData.aadharFile!).path.split("/").last}",
                                style: MyText.subhead(context)!.copyWith(
                                  color: MyColors.grey_5,
                                  letterSpacing: 1.0,
                                ),
                              ),
                              onPressed: () async {
                                await CommonFilePicker.launchInBrowser1(
                                  userProfileData.aadharFile!,
                                );
                              },
                              icon: const Icon(
                                Icons.file_copy,
                              ),
                            )
                          : Container(),
                    ],
                  ),
                  Container(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
