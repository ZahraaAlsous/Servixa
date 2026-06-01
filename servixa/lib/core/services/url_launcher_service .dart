import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }

  static Future<void> makePhoneCall(String phoneNumber) async {
    final cleanNumber = phoneNumber.replaceAll(RegExp(r'[^\d+]'), '');

    final Uri phoneUri = Uri(scheme: 'tel', path: cleanNumber);

    try {
      if (await canLaunchUrl(phoneUri)) {
        await launchUrl(phoneUri);
      } else {
        throw 'لا يمكن الاتصال بهذا الرقم: $cleanNumber';
      }
    } catch (e) {
      print('خطأ في الاتصال: $e');
      // يمكنك إظهار رسالة للمستخدم
    }
  }
}
