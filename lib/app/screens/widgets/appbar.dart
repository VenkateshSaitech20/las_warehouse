// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/my_colors.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// you can add more fields that meet your needs

  @override
  Widget build(BuildContext context) {
    //Get.find<ProfileController>().load.value ? CircularProgressIndicator():
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: MyColors.primaryblue,
      title: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: Image.asset(Constant.logo2),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
            onTap: () => Scaffold.of(context).openEndDrawer(),
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.height / 45,
              backgroundColor: MyColors.primaryblue,
              child: CircleAvatar(
                radius: MediaQuery.of(context).size.height / 48,
                backgroundImage: NetworkImage('${Constant.userData.logo}'),
                //backgroundImage: AssetImage("assets/profile.jpg"),
              ),
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(6.0),
        child: SizedBox(
          height: 6.0,
          width: MediaQuery.of(context).size.width,
          child: SvgPicture.asset(
            'assets/icons/bosch_border.svg',
            height: 6.0,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );

    // endDrawer: DrawerMenu(),;
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
