// import 'dart:developer';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// // هذه الدالة يجب أن تكون خارج الكلاس (Global) لتتعامل مع الإشعارات والتطبيق مغلق تماماً
// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   log("Handling a background message: ${message.messageId}");
// }

// class NotificationService {
//   static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
//   static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // 1. طلب الصلاحيات من المستخدم (خاصة بـ iOS و Android 13+)
//     NotificationSettings settings = await _messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );

//     if (settings.authorizationStatus == AuthorizationStatus.authorized) {
//       log('User granted notification permission');
//     } else {
//       log('User declined or has not accepted notification permission');
//     }

//     // 2. إعدادات الإشعارات المحلية (Local Notifications) لإظهار الإشعار والتطبيق مفتوح
//     const AndroidInitializationSettings initializationSettingsAndroid =
//         AndroidInitializationSettings('@mipmap/ic_launcher'); // أيقونة تطبيقك

//     const InitializationSettings initializationSettings =
//         InitializationSettings(
//           android: initializationSettingsAndroid,
//           iOS: DarwinInitializationSettings(),
//         );

//     await _localNotificationsPlugin.initialize(initializationSettings);

//     // 3. التعامل مع الإشعارات في الخلفية (عندما يكون التطبيق مغلقاً تماماً)
//     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

//     // 4. الاستماع للإشعارات والتطبيق مفتوح (Foreground)
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       log('Got a message whilst in the foreground!');
//       log('Message data: ${message.data}');

//       if (message.notification != null) {
//         log(
//           'Message also contained a notification: ${message.notification!.title}',
//         );

//         // إظهار الإشعار المنبثق باستخدام Local Notifications
//         _showNotification(message);
//       }
//     });
//   }

//   // دالة لبناء وعرض الإشعار يدوياً داخل التطبيق
//   static void _showNotification(RemoteMessage message) async {
//     const AndroidNotificationDetails androidPlatformChannelSpecifics =
//         AndroidNotificationDetails(
//           'servixa_channel_id', // معرف القناة
//           'Servixa Notifications', // اسم القناة
//           importance: Importance.max,
//           priority: Priority.high,
//           playSound: true,
//         );

//     const NotificationDetails platformChannelSpecifics = NotificationDetails(
//       android: androidPlatformChannelSpecifics,
//       iOS: DarwinInitializationSettings(),
//     );

//     await _localNotificationsPlugin.show(
//       message.hashCode,
//       message.notification?.title,
//       message.notification?.body,
//       platformChannelSpecifics,
//     );
//   }

//   // دالة لجلب الـ Token الخاص بالجهاز لإرسال إشعارات مخصصة لهذا المستخدم من الـ API
//   static Future<String?> getDeviceToken() async {
//     try {
//       String? token = await _messaging.getToken();
//       log("Device Token: $token");
//       return token;
//     } catch (e) {
//       log("Error getting token: $e");
//       return null;
//     }
//   }
// }
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// هذه الدالة يجب أن تكون خارج الكلاس (Global) لتتعامل مع الإشعارات والتطبيق مغلق تماماً
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log("Handling a background message: ${message.messageId}");
}

class NotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  static final FlutterLocalNotificationsPlugin _localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. طلب الصلاحيات من المستخدم (خاصة بـ iOS و Android 13+)
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('User granted notification permission');
    } else {
      log('User declined or has not accepted notification permission');
    }

    // 2. إعدادات الإشعارات المحلية (Local Notifications) لإظهار الإشعار والتطبيق مفتوح
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher'); // أيقونة تطبيقك

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: DarwinInitializationSettings(),
        );

    await _localNotificationsPlugin.initialize(
      settings: initializationSettings,
    );

    // 3. التعامل مع الإشعارات في الخلفية (عندما يكون التطبيق مغلقاً تماماً)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // 4. الاستماع للإشعارات والتطبيق مفتوح (Foreground)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log('Got a message whilst in the foreground!');
      log('Message data: ${message.data}');

      if (message.notification != null) {
        log(
          'Message also contained a notification: ${message.notification!.title}',
        );

        // إظهار الإشعار المنبثق باستخدام Local Notifications
        _showNotification(message);
      }
    });
  }

  // دالة لبناء وعرض الإشعار يدوياً داخل التطبيق
  static void _showNotification(RemoteMessage message) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
          'servixa_channel_id', // معرف القناة
          'Servixa Notifications', // اسم القناة
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          icon: '@mipmap/launcher_icon',
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: DarwinNotificationDetails(),
    );

    await _localNotificationsPlugin.show(
      id: message.hashCode,
      title: message.notification?.title,
      body: message.notification?.body,
      notificationDetails: platformChannelSpecifics,
    );
  }

  // دالة لجلب الـ Token الخاص بالجهاز لإرسال إشعارات مخصصة لهذا المستخدم من الـ API
  static Future<String?> getDeviceToken() async {
    try {
      String? token = await _messaging.getToken();
      log("Device Token: $token");
      return token;
    } catch (e) {
      log("Error getting token: $e");
      return null;
    }
  }
}
