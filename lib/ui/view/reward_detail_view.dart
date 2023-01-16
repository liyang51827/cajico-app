import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/view/reward_edit_view.dart';
import 'package:cajico_app/ui/widget/colored_tab_bar.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/home_view_controller.dart';
import '../controller/reward_detail_view_controller.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/loading_stack.dart';
import '../widget/normal_completed_dialog.dart';
import '../widget/reward_complete_dialog.dart';
import '../widget/reward_request_completed_dialog.dart';
import '../widget/reward_request_dialog.dart';
import 'package:intl/intl.dart';

class RewardDetailView extends StatelessWidget {
  const RewardDetailView({
    super.key,
    required this.imageUrl,
    required this.rank,
    required this.rewardId,
    required this.rewardName,
    required this.point,
    required this.text,
    required this.isMe,
    required this.isAvailable,
    required this.isRequesting,
    required this.minPoint,
    required this.maxPoint,
  });

  final String imageUrl;
  final String rank;
  final int rewardId;
  final String rewardName;
  final int point;
  final String text;
  final bool isMe;
  final bool isAvailable;
  final bool isRequesting;
  final int minPoint;
  final int maxPoint;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final controller = Get.put(RewardDetailViewController(rewardId: rewardId));
      final homeController = Get.put(HomeViewController());
      return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: gray7,
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(200.0),
            child: AppBar(
              iconTheme: const IconThemeData(color: gray2),
              elevation: 0.0,
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(imageUrl), fit: BoxFit.fitWidth)),
              ),
              actions: <Widget>[
                PopupMenuButton(
                  offset: const Offset(0, 50),
                  onSelected: (result) {
                    if (!result) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RewardEditView(
                            minPoint: minPoint,
                            maxPoint: maxPoint,
                            rewardId: rewardId,
                            rank: rank,
                            initPoint: point,
                            initRewardName: rewardName,
                            initMemo: text,
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    } else {
                      Get.dialog(
                        NormalCompletedDialog(
                          message: 'ねぎらい待ちのごほうびは\n編集できません',
                          onPressed: () {
                            Get.back();
                            homeController.onTapGetUnreadCount();
                          },
                        ),
                      );
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem(
                        value: isRequesting,
                        child: const Text('編集する'),
                      ),
                    ];
                  },
                )
              ],
              bottom: const ColoredTabBar(
                color: Colors.white,
                tabBar: TabBar(
                  labelColor: primaryColor,
                  unselectedLabelColor: gray4,
                  indicatorColor: primaryColor,
                  indicatorWeight: 3,
                  labelStyle: TextStyle(fontSize: 16),
                  tabs: <Widget>[
                    Tab(child: Text('ごほうび情報')),
                    Tab(child: Text('履歴')),
                  ],
                ),
              ),
            ),
          ),
          body: GetLoadingStack<RewardDetailViewController>(
            child: TabBarView(
              children: [
                RefreshIndicator(
                  color: primaryColor,
                  onRefresh: controller.fetchData,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _Detail(rewardName: rewardName, text: text, point: point, rank: rank),
                  ),
                ),
                controller.rewardHistories().isNotEmpty
                    ? RefreshIndicator(
                        color: primaryColor,
                        onRefresh: controller.fetchData,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.rewardHistories().length,
                                itemBuilder: (context, index) {
                                  final item = controller.rewardHistories.elementAt(index);
                                  return _RewardHistoryDetail(
                                      rewardName: item.rewardName,
                                      date: item.createdAt,
                                      userImageUrl: item.iconUrl ??
                                          'https://cazico-public.s3.ap-northeast-1.amazonaws.com/user_icon/icon.png',
                                      message: item.message ?? '',
                                      point: item.point);
                                },
                              ),
                            ],
                          ),
                        ),
                      )
                    : Container(
                        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 16),
                        child: const Text(
                          'ごほうび履歴はありません',
                          textAlign: TextAlign.center,
                        ),
                      ),
              ],
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: _RewardButton(
              rewardId: rewardId,
              rewardName: rewardName,
              point: point,
              isMe: isMe,
              isAvailable: isAvailable,
            ),
          ),
        ),
      );
    });
  }
}

