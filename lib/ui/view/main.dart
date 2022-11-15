import 'package:cajico_app/constant/app_size.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/common/ui_helper.dart';
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          drawer: const _HomeDrawer(),
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
          bottomNavigationBar: SizedBox(
            height: 60,
            child: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.gift),
                  label: 'ごほうび',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.campground),
                  label: '家事',
                ),
                BottomNavigationBarItem(
                  icon: Icon(LineIcons.history),
                  label: '履歴',
                ),
              ],
              iconSize: 26,
              currentIndex: 1,
              selectedItemColor: Colors.amber[600],
            ),
          ),
        )
      ],
    );
  }
}

class _HomeDrawer extends StatelessWidget {
  const _HomeDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: 120,
            child: DrawerHeader(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.bottomLeft,
                    child: const Image(
                      image: AssetImage(
                        'assets/images/logo_drawer.png'
                      ),
                      height: 70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 20, left: 8),
                    child: const Text(
                        'メニュー',
                        style: TextStyle(
                        fontSize: 24,
                        color: Colors.black54
                      ),
                    ),
                  )
                ],
              )
            ),
          ),
          ListTile(
            leading: const Icon(
                LineIcons.user,
                color: Colors.brown,
            ),
            title: const Text('マイページ'),
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              LineIcons.envelope,
              color: Colors.brown,
            ),
            title: const Text('ご意見箱'),
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              LineIcons.book,
              color: Colors.brown,
            ),
            title: const Text('利用規約'),
            onTap: () => false,
          ),
          ListTile(
            leading: const Icon(
              LineIcons.key,
              color: Colors.brown,
            ),
            title: const Text('プライバシーポリシー'),
            onTap: () => false,
          ),
        ],
      ),
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
            _CategoryCard(categoryName: '料理', imageUrl: 'assets/images/cooking.png'),
            horizontalSpaceSmall,
            _CategoryCard(categoryName: '買い物', imageUrl: 'assets/images/shopping.png'),
            horizontalSpaceSmall,
            _CategoryCard(categoryName: '洗濯', imageUrl: 'assets/images/washing.png'),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _CategoryCard(categoryName: '掃除', imageUrl: 'assets/images/cleaning.png'),
          horizontalSpaceSmall,
            _CategoryCard(categoryName: 'お迎え', imageUrl: 'assets/images/pick_up.png'),
          horizontalSpaceSmall,
            _CategoryCard(categoryName: '子守', imageUrl: 'assets/images/baby_sitting.png'),
          ],
        ),
        verticalSpaceSmall,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            _CategoryCard(categoryName: 'ゴミ出し', imageUrl: 'assets/images/trash.png'),
            horizontalSpaceSmall,
            _CategoryCard(categoryName: 'その他家事', imageUrl: 'assets/images/other_house_work.png'),
            horizontalSpaceSmall,
            _CategoryCard(categoryName: 'その他育児', imageUrl: 'assets/images/other_child_care.png'),
          ],
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  const _CategoryCard({
    required this.categoryName,
    required this.imageUrl,
  });

  final String categoryName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2.0),
      width: MediaQuery.of(context).size.width * 0.28, // SEでも対応できるギリギリのサイズ
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(
            categoryName,
            style: const TextStyle(
                fontSize: 16,
                color: Colors.black87
            ),
          ),
          Image(
            image: AssetImage(imageUrl),
            height: 70,
          ),
        ],
      ),
    );
  }
}
