import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_balloon/speech_balloon.dart';
import '../common/app_color.dart';
import '../view/reward_detail_view.dart';
import 'package:intl/intl.dart';

class RewardCategoryCard extends StatelessWidget {
  const RewardCategoryCard({
    super.key,
    required this.rank,
    required this.rewardId,
    required this.rewardName,
    required this.rating,
    required this.ownedPoint,
    required this.requiredPoint,
    required this.differencePoint,
    required this.imageUrl,
    required this.isRequesting,
    required this.isMe,
    required this.isAvailable,
    required this.note,
    required this.minPoint,
    required this.maxPoint,
  });

  final String rank;
  final int rewardId;
  final String rewardName;
  final double rating;
  final int ownedPoint;
  final int requiredPoint;
  final int differencePoint;
  final String imageUrl;
  final bool isRequesting;
  final bool isMe;
  final bool isAvailable;
  final String note;
  final int minPoint;
  final int maxPoint;

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat("#,###");
    return InkWell(
      onTap: () => Get.to(
        () => RewardDetailView(
          minPoint: minPoint,
          maxPoint: maxPoint,
          rewardId: rewardId,
          imageUrl: imageUrl,
          rewardName: rewardName,
          rank: rank,
          point: requiredPoint,
          isMe: isMe,
          isRequesting: isRequesting,
          isAvailable: isAvailable,
          text: note,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 170,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(imageUrl),
            fit: BoxFit.cover,
            colorFilter: const ColorFilter.mode(
              Colors.black26,
              BlendMode.srcATop,
            ), //
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          rank,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        horizontalSpaceTiny,
                        const Text(
                          "プラン",
                          style: TextStyle(
                              fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        Text(
                          rewardName,
                          style: const TextStyle(
                              fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
                (() {
                  if (isRequesting) {
                    return SpeechBalloon(
                      nipLocation: NipLocation.left,
                      color: secondaryColor,
                      height: 60,
                      width: 60,
                      borderRadius: 40,
                      offset: const Offset(20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 40,
                            child: Text(
                              'ねぎらい\n待ち',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (differencePoint > 0) {
                    return SpeechBalloon(
                      nipLocation: NipLocation.left,
                      height: 60,
                      // マルなので同じheightとwidth
                      width: 60,
                      borderRadius: 40,
                      offset: const Offset(20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            width: 35,
                            child: Text(
                              'あと',
                              style: TextStyle(color: gray2, fontSize: 10),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Text("${formatter.format(differencePoint)}P"),
                        ],
                      ),
                    );
                  } else {
                    return SpeechBalloon(
                      nipLocation: NipLocation.left,
                      color: primaryColor,
                      height: 60,
                      width: 60,
                      borderRadius: 40,
                      offset: const Offset(20, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            width: 35,
                            child: Text(
                              '達成',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                })(),
              ],
            ),
            verticalSpaceMedium,
            verticalSpaceLarge,
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: rating,
                color: secondaryColor,
                backgroundColor: Colors.white,
                minHeight: 8,
              ),
            ),
            verticalSpaceTiny,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Text(
                      "保有ポイント",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(
                      "${formatter.format(ownedPoint)}P",
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "必要ポイント",
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                    Text(
                      "${formatter.format(requiredPoint)}P",
                      style: const TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
