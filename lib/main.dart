import 'package:cajico_app/service/api_service.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:cajico_app/ui/view/top_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'model/app_config.dart';
import 'model/app_flavor.dart';

void main() => run(
  AppConfig(
    flavor: AppFlavor.production,
    androidPackageName: 'com.herokuapp.cajico',
    iOSBundleId: 'com.herokuapp.cajico',
    firebaseOptions: DefaultFirebaseOptions.currentPlatform,
    domain: 'cajico.herokuapp.com',
    dynamicLinkDomain: 'cajico.page.link',
  ),
);

Future<void> run(AppConfig config) async {
  Get.lazyPut(ApiService.new);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: config.firebaseOptions);
  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getString('token') != null;
  runApp(MyApp(isLogin: isLogin));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});
  final bool isLogin;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CAJICO',
      home: isLogin ? const HomeView() : const TopView(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale("ja", "JP"),
      ],
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: gray2),
          bodyText2: TextStyle(color: gray2),
        ),
      ),
    );
  }
}
