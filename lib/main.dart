import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:suku/AppModule/Home/Controller/home_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Attendance/Controller/controller.dart';
import 'package:suku/AppModule/HomeFeatures/Exams/Controller/exam_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Fees/Controller/fees_controller.dart';
import 'package:suku/AppModule/HomeFeatures/LeaveHistory/Controller/leave_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Marks/Controller/mark_controller.dart';
import 'package:suku/AppModule/HomeFeatures/Notifications/Controller/notification_controller.dart';
import 'package:suku/AppModule/HomeFeatures/TimeTable/Controller/time_controller.dart';
import 'package:suku/AppModule/SplashScreen/splash_screen.dart';
import 'package:suku/Services/fcm/local_notification.dart';
import 'package:suku/Utils/Translation/translation.dart';


late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {

  await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.messageId}');
}
void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  if (!kIsWeb) {
    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description:
      'This channel is used for important notifications.', // description
      importance: Importance.high,
    );
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }
  runApp(Application());
}

int _messageCount = 0;


/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String? token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
      "click_action": "FLUTTER_NOTIFICATION_CLICK",
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return    GetMaterialApp(
      debugShowCheckedModeBanner: false,
        locale: const Locale('gu', 'IN'),
        translations: LocaleString(),
        fallbackLocale: const Locale('en', 'US'),
        title: 'e-suku',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),

      home: SplashScreen(),
    );
  }
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}

class _Application extends State<Application> {
  String? _token;
  String FCM_TOKEN = "";
  bool isNotification = false;

  late Stream<String> _tokenStream;

  void setToken(String? token) {
    debugPrint('FCM Token: $token');
    setState(() {
      _token = token;
      FCM_TOKEN = token!;
    });
    debugPrint('******************************************');
    debugPrint('FCM Token: ${FCM_TOKEN}');
    debugPrint('******************************************');
  }
  void messagePop() {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('A new onMessageOpenedApp event was published!     $message');
    });
  }

  @override
  void initState() {
    super.initState();
    messagePop();
    FirebaseMessaging.instance
        .getToken(
        vapidKey:
        'BGpdLRsMJKvFDD9odfPk92uBg-JbQbyoiZdah0XlUyrjG4SDgUsE1iC_kdRgt4Kn0CO7K3RTswPZt61NNuO0XoA')
        .then(setToken);
    _tokenStream = FirebaseMessaging.instance.onTokenRefresh;
    _tokenStream.listen(setToken);
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {}
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint("Received...");
      Get.put(HomeController()).homeList(
             Get.put(HomeController()).token
           );
      Get.put(MarkController()).markList(
          Get.put(HomeController()).token
      );
      Get.put(NotificationController()).notiList(
          Get.put(HomeController()).token
      );
      Get.put(TimeController()).timeList(
          Get.put(HomeController()).token
      );
      Get.put(LeaveController()).leaveList(
          Get.put(HomeController()).token
      );
      Get.put(FeeController()).feeList(
          Get.put(HomeController()).token
      );
      Get.put(ExamController()).examList(
          Get.put(HomeController()).token
      );
      Get.put(AttendenceListController()).attendenceListAll(
          Get.put(HomeController()).token
      );

      // if(message.data["type"]=="Order Created")
      // {
      //   debugPrint("Hamza...");
      //   Get.put(HomeBusinessController()).topOrderDataFilter(
      //       tokenId: Get.put(HomeBusinessController()).token
      //   );
      // }
      debugPrint(message.data.toString());

      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null && !kIsWeb) {
        NotificationService().showNotifications(id: 1,title: message.notification!.title,body: message.notification!.body);
        setState(() {

          isNotification = true;
          //ApiConstants.bidSlug = message.data["bid"].toString();
        });
        debugPrint(isNotification.toString());

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyApp();
  }
}
