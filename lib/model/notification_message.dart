import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationMessage {
  const NotificationMessage({
    this.title,
    this.body,
    this.type,
  });

  NotificationMessage.fromRemoteMessage(RemoteMessage remoteMessage)
      : title = remoteMessage.notification?.title,
        body = remoteMessage.notification?.body,
        type = NotificationMessageType.values
            .asNameMap()[remoteMessage.data['type']];

  final String? title;
  final String? body;
  final NotificationMessageType? type;
}

enum NotificationMessageType {
  chat,
}
