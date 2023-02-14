import 'package:cajico_app/service/api_service.dart';
import 'package:cajico_app/service/dynamic_links_service.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

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
  print('test');
  Get.lazyPut(ApiService.new);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: config.firebaseOptions);
  await Future.wait([
    Get.putAsync(() => DynamicLinksService().init()),
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'CAJICO',
      home: const HomeView(),
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
