import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'utils/firebase_options.dart';
import 'views/map/main_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:crypto/crypto.dart';

Future<void> main() async {
  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await setDevice();
  runApp(const MyApp());
}

Future<void> setDevice() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
  DatabaseReference ref = FirebaseDatabase.instance.ref("/");
  var encode = utf8.encode(webBrowserInfo.userAgent!);
  var saveCode = sha256.convert(encode);
  await ref.set({
    saveCode: " ",
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gachon Map',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'DoHyeon',
        primaryColor: Colors.black.withOpacity(0.8),
      ),
      home: MainView(),
    );
  }
}
