import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import 'controller/notification_count_controller.dart';
// import 'package:get/get_connect/http/src/utils/utils.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
// FlutterLocalNotificationsPlugin();
var notificationCount = Get.put(NotificationCountController());
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
void initMessaging() async {
  notificationCount.getNotification();
  // var initializationSettingsAndroid =
  // AndroidInitializationSettings('@mipmap/launcher_icon');
  // var initialzationSettingIos = DarwinInitializationSettings(
  //   requestBadgePermission:true,
  //   requestSoundPermission:  true,
  //
  // );

  // var initializationSettings =
  // InitializationSettings(android: initializationSettingsAndroid,
  //     iOS:  initialzationSettingIos
  // );


  // flutterLocalNotificationsPlugin.initialize(initializationSettings);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await _firebaseMessaging.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
    String notificationTitle = remoteMessage.notification!.title.toString();
    String notificationBody = remoteMessage.notification!.body.toString();

    notificationCount.getNotification();

    // showNotification(notificationTitle, notificationBody);
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

    notificationCount.getNotification();

    // FlutterAppBadger.removeBadge();
    // if (spUtil?.getString(Preferences.user_token) != "") {
    //   apiHandler?.userProfile();
    // }
    print("A new onMessageOpenedApp event was published!");
    final notificationType = json.decode(message.data["notification_type"]);
    final data = json.decode(message.data["data"]);
    sleep(Duration(milliseconds: 500));
    // eventBus?.fire([notificationType, data]);
    print("onMessageOpenedApp"+data.toString());
  });
  return null;
}

// void showNotification(String title, String body) async {
//   print('Lokesh ka msg');
//   var androidChannel = AndroidNotificationChannel(
//     'pushnotificationapp',
//     'pushnotificationapp',
//     description: 'Channel Description',
//     importance: Importance.high,
//   );
//
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//       AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(androidChannel);
//
//   var notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       androidChannel.id,
//       androidChannel.name,
//       channelDescription: androidChannel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//     ),
//   );
//
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     notificationDetails,
//     payload: 'payload',
//   );
// }




























// import 'dart:convert';
// import 'dart:io';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// // import 'package:get/get_connect/http/src/utils/utils.dart';

// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
// final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

// void initMessaging() async {
//   var initializationSettingsAndroid =
//       AndroidInitializationSettings('@mipmap/launcher_icon');
//   var initialzationSettingIos = DarwinInitializationSettings(
//     requestBadgePermission:true,
//     requestSoundPermission:  true,

//   );

//   var initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid,
//       iOS:  initialzationSettingIos
//       );


//   flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   /// Update the iOS foreground notification presentation options to allow
//   /// heads up notifications.
//   await _firebaseMessaging.setForegroundNotificationPresentationOptions(
//     alert: true,
//     badge: true,
//     sound: true,
//   );

//   FirebaseMessaging.onMessage.listen((RemoteMessage remoteMessage) async {
//     String notificationTitle = remoteMessage.notification!.title.toString();
//     String notificationBody = remoteMessage.notification!.body.toString();

//     showNotification(notificationTitle, notificationBody);
//   });

//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     // FlutterAppBadger.removeBadge();
//     // if (spUtil?.getString(Preferences.user_token) != "") {
//     //   apiHandler?.userProfile();
//     // }
//     print("A new onMessageOpenedApp event was published!");
//     final notificationType = json.decode(message.data["notification_type"]);
//     final data = json.decode(message.data["data"]);
//     sleep(Duration(milliseconds: 500));
//     // eventBus?.fire([notificationType, data]);
//     print(data);
//   });
//   return null;
// }

// void showNotification(String title, String body) async {
//   var androidChannel = AndroidNotificationChannel(
//     'firebase-push-notification',
//     'firebase-push-notification-channel',
//     description: 'Channel Description',
//     importance: Importance.high,
//   );

//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//           AndroidFlutterLocalNotificationsPlugin>()
//       ?.createNotificationChannel(androidChannel);

//   var notificationDetails = NotificationDetails(
//     android: AndroidNotificationDetails(
//       androidChannel.id,
//       androidChannel.name,
//       channelDescription: androidChannel.description,
//       importance: Importance.high,
//       priority: Priority.high,
//     ),
//   );

//   await flutterLocalNotificationsPlugin.show(
//     0,
//     title,
//     body,
//     notificationDetails,
//     payload: 'payload',
//   );
// }
