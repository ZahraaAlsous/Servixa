import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Trans;
import 'package:servixa/splash_screen.dart';
import 'package:easy_localization/easy_localization.dart';

void main() async  {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      startLocale: Locale('en'),

      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en'),
      child: 
      MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    return GetMaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      debugShowCheckedModeBanner: false,
      title: 'Servixa',
      home: SplashScreen(),
      // home: SplashScreen2(),
    );
  }
}

class SplashScreen2 extends StatelessWidget {
  const SplashScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text('Zahraa'.tr()),
            Text('Zahraa'),
            Text('Zahraa2'),
            ElevatedButton(
              onPressed: () {
                // if (context.locale == const Locale('en')) {
                //   context.setLocale(const Locale('ar'));
                // } else {
                //   context.setLocale(const Locale('en'));
                // }
              },
              child: Text('lang'),
            ),
          ],
        ),
      ),
    );
  }
}
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:servixa/core/const/theme_app.dart';

// void main() {
// async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await EasyLocalization.ensureInitialized();

  // runApp(
    // EasyLocalization(
    //   supportedLocales: const [Locale('en'), Locale('ar')],
    //   path: "assets/translations",
    //   child: 
      // const MyApp(),
    //   startLocale: const Locale('en'),
    //   fallbackLocale: const Locale('en'),
    // ),
//   );
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     debugShowCheckedModeBanner: false,
  //     title: 'Servixa',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: ThemeApp.whiteBackground),
  //     ),
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,
//       home: const SplashScreen2(),
//     );
//   }
// }

// class SplashScreen2 extends StatelessWidget {
//   const SplashScreen2({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Hello'),  // يجب أن تظهر "مرحباً" أو "Hello"
//             Text('title'),  // يجب أن يظهر "العنوان" أو "Title"
//             ElevatedButton(
//               onPressed: () {
                // if (context.locale == const Locale('en')) {
                //   context.setLocale(const Locale('ar'));
                // } else {
                //   context.setLocale(const Locale('en'));
                // }
//               },
//               child: Text('lang'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
