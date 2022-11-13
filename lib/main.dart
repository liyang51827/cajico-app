import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'Flutter Demo',
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
              child: Container(
                alignment: Alignment.bottomLeft,
                child: const Image(
                  image: AssetImage(
                    'assets/images/logo_drawer.png'
                  ),
                  height: 70,
                ),
              )
            ),
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/human.svg',
              color: Colors.brown,
            ),
            title: const Text('マイページ'),
            onTap: () => false,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/invite.svg',
              color: Colors.brown,
            ),
            title: const Text('ご意見箱'),
            onTap: () => false,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/chat_help.svg',
              color: Colors.brown,
            ),
            title: const Text('利用規約'),
            onTap: () => false,
          ),
          ListTile(
            leading: SvgPicture.asset(
              'assets/icons/chat_help.svg',
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
