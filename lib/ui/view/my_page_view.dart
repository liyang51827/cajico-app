import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/my_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
              if (result == 2) {
                Get.dialog(
                  NormalDialog(
                    message: 'ログアウトしますか？',
                    onPressed: () {
                      controller.onTapLogout();
                    },
                  ),
                );
              } else if (result == 0) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => MyPageEditView(
                      initFamilyName: user!.familyName,
                      initFamilyCode: user.familyCode,
                      initUserName: user.userName,
                      iconUrl: user.iconUrl,
                      birthday: user.birthday,
                      email: user.email,
                      initPosition: user.position,
                    ),
                    fullscreenDialog: true,
                  ),
                );
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Text('プロフィール編集'),
                ),
                const PopupMenuItem(
                  value: 1,
                  child: Text('通知設定'),
                ),
                const PopupMenuItem(
                  value: 2,
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
              final formatter = NumberFormat("#,###");
              if (user == null) {
                return const SizedBox();
              }
              return Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: gray5),
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Text(
                          '${user.userName}さん',
                          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        verticalSpaceMediumLarge,
                        CajicoCachedNetworkIconImage(imageUrl: user.iconUrl, radius: 40),
                        verticalSpaceMediumLarge,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _PointTitle(title: '保有ポイント', point: user.ownedPoint),
                            horizontalSpaceLarge,
                            _PointTitle(title: '累計ポイント', point: user.totalPoint),
                          ],
                        ),
                        verticalSpaceLarge,
                      ],
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const _Divider(),
                          _MyPageMenu(menu: 'ファミリーネーム', value: '${user.familyName}家'),
                          _MyPageMenu(menu: 'ファミリーコード', value: user.familyCode),
                          const _Divider(),
                          _MyPageMenu(menu: '続柄', value: user.position),
                          _MyPageMenu(menu: 'メールアドレス', value: user.email),
                          _MyPageMenu(menu: '誕生日', value: user.birthday),
                          const _Divider(),
                          _MyPageMenu(
                              menu: '本日の獲得P', value: '${formatter.format(user.todayPoint)}P'),
                          _MyPageMenu(
                              menu: '累計獲得P', value: '${formatter.format(user.totalPoint)}P'),
                        ],
                      ),
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
  const _MyPageMenu({required this.menu, required this.value});

  final String menu;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(menu, style: const TextStyle(fontSize: 13)),
          verticalSpaceTiny,
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold),
          )
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
    return Column(
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        verticalSpaceSmall,
        Text(
          '${formatter.format(point)}P',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
      ],
    );
  }
}
