import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/controller/base_view_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BaseViewController());
    return Obx(
      () => BottomNavigationBar(
        onTap: controller.onTapBottomNavigation,
        currentIndex: controller.tabIndex.value,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(LineIcons.home),
            activeIcon: Icon(CupertinoIcons.house_fill),
            label: '家事',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.calendar),
            activeIcon: Icon(CupertinoIcons.calendar),
            label: 'スケジュール',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.gift),
            activeIcon: Icon(CupertinoIcons.gift_fill),
            label: 'ごほうび',
          ),
          BottomNavigationBarItem(
            icon: Icon(LineIcons.history),
            activeIcon: Icon(Icons.history_rounded),
            label: '履歴',
          ),
        ],
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        iconSize: 25,
        unselectedFontSize: 11,
        unselectedItemColor: subColor,
        selectedIconTheme: const IconThemeData(size: 31),
        selectedFontSize: 11,
        selectedItemColor: primaryColor,
      ),
    );
  }
}
