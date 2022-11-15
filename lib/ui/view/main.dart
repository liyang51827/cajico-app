import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
import 'package:cajico_app/ui/widget/category_card.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:line_icons/line_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'CAJICO',
      home: HouseWork(),
    );
  }
}

class HouseWork extends StatefulWidget {
  const HouseWork({super.key});

  @override
  State<HouseWork> createState() => _HouseWorkState();
}

class _HouseWorkState extends State<HouseWork> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: Row(
              children: const [
                Image(
                  image: AssetImage(
                    'assets/images/logo.png',
                  ),
                  height: 55,
                ),
                Text('家事をする'),
              ]
            ),
            backgroundColor: Colors.white,
            titleTextStyle: const TextStyle(
                color: gray2,
                fontSize: 22
            ),
            actions: [
              _NotificationAction(),
            ],
          ),
          drawer: const HomeDrawer(),
          body: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 16),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'ジャンルから選ぶ',
                    style: TextStyle(
                      color: gray2,
                      fontSize: 16
                    ),
                  ),
                ),
                const _CategoryCards(),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.only(top: 24),
                  child: const Text(
                    '最近の家事から選ぶ',
                    style: TextStyle(
                        color: gray2,
                        fontSize: 16
                    ),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: const Footer(),
        )
      ],
    );
  }
}

class _NotificationAction extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      child: Icon(
          LineIcons.bell,
          size: 30,
      ),
    );
  }
}

class _CategoryCards extends StatelessWidget {
  const _CategoryCards();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(categoryName: '料理', imageUrl: 'assets/images/cooking.png'),
            horizontalSpaceSmall,
            CategoryCard(categoryName: '買い物', imageUrl: 'assets/images/shopping.png'),
            horizontalSpaceSmall,
            CategoryCard(categoryName: '洗濯', imageUrl: 'assets/images/washing.png'),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(categoryName: '掃除', imageUrl: 'assets/images/cleaning.png'),
          horizontalSpaceSmall,
            CategoryCard(categoryName: 'お迎え', imageUrl: 'assets/images/pick_up.png'),
          horizontalSpaceSmall,
            CategoryCard(categoryName: '子守', imageUrl: 'assets/images/baby_sitting.png'),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CategoryCard(categoryName: 'ゴミ出し', imageUrl: 'assets/images/trash.png'),
            horizontalSpaceSmall,
            CategoryCard(categoryName: 'その他家事', imageUrl: 'assets/images/other_house_work.png'),
            horizontalSpaceSmall,
            CategoryCard(categoryName: 'その他育児', imageUrl: 'assets/images/other_child_care.png'),
          ],
        ),
      ],
    );
  }
}
