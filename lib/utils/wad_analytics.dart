import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:untitled/main.dart';

class WadAnalytics {

  static Future<void> setUser() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    var encode = utf8.encode(deviceId!);
    var deviceCode = sha256.convert(encode);
    await FirebaseAnalytics.instance.setUserId(id: deviceCode.toString());
  }

  Future<void> setLog() async {
    await MyApp.analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': "main_view",
        'firebase_screen_class': "MainView",
      },
    );
  }

  static Future<void> setReservation(String args) async {
    await MyApp.analytics.logEvent(
      name: 'reservation',
      parameters: {
        'reservation': 'click',
        'booth': args,
      },
    );
  }

  Future<void> setScreen(String screen) async {
    await MyApp.analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'screen': screen,
      },
    );
  }
}
