import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import '../model/notification_message.dart';

class PushNotificationService {
  FirebaseMessaging? _fcm;
  // final DialogService _dialogService = locator<DialogService>();
  // final NavigationService _navigationService = locator<NavigationService>();

  Future<void> initialise() async {
    if (_fcm == null) {
      final fcm = FirebaseMessaging.instance;
      if (Platform.isIOS) {
        unawaited(
          fcm.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          ),
        );
      }

      unawaited(
        fcm.getInitialMessage().then((RemoteMessage? message) {
          if (message == null) {
            return;
          }
          final notificationMessage =
              NotificationMessage.fromRemoteMessage(message);
          // _navigateTo(notificationMessage);
        }),
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        debugPrint('onMessage: $message');
        final notificationMessage =
            NotificationMessage.fromRemoteMessage(message);
        // _navigateTo(notificationMessage);
      });
      FirebaseMessaging.onMessageOpenedApp
          .listen((RemoteMessage message) async {
        debugPrint('onMessageOpenedApp: $message');
        final notificationMessage =
            NotificationMessage.fromRemoteMessage(message);
        // if (_dialogService.isShowed()) {
        //   return;
        // }
        // final result = await _dialogService.showDialog(
        //   title: notificationMessage.title,
        //   content: notificationMessage.body,
        //   buttonTitle: '確認する',
        //   cancelTitle: 'キャンセル',
        // );
        // if (result.confirmed == true) {
        //   // _navigateTo(notificationMessage);
        // }
      });

      // FirebaseMessaging.onBackgroundMessage(
      //   _firebaseMessagingBackgroundHandler,
      // );

      _fcm = fcm;
    }
  }

  // void _navigateTo(NotificationMessage notificationMessage) {
  //   final navigateIndex =
  //       notificationMessage.type == NotificationMessageType.chat
  //           ? HomeNavigationIndex.inquiry
  //           : HomeNavigationIndex.notice;
  //   _navigationService.pushNamedAndRemoveUntil<dynamic>(
  //     RouteName.homeRoute,
  //     arguments: HomeViewArguments(
  //       bottomNavigationIndex: navigateIndex,
  //     ),
  //   );
  // }

  Future<String?> getToken() async {
    return _fcm?.getToken();
  }
}
