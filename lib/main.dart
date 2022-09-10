import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/views/wadpik_admin_view.dart';
import 'utils/firebase_options.dart';
import 'views/main_view.dart';

Future<void> main() async {
  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
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
