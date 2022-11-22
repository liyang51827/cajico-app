import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_balloon/speech_balloon.dart';
import '../common/app_color.dart';
import '../view/reward_detail_view.dart';

class RewardCategoryCard extends StatelessWidget {
  const RewardCategoryCard({
    super.key,
    required this.rank,
    required this.rewardName,
    required this.rating,
    required this.ownedPoint,
    required this.requiredPoint,
    required this.differencePoint,
    required this.imageUrl
  });

  final String rank;
  final String rewardName;
  final double rating;
  final int ownedPoint;
  final int requiredPoint;
  final int differencePoint;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:  () => Get.to(RewardDetailView(imageUrl: imageUrl, rewardName: rewardName, rank: rank, point: requiredPoint, text: 'コンビニで手軽なスナック菓子を買ってもらえる！',)),
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
            )
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
                      children: [
                        const Text(
                          "ごほうび",
                          style: TextStyle(
                              fontSize: 12,
                              color: Colors.white
                          ),
                        ),
                        Text(
                          "「$rank」",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                    verticalSpaceSmall,
                    Row(
                      children: [
                        Text(
                          rewardName,
                          style: const TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SpeechBalloon(
                  nipLocation: NipLocation.left,
                  height: 60, // マルなので同じheightとwidth
                  width: 60,
                  borderRadius: 40,
                  offset: const Offset(20,0),
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
                      Text("${differencePoint}P"),
                    ],
                  ),
                )
              ],
            ),
            verticalSpaceMedium,
            verticalSpaceLarge,
            ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: LinearProgressIndicator(
                value: rating,
                color: Colors.yellow[600],
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
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      "${ownedPoint}P",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      "必要ポイント",
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.white
                      ),
                    ),
                    Text(
                      "${requiredPoint}P",
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white
                      ),
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
