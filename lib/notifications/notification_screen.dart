// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';
//
// class NotificationScreen{
//   getFCMToken() async {
//     var token = await FirebaseMessaging.instance.getToken();
//     print("FCMToken: $token");
//   }
//   getForgroundNotification(){
//     FirebaseMessaging.onMessage.listen((RemoteMessage message)async{
//       print(message.notification?.title);
//       print(message.notification?.body);
//       if(await requestNotificationPermissions() == true){
//         initializeNotifications();
//       }
//
//     });
//   }
//   initializeNotifications() async {
//     // object of FlutterLocalNotificationPlugin
//     FlutterLocalNotificationsPlugin notificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     // android platform initialization settings
//     AndroidInitializationSettings androidInitializationSettings =
//     const AndroidInitializationSettings("@mipmap/ic_launcher");
//     // init notification plugin
//     await notificationsPlugin.initialize(InitializationSettings(
//       // setting for android
//         android: androidInitializationSettings));
//     // show notification
//     notificationsPlugin.show(1, "Hii", "rani, How aur you?", const NotificationDetails(android: AndroidNotificationDetails("channelId", "channelName")));
//   }
//
//   requestNotificationPermissions() async {
//     final PermissionStatus status = await Permission.notification.request();
//     if (status.isGranted) {
//       // Notification permissions granted
//     } else if (status.isDenied) {
//       // Notification permissions denied
//     } else if (status.isPermanentlyDenied) {
//       // Notification permissions permanently denied, open app settings
//       await openAppSettings();
//     }
//    }
// }
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _LocalNotificationsState();
}

class _LocalNotificationsState extends State<NotificationScreen> {
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();
    requestPermissions();
    initializeNotifications();
    getNotificationOnForeground();
    showFcmToken();
  }

  void requestPermissions() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    print('User granted permission: ${settings.authorizationStatus}');
  }

  void initializeNotifications() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.blueAccent,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Test notification
            showTestNotification();
          },
          child: const Text("click"),
        ),
      ),
    );
  }

  void showFcmToken() async {
    var firebase = await FirebaseMessaging.instance.getToken();
    print("FCM Token: $firebase");
  }

  void getNotificationOnForeground() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        viewNotification(message);
      }
    });
  }

  void viewNotification(RemoteMessage message) async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      platformChannelSpecifics,
    );
  }

  void showTestNotification() async {
    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );
    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      'Test Notification',
      'This is a test notification',
      platformChannelSpecifics,
    );
  }
}