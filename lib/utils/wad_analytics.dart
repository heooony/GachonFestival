import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class WadAnalytics {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  var deviceCode;

  /**
   * [name]setUser
   * [description]
   * user의 정보를 가지고 event를 추적해볼 수 있음
   * BigQuery와 연동되는 데이터
   */
  Future<void> setUser() async {
    await FirebaseAnalytics.instance.setUserId(id: '');
  }

  /**
   * [name] setLog
   * [description]
   * event를 발생시켜 event log를 google analytics에 남김
   * [parameter]
   * name : event의 제목
   * parameter : event의 매개변수, 이벤트가 발생한 횟수로 체크할 수 있음
   */
  Future<void> setLog() async {
    await analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'firebase_screen': "main_view",
        'firebase_screen_class': "MainView",
      },
    );
  }

  /**
   * [name] setScreen
   * [description]
   * event를 발생시켜 event log를 google analytics에 남김
   * [parameter]
   * name : event의 제목
   * parameter : event의 매개변수, 이벤트가 발생한 횟수로 체크할 수 있음
   */
  Future<void> setScreen(String screen) async {
    await analytics.logEvent(
      name: 'screen_view',
      parameters: {
        'screen': screen,
      },
    );
  }

  /**
   * [name] setDevice
   * [description] 해당 디바이스의 정보를 hashing하여 deviceCode 변수에 저장
   */
  Future<void> setDevice() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
    // DatabaseReference ref = FirebaseDatabase.instance.ref("/");
    var encode = utf8.encode(webBrowserInfo.userAgent!);
    deviceCode = sha256.convert(encode);
  }
}