import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/view/email_send_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:line_icons/line_icons.dart';
import '../common/app_color.dart';
import '../view/inquiry_view.dart';
import '../view/my_page_view.dart';
import '../view/web_view_view.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Image(
                      image: AssetImage('assets/images/logo_drawer.png'),
                      height: 70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 8),
                    child: const Text(
                      'メニュー',
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(
              LineIcons.userPlus,
              color: subColor,
            ),
            title: Row(
              children: const [
                Text('家族を招待する'),
                horizontalSpaceSmall,
                Text('New!', style: TextStyle(color: primaryColor),),
              ],
            ),
            onTap: () => Get.to(() => EmailSendView(type: 'invite')),
          ),
          ListTile(
            leading: const Icon(
              LineIcons.user,
              color: subColor,
            ),
            title: const Text('マイページ'),
            onTap: () => Get.to(() => const MyPageView()),
          ),
          ListTile(
            leading: const Icon(
              LineIcons.envelope,
              color: subColor,
            ),
            title: const Text('ご意見箱'),
            onTap: () => Get.to(() => InquiryView()),
          ),
          ListTile(
            leading: const Icon(
              LineIcons.book,
              color: subColor,
            ),
            title: const Text('利用規約'),
            onTap: () => Get.to(const WebViewView(initialPath: 'term.html', title: '利用規約')),
          ),
          ListTile(
            leading: const Icon(
              LineIcons.key,
              color: Colors.brown,
            ),
            title: const Text('プライバシーポリシー'),
            onTap: () =>
                Get.to(const WebViewView(initialPath: 'privacy_policy.html', title: 'プライバシーポリシー')),
          ),
        ],
      ),
    );
  }
}
