import 'package:badges/badges.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../view/notification_view.dart';

class NotificationAction extends StatelessWidget {
  const NotificationAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: IconButton(
        onPressed: () => Get.to(() => const NotificationView()),
        icon: Badge(
          position: const BadgePosition(start: 15, top: -5),
          badgeContent: const Text('3', style: TextStyle(color: Colors.white)),
          elevation: 0,
          badgeColor: secondaryColor,
          child: const Icon(LineIcons.bell, size: 30),
        ),
      )
    );
  }
}
