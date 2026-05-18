import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  static Future<void> openUrl(Uri url) async {
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
