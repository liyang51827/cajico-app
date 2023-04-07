import 'package:badges/badges.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../controller/home_view_controller.dart';
import '../view/notification_view.dart';

class NotificationAction extends StatelessWidget {
  const NotificationAction({super.key, required this.unreadCount, required this.adminNoticeUnreadCount});

  final int unreadCount;
  final int adminNoticeUnreadCount;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeViewController());
    if(unreadCount > 0 || adminNoticeUnreadCount > 0) {
      return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: IconButton(
            onPressed: () {
              Get.to(() => const NotificationView());
              controller.onTapRead();
            },
            icon: Badge(
              position: const BadgePosition(start: 15, top: 5),
              elevation: 0,
              badgeColor: secondaryColor,
              child: const Icon(LineIcons.bell, size: 30),
            ),
          ));
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: IconButton(
          onPressed: () => Get.to(() => const NotificationView()),
          icon: const Icon(LineIcons.bell, size: 30),
        ));
  }
}
