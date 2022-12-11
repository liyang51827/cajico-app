import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/reward_view_controller.dart';
import '../widget/loading_stack.dart';
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
                    for (var familyReward in controller.familyRewards()) ...{
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
                            horizontalSpaceTiny,
                            familyReward.requestingCount > 0
                                ? Container(
                                    width: 20,
                                    decoration: const BoxDecoration(
                                        shape: BoxShape.circle, color: secondaryColor),
                                    child: Text(
                                      familyReward.requestingCount.toString(),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(color: Colors.white),
                                    ),
                                  )
                                : const SizedBox()
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
          body: GetLoadingStack<RewardViewController>(
            child: TabBarView(
              children: [
                for (var familyReward in controller.familyRewards()) ...{
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          verticalSpaceSmall,
                          RewardCategoryCard(
                            rank: "リーズナブル",
                            rewardName: familyReward.smallRewardName,
                            imageUrl: 'assets/images/afternoon_tea.png',
                            rating: familyReward.smallRewardRating,
                            ownedPoint: familyReward.smallRewardOwnedPoint,
                            requiredPoint: familyReward.smallRewardPoint,
                            differencePoint: familyReward.smallRewardDifferencePoint,
                            isRequesting: familyReward.smallRewardIsRequesting,
                            note: familyReward.smallRewardNote,
                          ),
                          verticalSpaceSmall,
                          RewardCategoryCard(
                            rank: "スタンダード",
                            rewardName: 'Amazonギフト券',
                            imageUrl: 'assets/images/present.png',
                            rating: familyReward.middleRewardRating,
                            ownedPoint: familyReward.middleRewardOwnedPoint,
                            requiredPoint: familyReward.middleRewardPoint,
                            differencePoint: familyReward.middleRewardDifferencePoint,
                            isRequesting: familyReward.middleRewardIsRequesting,
                            note: familyReward.middleRewardNote,
                          ),
                          verticalSpaceSmall,
                          RewardCategoryCard(
                            rank: "ゴージャス",
                            rewardName: 'あなたが欲しいもの',
                            imageUrl: 'assets/images/propose.png',
                            rating: familyReward.largeRewardRating,
                            ownedPoint: familyReward.largeRewardOwnedPoint,
                            requiredPoint: familyReward.largeRewardPoint,
                            differencePoint: familyReward.largeRewardDifferencePoint,
                            isRequesting: familyReward.largeRewardIsRequesting,
                            note: familyReward.largeRewardNote,
                          ),
                          verticalSpaceSmall,
                        ],
                      ),
                    ),
                  ),
                }
              ],
            ),
          ),
          bottomNavigationBar: const Footer(),
        ),
      );
    });
  }
}
