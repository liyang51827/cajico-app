import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/reward_view_controller.dart';
import '../widget/reward_category_card.dart';

class RewardView extends GetView<RewardViewController> {
  const RewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(RewardViewController());

      return DefaultTabController(
        initialIndex: 0,
        length: controller.familyRewards().length,
        child: Scaffold(
          backgroundColor: gray7,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: Row(children: const [
              Image(
                image: AssetImage(
                  'assets/images/logo_reward.png',
                ),
                height: 55,
              ),
              horizontalSpaceSmall,
              Text('ごほうび', style: TextStyle(color: gray2)),
            ]),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(fontSize: 22),
            actions: const [
              NotificationAction(),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(55),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TabBar(
                  isScrollable: true,
                  labelColor: primaryColor,
                  unselectedLabelColor: gray4,
                  indicatorColor: primaryColor,
                  indicatorWeight: 3,
                  labelStyle: const TextStyle(fontSize: 16),
                  tabs: <Widget>[
                    for(var familyReward in controller.familyRewards()) ... {
                      Tab(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: familyReward.iconUrl,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(color: primaryColor),
                              ),
                              imageBuilder: (context, imageProvider) {
                                return CircleAvatar(
                                  radius: 15,
                                  backgroundImage: imageProvider,
                                );
                              },
                            ),
                            horizontalSpaceSmall,
                            Text(familyReward.userName),
                          ],
                        ),
                      )
                    }
                  ],
                ),
              ),
            ),
          ),
          drawer: const HomeDrawer(),
          body: TabBarView(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "ライト",
                        rewardName: 'コンビニのお菓子',
                        imageUrl: 'assets/images/afternoon_tea.png',
                        rating: 1.0,
                        ownedPoint: 1000,
                        requiredPoint: 1000,
                        differencePoint: 0,
                      ),
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "スタンダード",
                        rewardName: 'Amazonギフト券',
                        imageUrl: 'assets/images/present.png',
                        rating: 0.33,
                        ownedPoint: 1000,
                        requiredPoint: 3000,
                        differencePoint: 2000,
                      ),
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "スペシャル",
                        rewardName: 'あなたが欲しいもの',
                        imageUrl: 'assets/images/propose.png',
                        rating: 0.1,
                        ownedPoint: 1000,
                        requiredPoint: 10000,
                        differencePoint: 9000,
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Column(
                    children: const [
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "ライト",
                        rewardName: 'コンビニのお菓子',
                        imageUrl: 'assets/images/afternoon_tea.png',
                        rating: 1.0,
                        ownedPoint: 1000,
                        requiredPoint: 1000,
                        differencePoint: 0,
                      ),
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "スタンダード",
                        rewardName: 'Amazonギフト券',
                        imageUrl: 'assets/images/present.png',
                        rating: 0.33,
                        ownedPoint: 1000,
                        requiredPoint: 3000,
                        differencePoint: 2000,
                      ),
                      verticalSpaceSmall,
                      RewardCategoryCard(
                        rank: "スペシャル",
                        rewardName: 'あなたが欲しいもの',
                        imageUrl: 'assets/images/propose.png',
                        rating: 0.1,
                        ownedPoint: 1000,
                        requiredPoint: 10000,
                        differencePoint: 9000,
                      ),
                      verticalSpaceSmall,
                    ],
                  ),
                ),
              ),
            ],
          ),
          bottomNavigationBar: const Footer(),
        ),
      );
    });
  }
}
