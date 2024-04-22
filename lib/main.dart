// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:las_warehouse/app/data/bindings/controller_binding.dart';
import 'package:las_warehouse/app/data/constant/constant.dart';
import 'package:las_warehouse/app/routes/app_pages.dart';
import 'package:las_warehouse/app/data/models/user_model.dart';
import 'package:las_warehouse/app/data/my_colors.dart';
import 'package:las_warehouse/app/services/Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase.initializeApp(
//       // options: DefaultFirebaseOptions.currentPlatform,
//       );
// }

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true;
}

void main() async {
  await Future.delayed(Duration(seconds: 0));
  // setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initPref();

  // await Firebase.initializeApp(
  //     // options: DefaultFirebaseOptions.currentPlatform,
  //     );
  // await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
  //   alert: true,
  //   badge: true,
  //   sound: true,
  // );

  // await FirebaseMessaging.instance.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (!Platform.isIOS) {
  //   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // }
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      // systemNavigationBarColor: Colors.blue, // navigation bar color
      statusBarColor: MyColors.primaryblue, // status bar color
    ),
  );
  // WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  SharedPreferences? prefs;
  User? userData = User();
  // final connectionManagerController = Get.put(ConnectionManagerController());
  // final msgcontroller = Get.put(MessageController());

  // final mastercontroller = Get.put(MasterController());
  // final warehousecontroller = Get.put(WarehouseController());
  // final orderbiddingcontroller = Get.put(OrderBiddingController());
  // final pendingController = Get.put(PendingBidsController());
  // final workorderController = Get.put(WorkOrderController());
  // final completedOrderController = Get.put(CompletedOrdersController());

  //final cityController= Get.put(Citiescontroller());
  // Map<String, dynamic> bodyParams1 = {
  //   "token": Preferences.getString(Preferences.accesstoken)
  // };
  // final Uri url = Uri.parse(
  //     'https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwjgp5O_7dOAAxU7jEsFHaa8DsMYABAAGgJzZg&gclid=Cj0KCQjwldKmBhCCARIsAP-0rfx4TcRdgBfMQmkKV269v9R36IofLlcDP4APJ_XupQXq0uJ6iEprH70aAjVOEALw_wcB&ohost=www.google.com&cid=CAESbeD273eAGVQGICIcyNAFr92N_flhDX_YNsRTCh53bb_zb0GSiviLZtE03AITi0SZaBMSOW3s86Mo5wgdPc0N7UEDWdgW2aU3isPxsScrNJd8RqZwG6RFQoJM8WW4RIDPuSwcNLWOx8lzY-35ZBA&sig=AOD64_24rF4xiW1U7pF0mgXNKsGrQ5BH7A&q&adurl&ved=2ahUKEwjB04y_7dOAAxVmxjgGHW7yDlkQ0Qx6BAgGEAE');
  // String version = '';
  // String appVersion = '';
  // MessageModel messages = MessageModel();
  @override
  void initState() {
    // getInterNetStatus();
    super.initState();
  }

  // callAgainGetInterNetStatus() async {
  //   await Future.delayed(const Duration(seconds: 1))
  //       .then((value) => getInterNetStatus());
  // }

  // getInterNetStatus() {
  //   if (Get.put(ConnectionManagerController()).connectionStatus.value == 1) {
  //     appversionCheckfn();
  //   } else {
  //     callAgainGetInterNetStatus();
  //   }
  // }

  // void appversionCheckfn() async {
  //   await msgcontroller.commonMessageAPI().then((value) {
  //     Constant.appVersion = msgcontroller.messages.value.wbsVersion!;
  //   });

  //   Future.delayed(Duration(seconds: 2), () async {
  //     final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  //     String appName = packageInfo.appName;
  //     String packageName = packageInfo.packageName;
  //     version = packageInfo.version;
  //     String buildNumber = packageInfo.buildNumber;
  //     setState(() {});
  //   });
  // }

  // Future<void> setupInteractedMessage(BuildContext context) async {
  //   initialize(context);
  //   RemoteMessage? initialMessage =
  //       await FirebaseMessaging.instance.getInitialMessage();
  //   if (initialMessage != null) {
  //     debugPrint(
  //         'Message also contained a notification: ${initialMessage.notification!.body}');
  //   }
  //   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //     debugPrint('Got a message whilst in the foreground!');
  //     debugPrint('Message data: ${message.data}');
  //     if (message.notification != null) {
  //       display(message);
  //     }
  //   });
  // }
  // Future<void> initialize(BuildContext context) async {
  //   AndroidNotificationChannel channel = const AndroidNotificationChannel(
  //     'high_importance_channel', // id
  //     'High Importance Notifications', // title
  //     importance: Importance.high,
  //   );
  //   await FlutterLocalNotificationsPlugin()
  //       .resolvePlatformSpecificImplementation<
  //           AndroidFlutterLocalNotificationsPlugin>()
  //       ?.createNotificationChannel(channel);
  // }
  // void display(RemoteMessage message) async {
  //   try {
  //     final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
  //     const NotificationDetails notificationDetails = NotificationDetails(
  //         android: AndroidNotificationDetails(
  //       "01",
  //       "LaaS",
  //       importance: Importance.max,
  //       priority: Priority.high,
  //     ));
  //     await FlutterLocalNotificationsPlugin().show(
  //       id,
  //       message.notification!.title,
  //       message.notification!.body,
  //       notificationDetails,
  //       payload: jsonEncode(message.data),
  //     );
  //   } on Exception catch (e) {
  //     debugPrint(e.toString());
  //   }
  // }

  // Widget urlLaunchingfn() {
  //   launchUrl(url).then((value) => {}, onError: (e) {
  //     throw Exception('Could not launch $url');
  //   });

  //   return Container();
  // }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration.zero,()async{
    //  await msgcontroller.MessageAPI().then((value)async {
    //       messages =Get.find<MessageController>().messages.value;
    //   });
    // });

    // setupInteractedMessage(context);
    // Future.delayed(const Duration(seconds: 3), () {
    //   if (Preferences.getString(Preferences.languageCodeKey)
    //       .toString()
    //       .isNotEmpty) {
    //     LocalizationService().changeLocale(
    //         Preferences.getString(Preferences.languageCodeKey).toString());
    //   }
    // });
    return GetMaterialApp(
      initialBinding: ControllerBinding(),
      title: 'Logistics As A Service (WBS)',
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        useMaterial3: false,
        primaryColor: MyColors.primaryblue,
        fontFamily: 'BoschSans',

        // textTheme: GoogleFonts.poppinsTextTheme(
        //   Theme.of(context).textTheme,
        // ),
        // primaryTextTheme: GoogleFonts.poppinsTextTheme(),
        // dividerColor: Colors.transparent
      ),
      // locale: LocalizationService.locale,
      // fallbackLocale: LocalizationService.locale,
      // translations: LocalizationService(),
      builder: EasyLoading.init(),
      // home: msgcontroller.load1.value
      //     ? InititalLoaderWidget('')
      //     : Constant.appVersion != version
      //         ? urlLaunchingfn()
      //         : const Homepage()
    );

    // GetMaterialApp(
    //     // initialBinding: ControllerBinding(),
    //     title: 'Logistics As A Service',
    //     debugShowCheckedModeBanner: false,
    //     theme: ThemeData(
    //         primaryColor: ConstantColors.primary, fontFamily: 'BoschSans'),
    //     builder: EasyLoading.init(),
    //     // home: Preferences.getBoolean(Preferences.isLogin)
    //     //     ? DashboardPage()
    //     //     : LoginScreen());
    //     // home: GetBuilder(  init: SettingsController(),
    //     //     builder: (controller) {
    //     //       Get.put(ConnectionManagerController());
    //     //       return Get.find<ConnectionManagerController>()
    //     //                   .connectionStatus
    //     //                   .value ==
    //     //               0
    //     //           ? EmptyFailureNoInternetView(
    //     //               image: 'assets/json/no_internet_lottie.json',
    //     //               title: 'OOPs!',
    //     //               description:
    //     //                   'No internet connections found. Check your connection or try again',
    //     //               buttonText: 'Retry',
    //     //               onPressed: () {
    //     //                 Get.offAll(LoginScreen());
    //     //               })
    //     //           : Preferences.getBoolean(Preferences.isLogin)
    //     //               ? DashboardPage()
    //     //               : LoginScreen();
    //     //     }));
    //     home: msgcontroller.load1.value
    //         ? InititalLoaderWidget()
    //         : Constant.appVersion != version
    //             ? urlLaunchingfn()
    //             : Homepage());

    // MaterialApp(
    //   navigatorKey: locator<NavigationService>().navigatorKey,
    //   onGenerateRoute: router.generateRoute,
    //   home: const SplashPage(),
    //   debugShowCheckedModeBanner: false,
    // );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void init() async {
    // await ref.read(cacheProvider.future);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    // _navigationService.navigateTo(routes.LoginScreenRoute);
  }

  @override
  Widget build(BuildContext context) {
    // final theme = Theme.of(context);
    // final scheme = theme.colorScheme;
    // final styles = theme.textTheme;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(20.0),
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                height: 150,
                child: Image.asset(
                  Constant.logo,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
