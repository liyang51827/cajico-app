import 'package:cajico_app/service/api_service.dart';
import 'package:cajico_app/service/push_notification_service.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/home_view.dart';
import 'package:cajico_app/ui/view/register_family_view.dart';
import 'package:cajico_app/ui/view/reset_password_view.dart';
import 'package:cajico_app/ui/view/tutorial_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

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
  initUniLinks();
  await Firebase.initializeApp(options: config.firebaseOptions);
  final prefs = await SharedPreferences.getInstance();
  bool isLogin = prefs.getString('token') != null;
  runApp(MyApp(isLogin: isLogin));
}

Future<void> initUniLinks() async {
  try {
    final initialUri = await getInitialUri();
    _handleLink(initialUri);
  } on PlatformException {}

  uriLinkStream.listen((Uri? uri) {
    _handleLink(uri);
  });
}

void _handleLink(Uri? uri) {
  if (uri != null && uri.host == 'cajico.herokuapp.com' && uri.path == '/verify') {
    final type = uri.queryParameters['type'];
    final token = uri.queryParameters['token'];
    if (type == 'new' || type == 'join') {
      // 新規画面に遷移する
      Get.to(RegisterFamilyView(type: type!, token: token!));
    } else if (type == 'reset') {
      // 再設定画面に遷移する
      Get.to(ResetPasswordView(token: token!));
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isLogin});

  final bool isLogin;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    PushNotificationService().initialize();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CAJICO',
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
      onGenerateRoute: (settings) {
        if (settings.name != null) {
          // 受信したURIを取得
          Uri uri = Uri.parse(settings.name!);
          // クエリパラメーターからtypeとtokenを取得
          String? type = uri.queryParameters['type'];
          String? token = uri.queryParameters['token'];
          if (type == 'new' || type == 'join') {
            // 新規作成画面に遷移
            return MaterialPageRoute(
              builder: (context) => RegisterFamilyView(type: type!, token: token!),
            );
          } else if (type == 'reset') {
            // 参加画面に遷移
            return MaterialPageRoute(
              builder: (context) => ResetPasswordView(token: token!),
            );
          }
        }
        // ナビゲーションに失敗した場合はホーム画面に遷移
        return MaterialPageRoute(
            builder: (context) => isLogin ? const HomeView() : TutorialView());
      },
    );
  }
}
