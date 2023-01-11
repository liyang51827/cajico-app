import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/my_page_view_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../widget/loading_stack.dart';

class MyPageView extends StatelessWidget {
  const MyPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyPageViewController());
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black54),
        centerTitle: true,
        title: const Text('マイページ', style: TextStyle(color: gray2)),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(fontSize: 22),
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
              final formatter = NumberFormat("#,###");
              if (user == null) {
                return const SizedBox();
              }
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
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
                        SizedBox(
                          height: 80,
                          child: CachedNetworkImage(
                            imageUrl: user.iconUrl,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(color: primaryColor),
                            ),
                          ),
                        ),
                        verticalSpaceMediumLarge,
                        const Text('保有ポイント', style: TextStyle(fontWeight: FontWeight.bold)),
                        verticalSpaceSmall,
                        Text(
                          '${formatter.format(user.ownedPoint)}P',
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                        verticalSpaceLarge,
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _MyPageMenu(menu: 'ファミリーネーム', value: '${user.familyName}家'),
                        _MyPageMenu(menu: 'ファミリーコード', value: user.familyCode),
                        _MyPageMenu(menu: '続柄', value: user.position),
                        _MyPageMenu(menu: 'メールアドレス', value: user.email),
                        _MyPageMenu(menu: '誕生日', value: user.birthday),
                        _MyPageMenu(menu: '本日の獲得P', value: '${formatter.format(user.todayPoint)}P'),
                        _MyPageMenu(menu: '累計獲得P', value: '${formatter.format(user.totalPoint)}P'),
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
          Text(menu, style: const TextStyle(fontSize: 12)),
          verticalSpaceTiny,
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
