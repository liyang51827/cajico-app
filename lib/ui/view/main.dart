import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          ),
          drawer: const _HomeDrawer(),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                Text(
                  'You have pushed the button this many tim',
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
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
