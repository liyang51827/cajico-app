import 'package:cajico_app/ui/view/home_view.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    // 通知の許可を求める
    await _fcm.requestPermission();

    // 通知を受信した場合の処理
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   showDialog(
    //     context: Get.overlayContext!,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text(message.notification?.title ?? ''),
    //         content: Text(message.notification?.body ?? ''),
    //         actions: [
    //           TextButton(
    //             onPressed: () => Get.back(),
    //             child: const Text('OK'),
    //           ),
    //         ],
    //       );
    //     },
    //   );
    // });

    // アプリがバックグラウンドで実行中の場合、通知をタップしてアプリを起動した場合の処理
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Get.to(() => const HomeView());
    });

    // アプリが起動していない状態で通知をタップしてアプリを起動した場合の処理
    final initialMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      Get.to(() => const HomeView());
    }
  }
}
