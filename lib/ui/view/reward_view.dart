import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/reward_view_controller.dart';
import '../widget/background.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/header.dart';
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
          appBar: const PreferredSize(
            preferredSize: Size.fromHeight(105),
            child: Header(
              imageUrl: 'assets/images/logo_reward.png',
              title: 'ごほうび',
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(50),
                child: _TabBar(),
              ),
            ),
          ),
          drawer: const HomeDrawer(),
          body: Background(
            child: GetLoadingStack<RewardViewController>(
              child: TabBarView(
                children: [
                  for (var familyReward in controller.familyRewards()) ...{
                    RefreshIndicator(
                      color: primaryColor,
                      onRefresh: controller.fetchData,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              verticalSpaceSmall,
                              RewardCategoryCard(
                                rank: "リーズナブル",
                                rewardId: familyReward.smallRewardId,
                                rewardName: familyReward.smallRewardName,
                                imageUrl: 'assets/images/afternoon_tea.png',
                                rating: familyReward.smallRewardRating,
                                ownedPoint: familyReward.smallRewardOwnedPoint,
                                requiredPoint: familyReward.smallRewardPoint,
                                differencePoint: familyReward.smallRewardDifferencePoint,
                                isRequesting: familyReward.smallRewardIsRequesting,
                                isMe: familyReward.smallRewardIsMe,
                                isAvailable: familyReward.smallRewardIsAvailable,
                                note: familyReward.smallRewardNote,
                                minPoint: familyReward.smallRewardMinPoint,
                                maxPoint: familyReward.smallRewardMaxPoint,
                              ),
                              verticalSpaceSmall,
                              RewardCategoryCard(
                                rank: "スタンダード",
                                rewardId: familyReward.middleRewardId,
                                rewardName: familyReward.middleRewardName,
                                imageUrl: 'assets/images/present.png',
                                rating: familyReward.middleRewardRating,
                                ownedPoint: familyReward.middleRewardOwnedPoint,
                                requiredPoint: familyReward.middleRewardPoint,
                                differencePoint: familyReward.middleRewardDifferencePoint,
                                isRequesting: familyReward.middleRewardIsRequesting,
                                isMe: familyReward.middleRewardIsMe,
                                isAvailable: familyReward.middleRewardIsAvailable,
                                note: familyReward.middleRewardNote,
                                minPoint: familyReward.middleRewardMinPoint,
                                maxPoint: familyReward.middleRewardMaxPoint,
                              ),
                              verticalSpaceSmall,
                              RewardCategoryCard(
                                rank: "ゴージャス",
                                rewardId: familyReward.largeRewardId,
                                rewardName: familyReward.largeRewardName,
                                imageUrl: 'assets/images/propose.png',
                                rating: familyReward.largeRewardRating,
                                ownedPoint: familyReward.largeRewardOwnedPoint,
                                requiredPoint: familyReward.largeRewardPoint,
                                differencePoint: familyReward.largeRewardDifferencePoint,
                                isRequesting: familyReward.largeRewardIsRequesting,
                                isMe: familyReward.largeRewardIsMe,
                                isAvailable: familyReward.largeRewardIsAvailable,
                                note: familyReward.largeRewardNote,
                                minPoint: familyReward.largeRewardMinPoint,
                                maxPoint: familyReward.largeRewardMaxPoint,
                              ),
                              verticalSpaceSmall,
                            ],
                          ),
                        ),
                      ),
                    ),
                  }
                ],
              ),
            ),
          ),
          bottomNavigationBar: const Footer(),
        ),
      );
    });
  }
}

class _TabBar extends StatelessWidget {
  const _TabBar();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(RewardViewController());

      return Align(
        alignment: Alignment.centerLeft,
        child: TabBar(
          isScrollable: true,
          labelColor: primaryColor,
          unselectedLabelColor: gray4,
          indicatorColor: primaryColor,
          indicatorWeight: 4,
          labelStyle: const TextStyle(fontSize: 16),
          tabs: <Widget>[
            for (var familyReward in controller.familyRewards()) ...{
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CajicoCachedNetworkIconImage(
                      imageUrl: familyReward.iconUrl ??
                          'https://cazico-public.s3.ap-northeast-1.amazonaws.com/user_icon/icon_1.png',
                      radius: 15,
                    ),
                    horizontalSpaceSmall,
                    Text(familyReward.userName),
                    horizontalSpaceTiny,
                    familyReward.requestingCount > 0
                        ? Container(
                            width: 20,
                            decoration:
                                const BoxDecoration(shape: BoxShape.circle, color: secondaryColor),
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
      );
    });
  }
}
