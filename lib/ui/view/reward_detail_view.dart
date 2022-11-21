import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/colored_tab_bar.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:cajico_app/ui/widget/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import '../common/ui_helper.dart';
import '../widget/reward_category_card.dart';

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
              actions: const [_Option()],
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
                    const PrimaryButton(label: 'ねぎらってもらう！')
                  ],
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView (
                child: _Detail(rewardName: rewardName, text: text, point: point, rank: rank)
              ),
            ),
          ]
        )
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Icon(
        LineIcons.horizontalEllipsis,
        size: 30,
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
              const Text(
                "ごほうび",
                style: TextStyle(
                    fontSize: 16,
                    color: gray2
                ),
              ),
              Text(
                "「$rank」",
                style: const TextStyle(
                    fontSize: 20,
                    color: gray2
                ),
              ),
            ],
          ),
          verticalSpaceSmall,
          Text(
            rewardName,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: gray2
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
                    fontWeight: FontWeight.bold,
                    color: gray2
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
