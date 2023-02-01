import 'package:cajico_app/service/api_service.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

Future<void> main() async {
  Get.lazyPut(ApiService.new);
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
