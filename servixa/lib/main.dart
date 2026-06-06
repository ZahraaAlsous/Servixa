import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/core/services/notification_service.dart';
import 'package:servixa/features/auth/business_later/auth_controller.dart';
import 'package:servixa/features/location%20user/business_layer/location_controller.dart';
import 'package:servixa/features/splash/presentation_layer/screens/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. تهيئة الفيربيز أولاً
  await Firebase.initializeApp(); 
  
  // 2. تهيئة خدمة الإشعارات
  await NotificationService.initialize();
  
  // طباعة التوكن لتجربته في الـ Firebase Console
  await NotificationService.getDeviceToken();

  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      // startLocale: Locale('en'),
      startLocale: null,
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: MyApp(),
    ),
  );
}

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LocationController(), permanent: true);
    Get.put(AuthController(), permanent: true);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return GetMaterialApp(
      initialBinding: AppBinding(),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,
      title: 'Servixa',
      home: SplashScreen(),
      // home: AnimationContainar(),
      // home: GeocodingTestScreen(),
    );
  }
}
