// import 'package:anandmart_driver/routers/routers.dart';
import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:referral_app/routers/routers.dart';
import 'package:referral_app/widgets/notification_service.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  log("Handling a background message: ${message.messageId}");
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  NotificationService().initializeNotification();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);


  FirebaseMessaging.onMessage.listen((message) {
    if (message.notification != null) {
      FlutterAppBadger.isAppBadgeSupported().then((value) async {
        if (value) {
          FlutterAppBadger.updateBadgeCount(1);
        }
      });
    }
  });


  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Recs',
      theme: ThemeData(
        fontFamily: 'poppinsSans',
        primarySwatch: Colors.green,
        useMaterial3 : false,
      ),
      builder: (c, child)=> GestureDetector(
        onTap: (){
          FocusManager.instance.primaryFocus!.unfocus();
        },
        behavior: HitTestBehavior.translucent,
        child: child!,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      getPages: MyRouters.route,
    );
  }
}
