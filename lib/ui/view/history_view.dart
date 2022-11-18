import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';
import '../common/ui_helper.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: Row(
              children: const [
                Image(
                  image: AssetImage(
                    'assets/images/logo_history.png',
                  ),
                  height: 55,
                ),
                Text('家事履歴'),
              ]
          ),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
              color: gray2,
              fontSize: 22
          ),
          actions: const [
            NotificationAction(),
          ],
          bottom: TabBar(
            labelColor: gray2,
            indicatorColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 16),
            tabs: <Widget>[
              const Tab(text: '全て'),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/app/icon.png'),
                    ),
                    horizontalSpaceSmall,
                    Text('かつのり'),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      radius: 12,
                      backgroundImage: AssetImage('assets/app/icon.png'),
                    ),
                    horizontalSpaceSmall,
                    Text('えりか'),
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: const HomeDrawer(),
        body: TabBarView(
          children: [
            SingleChildScrollView (
              child: Column(
                children: const [
                  _PointSummaries(),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                ],
              ),
            ),
            SingleChildScrollView (
              child: Column(
                children: const [
                  _PointSummaries(),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                ],
              ),
            ),
            SingleChildScrollView (
              child: Column(
                children: const [
                  _PointSummaries(),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cooking.png",categoryName: "料理",houseWorkName: "晩ごはん支度",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/shopping.png",categoryName: "買い物",houseWorkName: "晩ごはん材料買い出し",userIconImageUrl: "assets/app/icon.png", time: "16:00", point: 100),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/washing.png",categoryName: "洗濯",houseWorkName: "洗濯物を棚にしまう",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/cleaning.png",categoryName: "掃除",houseWorkName: "リビングと部屋の掃除",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                  _HouseWorkDetail(categoryImageUrl: "assets/images/trash.png",categoryName: "ゴミ出し",houseWorkName: "粗大ごみだし",userIconImageUrl: "assets/app/icon.png", time: "18:00", point: 150),
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}

class _PointSummaries extends StatelessWidget {
  const _PointSummaries();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: const [
          _PointSummary(title: "今日", point: 470),
          _PointSummary(title: "累計", point: 5800),
        ],
      ),
    );
  }
}

class _PointSummary extends StatelessWidget {
  const _PointSummary({
    required this.title,
    required this.point,
  });
  final String title;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
              fontSize: 18,
              color: gray2
          ),
        ),
        horizontalSpaceSmall,
        Text(
          '${point}P',
          style: const TextStyle(
              fontSize: 30,
              color: gray2
          ),
        ),
      ],
    );
  }
}

class _HouseWorkDetail extends StatelessWidget {
  const _HouseWorkDetail({
    required this.categoryImageUrl,
    required this.categoryName,
    required this.houseWorkName,
    required this.userIconImageUrl,
    required this.time,
    required this.point
});
  final String categoryImageUrl;
  final String categoryName;
  final String houseWorkName;
  final String userIconImageUrl;
  final String time;
  final int point;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Colors.black12, //枠線の色
            width: 1, //枠線の太さ
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image(image: AssetImage(categoryImageUrl)),
              horizontalSpaceTiny,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    categoryName,
                    style: const TextStyle(
                        fontSize: 12,
                        color: gray2
                    ),
                  ),
                  Text(
                    houseWorkName,
                    style: const TextStyle(
                        fontSize: 16,
                        color: gray2
                    ),
                  )
                ],
              ),
            ],
          ),
          Row(
            children: [
              CircleAvatar(
                radius: 15,
                backgroundImage: AssetImage(userIconImageUrl),
              ),
              horizontalSpaceSmall,
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                        fontSize: 16,
                        color: gray2
                    ),
                  ),
                  Text(
                    "${point}P",
                    style: const TextStyle(
                        fontSize: 20,
                        color: gray2
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
