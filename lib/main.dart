import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:untitled/views/admin_view.dart';
import 'package:untitled/views/group_detail_view.dart';
import 'package:untitled/views/search_view.dart';
import 'utils/firebase_options.dart';
import 'views/map/main_view.dart';

Future<void> main() async {
  // Firebase initialize
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await setDevice();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(360, 700),
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          navigatorObservers: [
            FirebaseAnalyticsObserver(analytics: analytics),
          ],
          getPages: [
            GetPage(
              name: '/',
              page: () => MainView(),
            ),
            GetPage(
              name: '/search',
              page: () => SearchView(),
            ),
            GetPage(
              name: '/detail',
              page: () => GroupDetailView(),
            ),
            GetPage(
              name: '/admin',
              page: () => AdminView(),
            ),
          ],
          title: 'Gachon Map',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'pretendard',
            primaryColor: Colors.black.withOpacity(0.8),
          ),
          home: MainView(),
        );
      },
    );
  }
}
