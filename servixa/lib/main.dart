import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:servixa/core/const/theme_app.dart';
import 'package:servixa/features/bording/presentation_layer/screens/super_bording_screen.dart';
import 'package:servixa/splash_screen.dart';

void main()  {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Servixa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeApp.whiteBackground),
      ),
      
      home: SplashScreen(),
    );
  }
}
