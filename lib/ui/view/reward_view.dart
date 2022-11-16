import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: Row(
              children: const [
                Image(
                  image: AssetImage(
                    'assets/images/logo_reward.png',
                  ),
                  height: 55,
                ),
                Text('ごほうび'),
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
                  text: 'かつのり'
              ),
              Tab(
                  text: 'えりか'
              ),
            ],
          ),
        ),
        drawer: const HomeDrawer(),
        body: const TabBarView(
          children: <Widget>[
            Center(
              child: Text('かつのり', style: TextStyle(fontSize: 32.0)),
            ),
            Center(
              child: Text('えりか', style: TextStyle(fontSize: 32.0)),
            ),
          ],
        ),
        bottomNavigationBar: const Footer(),
      ),
    );
  }
}
