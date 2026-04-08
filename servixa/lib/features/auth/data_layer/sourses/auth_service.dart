// // import 'dart:developer';

// // import 'package:dio/dio.dart';
// // import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// // class AuthService {
// //   final Dio dio = Dio();
// //   final storage = FlutterSecureStorage();

// //   Future<bool> register(
// //     String first_name,
// //     String last_name,
// //     String email, // String? email,
// //     // String? phone,
// //     String password,
// //   ) async {
// //     try {
// //       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Register IN");
// //       Response response = await dio.post(
// //         "https://services.tamkeen-dev.com/api/v1/register",
// //         data: {
// //           "first_name": first_name,
// //           "last_name": last_name,
// //           "email": email, // if (email != null) "email": email,
// //           // if (phone != null) "phone_number": phone,
// //           "password": password,
// //         },
// //         options: Options(headers: {"Accept": "application/json"}),
// //       );
// //       log("==============================Service : Register OK");
// //       return response.statusCode == 200;
// //     } on DioException catch (e) {
// //       if (e.type == DioExceptionType.connectionTimeout ||
// //           e.type == DioExceptionType.connectionError) {
// //         log("==============================Service : Register ERROR_Net");
// //         throw "Connection failed: Please check your internet";
// //       }
// //       log("==============================Service : Register ERROR");
// //       throw e.response!.data["message"];
// //     }
// //   }

// //   void saveToken(String token) async {
// //     await storage.write(key: "token", value: token);
// //   }
// // }
// import 'dart:developer';
// import 'package:dio/dio.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// class AuthService {
//   final Dio dio = Dio();
//   final storage = const FlutterSecureStorage();

//   Future<bool> register(
//     String first_name,
//     String last_name,
//     String email,
//     String password,
//   ) async {
//     try {
//       log(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>Service : Register IN");
//       Response response = await dio.post(
//         "https://services.tamkeen-dev.com/api/v1/register",
//         data: {
//           "first_name": first_name,
//           "last_name": last_name,
//           "email": email,
//           "password": password,
//         },
//         options: Options(headers: {"Accept": "application/json"}),
//       );
//       log("==============================Service : Register OK");
//       return response.statusCode == 200 || response.statusCode == 201;
//     } on DioException catch (e) {
//       if (e.type == DioExceptionType.connectionTimeout ||
//           e.type == DioExceptionType.connectionError) {
//         log("==============================Service : Register ERROR_Net");
//         throw "Connection failed: Please check your internet";
//       }
//       log("==============================Service : Register ERROR");
//       // تأكدي من شكل الـ Error القادم من السيرفر، أحياناً يكون داخل map
//       throw e.response?.data["message"] ?? "حدث خطأ غير متوقع";
//     }
//   }

//   Future<void> saveToken(String token) async {
//     await storage.write(key: "token", value: token);
//   }
// }
