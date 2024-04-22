import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/data/controller/connection_manager_controller.dart';
import 'package:las_warehouse/app/data/controller/message_controller.dart';
import 'package:las_warehouse/app/data/controller/profile_controller.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:las_warehouse/app/services/exception_handling_services.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionManagerController extends GetxController {
  String version = '';
  final Uri url = Uri.parse(
    'https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjgp5O_7dOAAxU7jEsFHaa8DsMYABAAGgJzZg&gclid=Cj0KCQjwldKmBhCCARIsAP-0rfx4TcRdgBfMQmkKV269v9R36IofLlcDP4APJ_XupQXq0uJ6iEprH70aAjVOEALw_wcB&ohost=www.google.com&cid=CAESbeD273eAGVQGICIcyNAFr92N_flhDX_YNsRTCh53bb_zb0GSiviLZtE03AITi0SZaBMSOW3s86Mo5wgdPc0N7UEDWdgW2aU3isPxsScrNJd8RqZwG6RFQoJM8WW4RIDPuSwcNLWOx8lzY-35ZBA&sig=AOD64_24rF4xiW1U7pF0mgXNKsGrQ5BH7A&q&adurl&ved=2ahUKEwjB04y_7dOAAxVmxjgGHW7yDlkQ0Qx6BAgGEAE',
  );

  bool load = false;

  SharedPreferences? prefs;
  User? userData = User();

  @override
  void onInit() {
    super.onInit();
    getInterNetStatus();
  }

  callAgainGetInterNetStatus() async {
    await Future.delayed(const Duration(seconds: 1))
        .then((value) => getInterNetStatus());
  }

  getInterNetStatus() {
    if (Get.put(ConnectionManagerController()).connectionStatus.value == 1) {
      appversionCheckfn();
    } else {
      callAgainGetInterNetStatus();
    }
  }

  void appversionCheckfn() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;
    print('appName $appName');
    print('packageName$packageName');
    print('version $version');
    print('buildNumber $buildNumber');
    await Get.put(MessageController()).commonMessageAPI().then((value) async {
      // if (Get.put(MessageController()).messages.value != null) {
      Constant.appVersion = Constant.messages.tmsVersion!;
      // Constant.appVersion = '2.0.0';
      print('inside ${Constant.appVersion}');

      // print('message version ${Constant.messages.version! ?? 'null'}');

      if (Constant.appVersion != '0.0.0' && Constant.appVersion != version) {
        urlLaunchingfn();
      } else if (Preferences.getBoolean(Preferences.isLogin)) {
        getLoadExistControllerData();
      } else {
        Get.offNamed('/auth');
      }
      // }
    });
  }

  urlLaunchingfn() {
    launchUrl(url).then(
      (value) => {},
      onError: (e) {
        throw Exception('Could not launch $url');
      },
    );
  }

  getLoadExistControllerData() async {
    if (Get.find<ConnectionManagerController>().connectionStatus.value == 1) {
      prefs = await SharedPreferences.getInstance();

      String token = await Preferences.getString(Preferences.accesstoken);
      if (token != "") {
        bool hasExpired = JwtDecoder.isExpired(token);

        if (hasExpired) {
          ApiExceptionService().handleSessionExpire();
        } else {
          if (prefs!.containsKey('userdata')) {
            userData = await Preferences.loadSharedPrefs();
            if (userData != null) {
              await Get.put(ProfileController()).getProfileDataAPI().then(
                    (value) => {
                      if (value!.result == true)
                        {Get.offAndToNamed('/dashboard')},
                    },
                  );
            }
          }
        }
      }
    }
  }
}
