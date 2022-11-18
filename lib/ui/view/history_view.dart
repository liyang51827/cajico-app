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
          bottom: const TabBar(
            labelColor: Colors.black87,
            indicatorColor: Colors.orange,
            labelStyle: TextStyle(fontSize: 16),
            tabs: <Widget>[
              Tab(
                  text: '全て'
              ),
              Tab(
                  text: 'かつのり'
              ),
              Tab(
                  text: 'えりか'
              ),
            ],
          ),
        ),
        drawer: const HomeDrawer(),
        body: TabBarView(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView (
                child: Column(
                  children: const [
                    _PointSummaries(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView (
                child: Column(
                  children: const [
                    _PointSummaries(),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: SingleChildScrollView (
                child: Column(
                  children: const [
                    _PointSummaries(),
                  ],
                ),
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
              color: Colors.black87
          ),
        ),
        horizontalSpaceSmall,
        Text(
          '${point}P',
          style: const TextStyle(
              fontSize: 30,
              color: Colors.black87
          ),
        ),
      ],
    );
  }
}