class _Detail extends StatelessWidget {
  const _Detail({
    required this.rank,
    required this.rewardName,
    required this.point,
    required this.text,
  });

  final String rank;
  final String rewardName;
  final int point;
  final String text;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 36),
      margin: const EdgeInsets.only(top: 16),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: gray5),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                rank,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              horizontalSpaceTiny,
              const Text("プラン", style: TextStyle(fontSize: 16)),
            ],
          ),
          verticalSpaceMedium,
          Text(
            rewardName,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                formatter.format(point),
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: primaryColor),
              ),
              const Text(
                ' ポイント',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          verticalSpaceLarge,
          Text(text),
          verticalSpaceLarge,
          const Image(
            image: AssetImage('assets/images/other_child_care.png'),
            height: 130,
          )
        ],
      ),
    );
  }
}

class _RewardButton extends GetView<RewardDetailViewController> {
  const _RewardButton({
    required this.rewardId,
    required this.rewardName,
    required this.point,
    required this.isMe,
    required this.isAvailable,
  });

  final int rewardId;
  final String rewardName;
  final int point;
  final bool isMe;
  final bool isAvailable;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RewardDetailViewController(rewardId: rewardId));
    return PrimaryButton(
      label: isMe ? 'ねぎらってもらう！' : 'ねぎらう！',
      isValid: isAvailable,
      onPressed: () {
        if (isMe) {
          Get.dialog(
            RewardRequestDialog(
              rewardName: rewardName,
              point: point,
              onPressed: () async {
                await controller.onTapRequest(rewardId: rewardId);
                Get.back();
                Get.dialog(const RewardCompletedDialog(message: 'ねぎらいリクエストを\n送りました！'));
              },
            ),
          );
        } else {
          Get.dialog(
              RewardCompleteDialog(
                rewardId: rewardId,
                rewardName: rewardName,
              )
          );
        }
      },
      // onPressed: () {
      //   showDialog(
      //       context: context,
      //       builder: (_) {
      //         if (isMe) {
      //           return RewardRequestDialog(
      //             rewardName: rewardName,
      //             point: point,
      //             onPressed: () {
      //               controller.onTapRequest(rewardId: rewardId);
      //               Navigator.pop(context, true);
      //             },
      //           );
      //         } else {
      //           return RewardCompleteDialog(
      //             rewardId: rewardId,
      //             rewardName: rewardName,
      //           );
      //         }
      //       }).then((value) {
      //     if (value) {
      //       if (isMe) {
      //         return Get.dialog(const RewardCompletedDialog(message: 'ねぎらいリクエストを\n送りました！'));
      //       } else {
      //         return Get.dialog(const RewardCompletedDialog(message: 'ねぎらいを完了しました！'));
      //       }
      //     }
      //   });
      // },
    );
  }
}

class _RewardHistoryDetail extends StatelessWidget {
  const _RewardHistoryDetail(
      {required this.rewardName,
      required this.message,
      required this.userImageUrl,
      required this.date,
      required this.point});

  final String rewardName;
  final String message;
  final String userImageUrl;
  final String date;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black12, //枠線の色
              width: 1, //枠線の太さ
            ),
          ),
          color: Colors.white),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rewardName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(date)
            ],
          ),
          verticalSpaceSmall,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CajicoCachedNetworkIconImage(imageUrl: userImageUrl, radius: 20),
                  horizontalSpaceSmall,
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: Text(message, style: const TextStyle(fontSize: 13)),
                  ),
                ],
              ),
              Text('${point}P', style: const TextStyle(fontSize: 24, color: primaryColor)),
            ],
          )
        ],
      ),
    );
  }
}
