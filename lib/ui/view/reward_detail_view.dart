import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/colored_tab_bar.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import '../common/ui_helper.dart';
import '../widget/reward_request_completed_dialog.dart';
import '../widget/reward_request_dialog.dart';

class RewardDetailView extends StatelessWidget {
  const RewardDetailView({
    super.key,
    required this.imageUrl,
    required this.rank,
    required this.rewardName,
    required this.point,
    required this.text,
  });
  final String imageUrl;
  final String rank;
  final String rewardName;
  final int point;
  final String text;

  @override
  Widget build(BuildContext context) {
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
                  image: DecorationImage(
                    image: AssetImage(imageUrl),
                    fit: BoxFit.fitWidth
                  )
                ),
              ),
              actions: <Widget>[
                PopupMenuButton(
                    offset: const Offset(0, 50),
                    itemBuilder: (BuildContext context) {
                      return [
                        const PopupMenuItem(child: Text('編集する')),
                      ];
                    }
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
              )
            ),
          ),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView (
                child: Column(
                  children: [
                    _Detail(rewardName: rewardName, text: text, point: point, rank: rank),
                    verticalSpaceMedium,
                    PrimaryButton(
                      label: 'ねぎらってもらう！',
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return RewardRequestDialog(rewardName: rewardName, point: point);
                            }).then((value) {
                              if (value == true) {
                                return showDialog(context: context,builder: (context) => const RewardRequestCompletedDialog());
                              }
                            });
                        },
                    )
                  ],
                )
              ),
            ),
            SingleChildScrollView (
              child: Column(
                children: [
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                  _RewardHistoryDetail(rewardName: rewardName, date: '2022年10月11日', userImageUrl: 'assets/images/woman.png', message: 'いつも家事をしてくれてありがとう！ほんのお礼です', point: point),
                ],
              ),
            ),
          ]
        )
      ),
    );
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("ごほうび", style: TextStyle(fontSize: 16)),
              Text("「$rank」", style: const TextStyle(fontSize: 20),
              ),
            ],
          ),
          verticalSpaceSmall,
          Text(
            rewardName,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold
            ),
          ),
          verticalSpaceLarge,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                point.toString(),
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: primaryColor
                ),
              ),
              const Text(
                ' ポイント',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                ),
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

class _RewardHistoryDetail extends StatelessWidget {
  const _RewardHistoryDetail({
    required this.rewardName,
    required this.message,
    required this.userImageUrl,
    required this.date,
    required this.point
});
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
          color: Colors.white
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                rewardName,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold
                ),
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
                  const CircleAvatar(
                    radius: 20,
                    backgroundImage: AssetImage('assets/images/woman.png'),
                  ),
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
