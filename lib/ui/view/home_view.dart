import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/controller/home_view_controller.dart';
import 'package:cajico_app/ui/widget/category_card.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/house_work_card.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widget/background.dart';
import '../widget/header.dart';

class HomeView extends GetView<HomeViewController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.replace(HomeViewController());
    final controller = Get.find<HomeViewController>();
    return Scaffold(
      backgroundColor: gray7,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo.png',
          title: '家事をする',
          actions: [
            Obx(() {
              final controller = Get.put(HomeViewController());
              final int unreadCount = controller.unreadCount();
              return NotificationAction(unreadCount: unreadCount);
            }),
          ],
        ),
      ),
      drawer: const HomeDrawer(),
      body: Background(
        child: GetLoadingStack<HomeViewController>(
          child: RefreshIndicator(
            color: primaryColor,
            onRefresh: controller.fetchData,
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      alignment: Alignment.centerLeft,
                      child: const Text('ジャンルから選ぶ', style: TextStyle(fontSize: 16)),
                    ),
                    const _CategoryCards(),
                    Container(
                      padding: const EdgeInsets.only(bottom: 16),
                      alignment: Alignment.centerLeft,
                      margin: const EdgeInsets.only(top: 24),
                      child: const Text('最近の家事から選ぶ', style: TextStyle(fontSize: 16)),
                    ),
                    const _ResentHouseWorks(),
                    verticalSpaceSmall
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}

class _CategoryCards extends StatelessWidget {
  const _CategoryCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(
                categoryName: '料理', imageUrl: 'assets/images/cooking.png', houseWorkCategoryId: 1),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: '買い物',
                imageUrl: 'assets/images/shopping.png',
                houseWorkCategoryId: 2),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: '洗濯', imageUrl: 'assets/images/washing.png', houseWorkCategoryId: 3),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(
                categoryName: '掃除', imageUrl: 'assets/images/cleaning.png', houseWorkCategoryId: 4),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: 'ペット', imageUrl: 'assets/images/pet.png', houseWorkCategoryId: 5),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: 'その他家事',
                imageUrl: 'assets/images/other_house_work.png',
                houseWorkCategoryId: 6),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(
                categoryName: '子守',
                imageUrl: 'assets/images/baby_sitting.png',
                houseWorkCategoryId: 7),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: '教育',
                imageUrl: 'assets/images/education.png',
                houseWorkCategoryId: 8),
            horizontalSpaceSmall,
            CategoryCard(
                categoryName: 'その他育児',
                imageUrl: 'assets/images/other_child_care.png',
                houseWorkCategoryId: 9),
          ],
        ),
      ],
    );
  }
}

class _ResentHouseWorks extends GetView<HomeViewController> {
  const _ResentHouseWorks();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(HomeViewController());

      return Column(
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.houseWorks().length,
            itemBuilder: (context, index) {
              final item = controller.houseWorks.elementAt(index);
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: HouseWorkCard(
                  houseWorkName: item.name,
                  imageUrl: item.categoryImageUrl,
                  point: item.point,
                  onPressed: () => controller.onTapCompleteDialog(
                    houseWorkId: item.houseWorkId,
                    point: item.point,
                  ),
                ),
              );
            },
          ),
        ],
      );
    });
  }
}
