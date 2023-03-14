import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/my_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/loading_stack.dart';
import '../widget/normal_dialog.dart';
import 'my_page_edit_view.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyPageViewController());
    final user = controller.user();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('マイページ', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
        actions: <Widget>[
          PopupMenuButton(
            offset: const Offset(0, 50),
            onSelected: (result) {
              if (result == 3) {
                Get.dialog(NormalDialog(
                    message: 'ログアウトしますか？',
                    onPressed: () {
                      controller.onTapLogout();
                    }));
              } else if (result == 1 && user != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyPageEditView(
                      initFamilyName: user.familyName,
                      initFamilyCode: user.familyCode,
                      initUserName: user.userName,
                      iconUrl: user.iconUrl,
                      email: user.email,
                      initPosition: user.positionId,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 1,
                  child: Text('プロフィール編集'),
                ),
                const PopupMenuItem(
                  value: 2,
                  child: Text('通知設定'),
                ),
                const PopupMenuItem(
                  value: 3,
                  child: Text('ログアウト'),
                ),
              ];
            },
          )
        ],
      ),
      body: GetLoadingStack<MyPageViewController>(
        child: RefreshIndicator(
          color: primaryColor,
          onRefresh: controller.fetchData,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.all(16),
            child: Obx(() {
              final user = controller.user();
              if (user == null) {
                return const SizedBox();
              }
              return Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: gray5),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      '${user.userName}さん',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    verticalSpaceMedium,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            CajicoCachedNetworkIconImage(
                              imageUrl: user.iconUrl ??
                                  'https://cazico-public.s3.ap-northeast-1.amazonaws.com/user_icon/icon_1.png',
                              radius: 40,
                            ),
                          ],
                        ),
                        horizontalSpaceLarge,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _PointTitle(title: '保有P', point: user.ownedPoint),
                            verticalSpaceMedium,
                            _PointTitle(title: '累計P', point: user.totalPoint),
                          ],
                        ),
                      ],
                    ),
                    verticalSpaceMedium,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const _Divider(),
                        _MyPageMenu(menu: '家族名', value: '${user.familyName}家', icon: LineIcons.home),
                        _MyPageMenu(menu: '家族コード', value: user.familyCode, icon: LineIcons.key),
                        const _Divider(),
                        _MyPageMenu(menu: '家族での立場', value: user.positionName, icon: LineIcons.users),
                        _MyPageMenu(menu: 'メールアドレス', value: user.email, icon: LineIcons.envelope),
                      ],
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}

class _MyPageMenu extends StatelessWidget {
  const _MyPageMenu({required this.menu, required this.value, required this.icon});

  final String menu;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: subColor),
          horizontalSpaceMediumSmall,
          SizedBox(
            width: 100,
            child: Text(menu, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
          ),
          Text(value)
        ],
      ),
    );
  }
}

class _Divider extends StatelessWidget {
  const _Divider();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(
        height: 1,
        color: gray4,
      ),
    );
  }
}

class _PointTitle extends StatelessWidget {
  _PointTitle({required this.title, required this.point});

  final int point;
  final String title;
  final formatter = NumberFormat("#,###");

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 13)),
        horizontalSpaceSmall,
        Text(
          '${formatter.format(point)}P',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
