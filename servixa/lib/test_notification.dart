import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class TestNotification extends StatefulWidget {
  const TestNotification({super.key});

  @override
  State<TestNotification> createState() => _TestNotificationState();
}

class _TestNotificationState extends State<TestNotification> {
  getToken() async {
    String? myToken = await FirebaseMessaging.instance.getToken();
    log("~~~~~~~~~~~~~~~~~~~~~~~~~~~my token is : $myToken");
  }

  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
